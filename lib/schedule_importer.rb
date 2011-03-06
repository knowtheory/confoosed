require 'open-uri'
require 'nokogiri'
require 'date'

schedule_data = Nokogiri::HTML(open("http://confoo.ca/en/2011/schedule"))
dates  = schedule_data.css('#schedule h2').map do |h2|
  month, day, year = h2.text.split(/[\(\)]/)[1].split('/').map(&:to_i)
  year += 2000
  [year, month, day] # list date components in descending order for DateTime creation
end
date_index = 0 # no way to keep days and sessions in sync other than co-iteration.
sessions = schedule_data.css('#schedule .schedule_day').map do |day|
  days_sessions = day.css('tr').map do |slot| # have to assign day_sessions because of co-iteration
    # table header for each row contains only a start time and an end time.
    start_at, end_at = slot.css('th').text.split.map do |slot_time|
      DateTime.new(*dates[date_index], *slot_time.split(":").map(&:to_i), 0, 5.0/24)
    end
    
    if slot.css('div').size == 0 # sessions have divs, breaks don't
      { :name => slot.css('td').text.strip, :start_at => start_at, :end_at => end_at }
    else
      # some rows have fewer than 8 sessions, and so contain empty tds. discard them and
      # return a hash for each session
      slot.css('td').reject{ |cell| cell.text =~ /\A\W+\z/ }.map do |session|
        name_data = session.css('div.session a').first # there is always 1 and only 1 <a> per session
        { :name     => name_data.text.strip,
          :url      => name_data.attributes['href'].text,
          :tags     => session.css('div.tags span.tag').map { |tag| Tag.first_or_new(:name=>tag.text.strip.gsub(/\s+/,' ')) },
          :speakers => session.css('div.speaker a').map do |speaker_data|
                         { :name => speaker_data.text.strip, :url => speaker_data.attributes['href'].text }
                       end,
          :start_at => start_at, 
          :end_at => end_at
        }
      end
    end
  end
  date_index += 1
  days_sessions
end.flatten

# Todo: merge record creation into loop above, and eliminate explicit index using Array#each_with_index
sessions.each do |session|
  options            = session.dup 
  options[:speakers] = session[:speakers].map{ |s| Confoosed::Speaker.first_or_new(s) } if session[:speakers]
  options[:tags]     = session[:tags].map{ |t| Tag.first_or_new(t) } if session[:tag]
  Confoosed::Session.create(options)
end

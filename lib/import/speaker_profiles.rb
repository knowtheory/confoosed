require 'net/http'
require 'nokogiri'
require 'date'

Net::HTTP.start("confoo.ca") do |confoo|
  Confoosed::Speaker.all.each do |speaker|
    puts "Fetching profile for #{speaker.name}"
    response = confoo.get(speaker.url)
    speaker_page = Nokogiri::HTML(response.body)
    container = speaker_page.css('div.speakers')
    speaker.headshot = "http://confoo.ca" + container.css('img:first-child').first.attributes['src'].text
    speaker.profile  = container.children[container.children.index(container.css('img:first-child').first) + 1].text
    container.css('div.social-medias ul li.twitter').map do |li|
      speaker.twitter = li.css("a").attributes["href"].split("/").last
    end
    speaker.save
  end
end

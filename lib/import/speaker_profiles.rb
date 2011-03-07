require 'net/http'
require 'nokogiri'
require 'date'

Net::HTTP.start("confoo.ca") do |confoo|
  Confoosed::Speaker.all.each do |speaker|
    puts "Fetching profile for #{speaker.name}"
    response = confoo.get(speaker.url)
    speaker_page = Nokogiri::HTML(response.body)
    speaker.affiliation = speaker_page.css('h1 + h3').text.strip
    container = speaker_page.css('div.speakers')
    speaker.photo_url = "http://confoo.ca" + container.css('img:first-child').first.attributes['src'].text
    speaker.profile  = container.children[container.children.index(container.css('img:first-child').first) + 1].text.strip
    container.css('div.social-medias ul li.twitter').map do |li|
      speaker.twitter = li.css("a").first.attributes["href"].text.split("/").last
    end
    speaker.save
  end
end

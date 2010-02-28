require 'rubygems'
require 'open-uri'
require 'nokogiri'

require 'date_helpers'
include DateHelpers

url = 'http://ws.audioscrobbler.com/1.0/user/RichGuk/recenttracks.rss'
filename = File.join(File.dirname(__FILE__), '..', '_includes', 'lastfm.html')

doc = Nokogiri::XML(open(url))

File.open(filename, 'w') do |f|
  f.puts '<ul class="lastfm_feed">'
  doc.xpath('.//item').slice(0..5).each do |item|
    title = item.at_xpath('title').text
    link = item.at_xpath('link').text
    date = item.at_xpath('pubDate').text

    f.puts %Q{\t<li><a href="#{link}">#{title}</a> #{time_ago_in_words(Time.parse(date))} ago</li>}
  end
  f.puts '</ul>'
end
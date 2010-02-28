require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = 'http://api.flickr.com/services/feeds/photos_public.gne?id=39828812@N00&tags=27s&lang=en-us&format=rss_200'
filename = File.join(File.dirname(__FILE__), '..', '_includes', 'flickr.html')

doc = Nokogiri::XML(open(url))
File.open(filename, 'w') do |f|
  f.puts '<div class="flickr_photos">'

  doc.xpath('.//item').sort_by { rand }.slice(0..5).each do |item|
    thumbnail =  item.at_xpath('media:thumbnail')['url']
    link = item.at_xpath('link').text
    title = item.at_xpath('title').text

    f.puts %Q{<span class="flickr_image"><a href="#{link}" title="#{title}"><img src="#{thumbnail}" alt="#{title}" /></a></span>}
  end

  f.puts '</div>'
end
$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'time'
require 'patron'
require 'nokogiri'

require 'date_helpers'
include DateHelpers

# Setup where we're saving the output.
filename = File.join(
  File.dirname(__FILE__), '..', '_includes', 'twitter.html')
twitter_cache = File.join(
  File.dirname(__FILE__), '..', '_includes', 'twitter.cache')

cache = Marshal.load(File.open(twitter_cache, 'r')) if
  File.exists?(twitter_cache)

# Setup http session stuff.
sess = Patron::Session.new
sess.timeout = 30
sess.base_url = 'http://twitter.com'
if cache
  sess.headers['If-Modified-Since'] = cache[:last_modified].utc
  sess.headers['If-None-Match'] = cache[:etag]
end
resp = sess.get '/statuses/user_timeline/14274164.rss'

if resp.status == 200
  doc = Nokogiri::XML(resp.body)

  File.open(filename, 'w') do |f|
    f.puts '<ul class="twitter_feed">'
    doc.xpath('.//item').slice(0..5).each do |item|
      desc = item.at_xpath('description').text
      desc = desc.gsub(/(.+): /, '')

      link = item.at_xpath('link').text
      date = item.at_xpath('pubDate').text

      # Skip items that start with @ don't need those on the site =)
      unless desc =~ /^@/
        # Link up @username
        desc.gsub!(/(?!\s+)@([A-Za-z0-9_]+)/, '<a class="user" href="http://twitter.com/\1">@\1</a>')
        # Link up hashtags.
        desc.gsub!(/#([A-Za-z0-9_]+)/,
          '<a class="hash" href="http://twitter.com/#search?q=%23\1">#\1</a>')
       # Finally convert new lines to br's
       desc.gsub!(/\n/, '<br />')
        f.puts %Q{\t<li>#{desc} <a href="#{link}">#{time_ago_in_words(Time.parse(date))} ago</a></li>}
      end
    end
    f.puts '</ul>'
  end

  cache = File.open(twitter_cache, 'w+') do |f|
    Marshal.dump({
      :last_modified => Time.httpdate(resp.headers['Last-Modified']),
      :etag => resp.headers['ETag'] }, f)
  end
end
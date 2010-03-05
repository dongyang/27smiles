require 'rake'
require 'spec/rake/spectask'

task :deploy => [
  'services:twitter', 'services:flickr', 'services:lastfm', :jekyll
]

namespace :services do
  desc 'Generate Twitter include file'
  task :twitter do
    ruby '_scripts/twitter.rb'
  end

  desc 'Generate Flickr include file'
  task :flickr do
    ruby '_scripts/flickr.rb'
  end

  desc 'Generate Last.fm include file'
  task :lastfm do
    ruby '_scripts/lastfm.rb'
  end

  desc 'Send ping request to Pingomatic'
  task :pingomatic do
    ruby '_scripts/pingomatic.rb'
  end
end

file '_site/index.html' => FileList['_includes/*.html'] do
  ruby '../jekyll/bin/jekyll'
end
task :jekyll => '_site/index.html'
require 'rubygems'

# Set up the ImageMagick bin path for installations with brew and ports
ENV['PATH'] = [ENV['PATH'], "/usr/local/bin", "/opt/local/bin"].join(':')
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

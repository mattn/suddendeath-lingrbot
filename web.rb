# -*- coding: utf-8 -*-
require 'bundler'
require 'json'

Dir.chdir File.dirname(__FILE__)
Bundler.require
set :environment, :production

get '/' do
  "突然の死"
end

get '/:text' do
  "<title>\n#{params[:text].sudden_death.rstrip}</title>"
end

post '/lingr' do
  json = JSON.parse(request.body.string)
  ret = ""
  json["events"].each do |e|
    text = e['message']['text']
    case text
    when /^((?:突然の)*)(突然の.+)$/
      ret = $2
      ("#{$1}".length/3+1).times do
        ret = ret.sudden_death 
      end
    when /^(>+)(.+?)(<+)$/m
      if "#{$1}".length == "#{$3}".length
        ret = $2
        $1.length.times do
          ret = ret.sudden_death 
        end
      end
    when /^<([^a-zA-Z0-9>]+)>$/
      ret = ".｡oO(#{$1})"
    end
  end
  ret.rstrip
end

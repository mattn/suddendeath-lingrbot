# -*- coding: utf-8 -*-
require 'bundler'
Dir.chdir File.dirname(__FILE__)
Bundler.require
set :environment, :production

get '/' do
  "hello"
end

post '/lingr' do
  json = JSON.parse(request.body.string)
  ret = ""
  json["events"].each do |e|
    text = e['message']['text']
    if text =~ /^(突然の.+)$/ || text =~ /^>(.+)<$/
      ret = $1.sudden_death
    elsif text =~ /^<(.+)>$/
      ret = "#{$1} ... ってじっちゃんが言ってた"
    end
  end
  ret.rstrip
end

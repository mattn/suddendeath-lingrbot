# -*- coding: utf-8 -*-
require 'json'
require 'sinatra'
require 'sudden_death'

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
    end
  end
  ret.rstrip
end

# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/reloader'

FILE_PATH = 'db/memos.json'

get '/' do
  redirect '/memos'
end

get '/memos' do
  @title = 'top'
  erb :top
end

get '/new' do

end

post '/memos' do

end

get '/memos/:id' do |id|

end

delete '/memos/:id' do |id|

end

patch '/memos/:id' do |id|

end

get '/memos/:id/edit' do |id|

end

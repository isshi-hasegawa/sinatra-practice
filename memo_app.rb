# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'sinatra'
require 'sinatra/reloader'

JSON_PATH = 'db/memos.json'

class Memo
  def self.read
    Memo.save(memo_data = {}) unless File.exist?(JSON_PATH)
    File.open(JSON_PATH) do |f|
      JSON.parse(f.read)
    end
  end

  def self.save(memo_data)
    File.open(JSON_PATH, 'w') do |f|
      JSON.dump(memo_data, f)
    end
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @title = 'Topページ'
  @memos = Memo.read
  erb :top
end

get '/new' do
  @title = '新規作成ページ'
  erb :new
end

post '/memos' do
  memo_data = Memo.read
  id = SecureRandom.uuid
  memo_data[id.to_s] = { "title": params[:title], "content": params[:content] }
  Memo.save(memo_data)
  redirect '/memos'
end

get '/memos/:id' do |id|

end

delete '/memos/:id' do |id|

end

patch '/memos/:id' do |id|

end

get '/memos/:id/edit' do |id|

end

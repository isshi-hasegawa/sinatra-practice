# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'sinatra'
require 'sinatra/reloader'

FILE_PATH = 'db/memos.json'

class Memo
  def self.read
    Memo.save({}) unless File.exist?(FILE_PATH)
    File.open(FILE_PATH) do |f|
      JSON.parse(f.read)
    end
  end

  def self.save(memo_data)
    File.open(FILE_PATH, 'w') do |f|
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
  memo_data[id] = { "title": params[:title], "content": params[:content] }
  Memo.save(memo_data)
  redirect '/memos'
end

get '/memos/:id' do |id|
  @title = '詳細ページ'
  @id = id
  @memo = Memo.read[id]
  erb :show
end

get '/memos/:id/edit' do |id|
  @title = '編集ページ'
  @id = id
  @memo = Memo.read[id]
  erb :edit
end

patch '/memos/:id' do |id|
  memo_data = Memo.read
  updated_params = { "title": params[:title], "content": params[:content] }
  memo_data[id] = updated_params
  Memo.save(memo_data)
  redirect '/memos'
end

delete '/memos/:id' do |id|

end

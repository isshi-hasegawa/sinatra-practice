# frozen_string_literal: true

require 'cgi'
require 'pg'
require 'sinatra'
require 'sinatra/reloader'

class Memo
  @connect = PG.connect(dbname: 'sinatra_memo_app')

  def self.index
    @connect.exec('SELECT * FROM Memos')
  end

  def self.create(title, content)
    @connect.exec('INSERT INTO Memos (title, content) VALUES ($1, $2);', [title, content])
  end

  def self.show(id)
    @connect.exec('SELECT id, title, content FROM Memos WHERE id = $1;', [id]).first
  end

  def self.update(title, content, id)
    @connect.exec('UPDATE Memos SET title = $1, content = $2 WHERE id = $3;', [title, content, id])
  end

  def self.delete(id)
    @connect.exec('DELETE FROM Memos WHERE id = $1;', [id])
  end
end

helpers do
  def h(string)
    CGI.escapeHTML(string)
  end
end

get '/' do
  redirect '/memos'
end

get '/memos' do
  @title = 'SINATRA MEMO APP'
  @memos = Memo.index
  erb :top
end

get '/new' do
  @title = 'SINATRA MEMO APP | ADD'
  erb :new
end

post '/memos' do
  Memo.create(params[:title], params[:content])
  redirect '/memos'
end

get '/memos/:id' do |id|
  @title = 'SINATRA MEMO APP | MEMO'
  @memo = Memo.show(id)
  erb :show
end

get '/memos/:id/edit' do |id|
  @title = 'SINATRA MEMO APP | EDIT'
  @memo = Memo.show(id)
  erb :edit
end

patch '/memos/:id' do |id|
  Memo.update(params[:title], params[:content], id)
  redirect '/memos'
end

delete '/memos/:id' do |id|
  Memo.delete(id)
  redirect '/memos'
end

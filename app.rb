# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'securerandom'
require './memo'

get '/' do
  @memos = Memo.all
  erb :top
end

get '/memo' do
  erb :new_memo
end

post '/memo' do
  memo = Memo.new(title: params[:title], contents: params[:body])
  memo.add
  redirect to('/')
end

get '/memo/:id' do
  @memo = Memo.new(id: params[:id]).search
  erb :show_memo
end

delete '/memo/:id' do
  memo = Memo.new(id: params[:id]).search
  memo.delete
  redirect to('/')
end

get '/editor/:id' do
  @memo = Memo.new(id: params[:id]).search
  erb :edit_memo
end

patch '/memo/:id' do
  memo = Memo.new(id: params[:id], title: params[:title], contents: params[:contents])
  memo.update
  redirect to('/')
end

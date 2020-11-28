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
  memo = Memo.new(id: SecureRandom.uuid, title: params[:title], contents: params[:body])
  memo.add
  redirect to('/')
end

get '/memo/:memo_id' do
  @memo = Memo.new(id: params[:memo_id]).search
  erb :show_memo
end

delete '/memo/:memo_id' do
  memo = Memo.new(id: params[:memo_id]).search
  memo.delete
  redirect to('/')
end

get '/editor/:memo_id' do
  @memo = Memo.new(id: params[:memo_id]).search
  erb :edit_memo
end

patch '/memo/:memo_id' do
  memo = Memo.new(id: params[:memo_id], title: params[:title], contents: params[:contents])
  memo.update
  redirect to('/')
end

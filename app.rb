# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'securerandom'

DB_DIRECTORY = './db'
DB_DIRECTORY.freeze

def memos
  memos = []
  Dir.foreach(DB_DIRECTORY) do |f|
    if f.match(/.*\.json$/)
      File.open("#{DB_DIRECTORY}/#{f}") do |j|
        memos << JSON.parse(File.read(j))
      end
    end
  end
  memos
end

get '/' do
  @memos = memos
  erb :top
end

get '/memo' do
  erb :new_memo
end

post '/memo' do
  hash = {}
  memo_id = SecureRandom.uuid
  hash['memo_id'] = memo_id
  hash['title'] = params[:title]
  hash['body'] = params[:body]
  File.open("#{DB_DIRECTORY}/#{memo_id}.json", 'a') do |f|
    f.puts JSON.generate(hash)
    f.close
  end
  redirect to('/')
end

get '/memo/:memo_id' do
  @memo_id = params[:memo_id]
  @file_path = "./#{DB_DIRECTORY}/#{@memo_id}.json"
  @message = JSON.parse(File.read(@file_path)) if File.exist?(@file_path)
  erb :show_memo
end

delete '/memo/:memo_id' do
  memo_id = params[:memo_id]
  File.delete("#{DB_DIRECTORY}/#{memo_id}.json")
  redirect to('/')
end

patch '/memo/:memo_id' do
  memo_id = params[:memo_id]
  title = params[:title]
  body = params[:body]
  hash = JSON.parse(File.read("#{DB_DIRECTORY}/#{memo_id}.json"))
  hash['title'] = title
  hash['body'] = body
  File.open("#{DB_DIRECTORY}/#{memo_id}.json", 'w') do |f|
    f.puts(JSON.generate(hash))
    f.close
  end
  redirect to('/')
end

get '/editor/:memo_id' do
  @memo_id = params[:memo_id]
  @file_path = "./#{DB_DIRECTORY}/#{@memo_id}.json"
  @message = JSON.parse(File.read(@file_path)) if File.exist?(@file_path)
  erb :edit_memo
end

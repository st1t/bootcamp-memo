# frozen_string_literal: true

require 'pg'

DB_HOST = 'localhost'
DB_NAME = 'memo'
DB_USER = 'app_user'
DB_PASSWORD = 'changeme'

# Memo class is a class to store and manipulate memo information
class Memo
  attr_reader :id, :title, :contents

  def initialize(id: '', title: '', contents: '')
    @id = id
    @title = title
    @contents = contents
  end

  def all
    memos = []
    conn = pg_connect
    conn.exec_params('SELECT id, title, contents FROM memos') do |result|
      result.each do |row|
        memos << row
      end
    end
    memos
  end

  def add
    conn = pg_connect
    conn.exec_params("INSERT INTO memos (title, contents) VALUES('#{@title}','#{@contents}')")
  end

  def search
    conn = pg_connect
    conn.exec_params("SELECT title, contents FROM memos WHERE id = #{@id}") do |result|
      @title = result[0]['title']
      @contents = result[0]['contents']
    end
    self
  end

  def delete
    conn = pg_connect
    conn.exec_params("DELETE FROM memos WHERE id = '#{@id}'")
  end

  def update
    conn = pg_connect
    conn.exec_params("UPDATE memos SET title = '#{@title}', contents = '#{@contents}' WHERE id = '#{@id}'")
  end

  private

  def pg_connect
    # https://deveiate.org/code/pg/PG/Connection.html#method-c-new
    PG.connect(host: DB_HOST, dbname: DB_NAME, user: DB_USER, password: DB_PASSWORD)
  end
end

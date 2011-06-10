require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'rails/all'
require 'sqlite3'
gem 'activerecord', '= 3.0.7'

ENV["RAILS_ENV"] ||= 'test'
Rails.env = 'test'

require 'textr'

MY_DB_NAME = "test.db"
MY_DB = SQLite3::Database.new(MY_DB_NAME)
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => MY_DB_NAME)

class User < ActiveRecord::Base
  extends_textr
end

class Company < ActiveRecord::Base
  extends_textr
end

class Person < ActiveRecord::Base
  extends_textr :number
end

ActiveRecord::Schema.define(:version => 1) do
  unless User.table_exists? 
    create_table :users do |t|
      t.string :name
      t.string :phone
    end
    
    User.create({:name => 'foo', :phone => '123-456-7890'})
  end
  
  unless Company.table_exists? 
    create_table :companies do |t|
      t.string :name
    end
    
    Company.create({:name => 'bar'})
  end
  
  unless Person.table_exists? 
    create_table :people do |t|
      t.string :name
      t.string :number
    end
    
    Person.create({:name => 'foo', :number => '184-617-3344'})
  end
end

RSpec.configure do |config|
  
end
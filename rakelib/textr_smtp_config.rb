require 'rake'
require 'textr/task'

desc "Run all examples"
Textr::Rake::TextrTask.new('examples') do |t|
  10.times { puts "hello world" }
end
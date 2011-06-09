#!/usr/bin/env ruby

require 'rake'
require 'rake/tasklib'

module Textr
  module Rake

    class TextrTask < ::Rake::TaskLib
      
      namespace :textr do
        desc "Remove rcov products for "
        task "create_config:smtp" do
          10.times { puts "boom" }
        end
      end
      
    end
    
  end
end
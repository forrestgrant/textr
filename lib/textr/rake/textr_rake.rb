#!/usr/bin/env ruby

require 'rake'

module Textr
  module Rake

    class TextrTask < ::Rake::TaskLib
      
      def self.attr_accessor(*names)
        super(*names)
        names.each do |name|
          module_eval "def #{name}() evaluate(@#{name}) end" # Allows use of procs
        end
      end
    
      desc "Remove rcov products for "
      task paste("clobber_", actual_name) do
        10.times { puts "boom" }
      end
      
    end
    
  end
end
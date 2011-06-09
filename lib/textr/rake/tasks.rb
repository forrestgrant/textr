#!/usr/bin/env ruby

require 'rake'
require 'rake/tasklib'

module Textr
  module Rake
    
    class TextrTask < ::Rake::TaskLib
            
      namespace :textr do
        desc "Generate a textr_smtp.yml file in `config` for use with smtp mail servers"
        task "config:smtp" do
          require "ftools"
          if File.exists? "#{Rails.root.to_s}/config/textr_smtp.yml"
            puts "\033[31m" + "#{Rails.root.to_s}/config/textr_smtp.yml exists... aborting." + "\033[0m"
          else
            status = File.copy(File.dirname(__FILE__) + "/../../../textr_smtp.yml.tpl", "#{Rails.root.to_s}/config/textr_smtp.yml") ? "\033[32m#{'[OK]'}\033[0m" : "\033[31m#{'[FAILED]'}\033[0m"
            puts "\033[32m" + "Creating `config/textr_smtp.yml`: " + "\033[0m" + status
          end
        end
      end
      
    end
    
  end
end
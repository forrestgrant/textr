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
          File.copy(File.dirname(__FILE__) + "/../../../textr_smtp.yml.tpl", "#{Rails.root.to_s}/config/textr_smtp.yml") unless File.exists? "#{Rails.root.to_s}/config/textr_smtp.yml"
        end
      end
      
    end
    
  end
end
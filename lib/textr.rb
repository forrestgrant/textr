require "textr/version"
require "textr/rake/tasks"
require 'pony'

module Textr
    		
	# List of main US carriers
	@@carriers = {
    :att => 'txt.att.net',
    :boost => 'myboostmobile.com',
    :tmobile => 'tmomail.net',
    :sprint => 'messaging.sprintpcs.com',
    :verizon => 'vtext.com',
    :virgin => 'vmobl.com'
  }
	
  def self.extended(base)
    # Added device_token attribute if not included by acts_as_pushable
    unless base.respond_to?(:textr_options)
      base.class_eval do
        attr_accessor :phone
      end
    end
  end
    
  def txtable_address( options={} )
    "#{options[:number].gsub(/\D/, "")[-10..-1]}@#{@@carriers[options[:carrier].to_sym]}"
  end
  
  def send_sms( options={} )
    number = options[:number] || phone
    puts "here"
    raise "#{self.class.to_s}" if number.blank?
    raise ':carrier required' if options[:carrier].nil?
    raise ':body required' if options[:body].nil?
    
    Pony.mail({
      :to => txtable_address({:carrier => options[:carrier], :number => number}),
      :subject => options[:subject],
      :body => options[:body]
    })
  end
	
end

require File.dirname(__FILE__) + "/textr/extends_textr"
require "textr/version"
require "textr/smtp"
require "textr/rake/tasks"
require 'pony'

module Textr
   
  @@config = File.exists?(Rails.root.to_s + '/config/textr_smtp.yml') ? YAML.load(ERB.new(File.read((Rails.root.to_s + '/config/textr_smtp.yml'))).result)[Rails.env].symbolize_keys : false
  def smtp_options
    @@config ? { :from => @@config[:from],
                 :via => @@config[:protocol].to_sym,
                 :via_options => {
                   :address              => @@config[:address],
                   :port                 => @@config[:port],
                   :enable_starttls_auto => @@config[:ssl],
                   :user_name            => @@config[:username],
                   :password             => @@config[:password],
                   :authentication       => @@config[:authentication],
                   :domain               => @@config[:domain]
                 }
                } : { }
  end
    		
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
    # Added phone attribute if not included by extends_textr
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
    }.merge(smtp_options))
  end
	
end

require File.dirname(__FILE__) + "/textr/extends_textr"
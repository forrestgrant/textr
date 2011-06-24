require "textr/version"
require "textr/rake/tasks"
require 'pony'
require 'rails'

module Textr
  
  @@config = File.exists?('config/textr_smtp.yml') ? YAML.load(ERB.new(File.read(('config/textr_smtp.yml'))).result)[Rails.env].symbolize_keys : false
  
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
    		
	@@carriers = {
    :att => 'txt.att.net',
    :alltel => 'message.alltel.com',
    :boost => 'myboostmobile.com',
    :cellone => 'mobile.celloneusa.com',
    :metropcs => 'mymetropcs.com',
    :nextel => 'messaging.nextel.com',
    :rogers => 'pcs.rogers.com',
    :sprint => 'messaging.sprintpcs.com',
    :tmobile => 'tmomail.net',
    :uscellular => 'email.uscc.net',
    :verizon => 'vtext.com',
    :virgin => 'vmobl.com'
  }
	
  def self.extended(base)
    unless base.respond_to?(:textr_options)
      base.class_eval do
        attr_accessor :phone
      end
    end
  end
    
  def txtable_address( options={} )
    "#{options[:number].gsub(/\D/, "")[-10..-1]}@#{@@carriers[options[:carrier].to_sym]}"
  end
  
  def txtable_address( options={} )
    "#{options[:number].gsub(/\D/, "")[-10..-1]}@#{@@carriers[options[:carrier].to_sym]}"
  end
  
  def send_sms( options={} )
    number = options[:number] || self.number_from_options
    raise "#{self.class.to_s}" if number.blank?
    raise ':carrier required' if options[:carrier].nil?
    raise ':body required' if options[:body].nil?
    
    Pony.mail({
      :to => txtable_address({:carrier => options[:carrier], :number => number}),
      :subject => options[:subject],
      :body => options[:body]
    }.merge(smtp_options))
  end
  
  def self.send_sms( options={} )
    sms = Object.new
    sms.extend Textr
    sms.send_sms(options)
  end
  
  def number_from_options
    if respond_to?(:textr_options)
      phone = textr_options[:phone_field]
    end
    send(phone)
  end
	
end

require File.dirname(__FILE__) + "/textr/extends_textr"
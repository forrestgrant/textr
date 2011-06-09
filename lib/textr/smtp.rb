module Textr
  @@config = File.exists?(Rails.root.to_s + '/config/textr_smtp.yml') ? YAML.load(ERB.new(File.read((Rails.root.to_s + '/config/textr_smtp.yml'))).result)[Rails.env].symbolize_keys : false
  
  def smtp
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
  
end

# textr

Simple gem for sending SMS

## Install
### RubyGems.org
	$ gem install textr

### from source
	$ git clone http://github.com/forrestgrant/textr
	$ cd textr
	$ rake build
	$ rake install

## Usage

You can use textr with an ActiveRecord model, standalone, or on any object.

### ActiveRecord

Just add `extends_textr` to your model.

	class User < ActiveRecord::Base
		extends_textr
	end

You can then send an SMS like this

	User.first.send_notification :carrier => 'att', :body => 'Hello World!'

Your model must have a `phone` attribute. If you wish to change this to something else (like `number` for example), simply pass it like this `extends_textr :number`
    
	class User < ActiveRecord::Base
		extends_textr :number
	end

Or you can override the `phone` attribute

	>> User.first.send_notification :number => '098-765-4321', :carrier => 'att', :body => 'Hello World!'

### Standalone

Simply call `Textr.send_sms` and pass the number with the hash.

	$ rails c
	>> Textr.send_sms :number => '123-456-7890', :body => 'Hello World!', :carrier => 'att'
	=> #<Mail::Message:12345>

### Transport

textr relies on Pony (https://github.com/benprew/pony) for mail transport which uses /usr/sbin/sendmail to send mail if it is available, otherwise it uses SMTP to localhost.  To add custom SMTP config

	$ rake textr:config:smtp

This will generate `config/textr_smtp.yml`, add your custom SMTP settings

	development:
	  protocol: smtp
	  from: email@example.com
	  address: smtp.yourserver.com
	  port: 25
	  ssl: true
	  username: user
	  password: password
	  authentication: plain
	  domain: localhost.localdomain

	test:
	  protocol: smtp
	  from: email@example.com
	  address: smtp.yourserver.com
	  port: 25
	  ssl: true
	  username: user
	  password: password
	  authentication: plain
	  domain: localhost.localdomain

	production:
	  protocol: smtp
	  from: email@example.com
	  address: smtp.yourserver.com
	  port: 25
	  ssl: true
	  username: user
	  password: password
	  authentication: plain
	  domain: localhost.localdomain

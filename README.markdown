# textr
## Install
### RubyGems.org
	coming soon

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

Your model must have a `device_token` attribute. If you wish to change this to something else (like `device` for example), simply pass it like this `acts_as_pushable :device`.

### Standalone

Simply call `ApplePushNotification.send_notification` and pass the device token as the first parameter and the hash of notification options as the second (see the Parameters section for more information).

    $ script/console
    >> token = "XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX"
    >> ApplePushNotification.send_notification token, :alert => "Hello World!", :badge => 5, :sound => true
    => nil

### Any Object
module Textr
  module ExtendsTextr
  end
end

ActiveRecord::Base.class_eval do
  def self.extends_textr(phone_field = :phone)
    class_inheritable_reader :textr_options
    write_inheritable_attribute :textr_options, {
      :phone_field => phone_field
    }
    include Textr
  end
end
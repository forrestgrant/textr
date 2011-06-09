module Textr
  module ExtendsTextr
  end
end

ActiveRecord::Base.class_eval do
  def self.extends_textr(phone = :phone)
    class_inheritable_reader :textr_options
    write_inheritable_attribute :acts_as_push_options, {
      :phone => phone
    }
    include Textr
  end
end
require 'spec_helper'

describe Textr do
  
  it "should load textr" do
    Textr.should_not be_nil
  end
  
  it "should fail without carrier" do
		lambda {
		  User.first.send_sms
		}.should raise_error RuntimeError
  end
  
  it "should fail without body" do
    lambda {
      User.first.send_sms({:carrier => 'att'})
    }.should raise_error RuntimeError
  end
  
  it "should succeed with all requirements" do
    user = User.first
    user.phone.should == '123-456-7890'
    message = user.send_sms({:carrier => 'att', :body => 'Hello World!'})
    message.from.should == ['pony@unknown']
    message.to.should == ['1234567890@txt.att.net']
  end
  
  it "should allow sending without phone column" do
    company = Company.first
    company.name.should == 'bar'
    message = company.send_sms({:carrier => 'att', :body => 'Hello World!', :number => '098-765-4321'})
    message.to.should == ['0987654321@txt.att.net']
  end
  
  it "should create proper sms addresses" do
    [
      ['att', 'txt.att.net'], 
      ['boost', 'myboostmobile.com'], 
      ['tmobile', 'tmomail.net'], 
      ['sprint', 'messaging.sprintpcs.com'], 
      ['verizon', 'vtext.com'], 
      ['virgin', 'vmobl.com']
    ].each do |carrier|
      message = User.first.send_sms({:carrier => carrier[0], :body => 'Hello World!'})
      message.to.should == ["1234567890@#{carrier[1]}"]
    end
  end
  
  it "should use number from person table" do
    person = Person.first
    person.name.should == 'foo'
    person.number.should == '184-617-3344'
    message = person.send_sms({:carrier => 'att', :body => 'Hello Bruins!'})
    message.to.should == ["1846173344@txt.att.net"]
  end
  
  it "should work without model" do
    lambda {
      message = Textr.send_sms({:carrier => 'att', :body => 'Hello World!', :number => '098-765-4321'})
      message.to.should == ['0987654321@txt.att.net'] 
    }.should_not raise_error
  end
  
end
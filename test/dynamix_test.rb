require_relative 'test_helper'

describe Dynamix do
  it "should allow an attribute to be added to an object" do
  	customer = Dynamix::Customer.new
  	brain = Dynamix::Brain.new
    brain.add_attribute(customer, "email")
    customer.email = "my email" 
    customer.email.must_equal "my email"
  end

  it "should allow an object to be attached to another object" do
  	customer = Dynamix::Customer.new
  	customer2 = Dynamix::Customer.new
  	#brain = Dynamix::Brain.new
  	#brain.attach(customer, "parent", customer2)
    customer.parent = customer2
  	customer.parent.must_equal customer2
  end
end

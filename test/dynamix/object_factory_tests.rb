require_relative '../test_helper'

describe Dynamix do
	it "should create a simple object with no attributes" do
		json = "[{ \"name\" : \"customer\" }]"
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.nil?.must_equal false
	end

	it "should create a simple object with attributes" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "last_name"] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.first_name = "Tim"
		cus.first_name.must_equal "Tim"
	end

	it "should allow a class to be created multiple times with the class created most recently being the one that exists in the domain" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "last_name"] },
				 { "name" : "customer", "attributes" : ["first_name", "middle_name"] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.middle_name = "Tim"
		cus.middle_name.must_equal "Tim"		
	end
end
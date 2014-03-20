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

	it "should create a class with reference to another class of a different type" do
		json = '[{ "name" : "address", "attributes" : ["street", "city"] },
				 { "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "home_address", "reference_type" : "address" }] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.home_address.street = "1 Housedownthe St"
		cus.home_address.street.must_equal "1 Housedownthe St"
	end

	it "should create a class with reference to another class even if that reference class has not been added to the domain yet" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "home_address", "reference_type" : "address" }] },
				 { "name" : "address", "attributes" : ["street", "city"] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.home_address.street = "1 Housedownthe St"
		cus.home_address.street.must_equal "1 Housedownthe St"
	end

	it "should create a class with a reference to itself" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "parent", "reference_type" : "customer" }] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.parent.first_name = "Joe"
		cus.parent.first_name.must_equal "Joe"
		cus.parent.parent.parent.parent.parent.parent.first_name = "Tim"
		cus.parent.parent.parent.parent.parent.parent.first_name.must_equal "Tim"
	end

	it "should create a class with a reference to itself and another class" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "parent", "reference_type" : "customer" }, { "name" : "home_address", "reference_type" : "address"}] },
		{ "name" : "address", "attributes" : ["street", "city"] }]'
		Dynamix::BlueprintManager.add_blueprint(json)
		Dynamix::ObjectArchitect.build()
		cus = Customer.new()
		cus.parent.first_name = "Joe"
		cus.parent.first_name.must_equal "Joe"
		cus.parent.parent.parent.parent.parent.parent.home_address.street = "1 Housedownthe St"
		cus.parent.parent.parent.parent.parent.parent.home_address.street.must_equal "1 Housedownthe St"
	end
end
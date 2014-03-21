require_relative '../test_helper'

describe Dynamix do
	it "should take in a simple json string and create a class definition with the correct name" do
		json = "[{ \"name\" : \"customer\" }]"
		architect = Dynamix::Architect.give_blueprints(json)
		customer = Dynamix::Architect.get_class_definition("customer")
		customer.nil?.must_equal false
	end

	it "should take in a json string that contains a class and attributes and create a class definition with the correct attributes" do
		json = "[{ \"name\" : \"customer\", \"attributes\" : [ \"first_name\", \"last_name\" ]}]"
		architect = Dynamix::Architect.give_blueprints(json)
		customer = Dynamix::Architect.get_class_definition("customer")
		customer.get_attributes.include?("first_name").must_equal true
		customer.get_attributes.include?("last_name").must_equal true
	end

	it "should take in a json string that contains a reference and create a class definition with the correct reference" do
		json = '[
				  {
				    "name": "customer",
				    "attributes" : [
				    	"first_name",
				    	"last_name"
				    ],
				    "references": [
				      {
				        "name": "parent",
				        "reference_type": "customer"
				      }
				    ]
				  }
				]'
		architect = Dynamix::Architect.give_blueprints(json)
		customer = Dynamix::Architect.get_class_definition("customer")
		customer.get_reference("parent").must_equal "customer"
	end

	it "should create a simple object with no attributes" do
		json = "[{ \"name\" : \"customer\" }]"
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.nil?.must_equal false
	end

	it "should create a simple object with attributes" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "last_name"] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.first_name = "Tim"
		cus.first_name.must_equal "Tim"
	end

	it "should allow a class to be created multiple times with the class created most recently being the one that exists in the domain" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "last_name"] },
				 { "name" : "customer", "attributes" : ["first_name", "middle_name"] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.middle_name = "Tim"
		cus.middle_name.must_equal "Tim"		
	end

	it "should create a class with reference to another class of a different type" do
		json = '[{ "name" : "address", "attributes" : ["street", "city"] },
				 { "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "home_address", "reference_type" : "address" }] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.home_address = Address.new
		cus.home_address.street = "1 Housedownthe St"
		cus.home_address.street.must_equal "1 Housedownthe St"
	end

	it "should create a class with reference to another class even if that reference class has not been added to the domain yet" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "home_address", "reference_type" : "address" }] },
				 { "name" : "address", "attributes" : ["street", "city"] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.home_address = Address.new()
		cus.home_address.street = "1 Housedownthe St"
		cus.home_address.street.must_equal "1 Housedownthe St"
	end

	it "should create a class with a reference to itself" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "parent", "reference_type" : "customer" }] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.parent = Customer.new()
		cus.parent.first_name = "Joe"
		cus.parent.first_name.must_equal "Joe"
	end

	it "should create a class with a reference to itself and another class" do
		json = '[{ "name" : "customer", "attributes" : ["first_name", "middle_name"], "references" : [ { "name" : "parent", "reference_type" : "customer" }, { "name" : "home_address", "reference_type" : "address"}] },
		{ "name" : "address", "attributes" : ["street", "city"] }]'
		Dynamix::Architect.give_blueprints(json)
		Dynamix::Architect.build()
		cus = Customer.new()
		cus.parent = Customer.new()
		cus.parent.first_name = "Joe"
		cus.parent.first_name.must_equal "Joe"
		cus.parent.home_address = Address.new()
		cus.parent.home_address.street = "1 Housedownthe St"
		cus.parent.home_address.street.must_equal "1 Housedownthe St"
	end
end
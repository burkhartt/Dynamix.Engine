require_relative '../test_helper'

describe Dynamix do
	it "should take in a simple json string and create a class definition with the correct name" do
		json = "[{ \"name\" : \"customer\" }]"
		architect = Dynamix::BlueprintManager.add_blueprint(json)
		customer = Dynamix::BlueprintManager.get_class_definition("customer")
		customer.nil?.must_equal false
	end

	it "should take in a json string that contains a class and attributes and create a class definition with the correct attributes" do
		json = "[{ \"name\" : \"customer\", \"attributes\" : [ \"first_name\", \"last_name\" ]}]"
		architect = Dynamix::BlueprintManager.add_blueprint(json)
		customer = Dynamix::BlueprintManager.get_class_definition("customer")
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
				        "reference_types": [
				          "customer"
				        ]
				      }
				    ]
				  }
				]'
		architect = Dynamix::BlueprintManager.add_blueprint(json)
		customer = Dynamix::BlueprintManager.get_class_definition("customer")
		customer.get_reference("parent")[0].must_equal "customer"
	end
end
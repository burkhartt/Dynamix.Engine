require_relative '../test_helper'

describe Dynamix do
	it "should take in a simple json string and create a class definition with the correct name" do
		json = "[{ \"name\" : \"customer\" }]"
		architect = Dynamix::Architect.new
		architect.add_schema(json)
		class_definitions = architect.get_class_definitions()
		class_definitions["customer"].nil?.must_equal false
	end

	it "should take in a json string that contains a class and attributes and create a class definition with the correct attributes" do
		json = "[{ \"name\" : \"customer\", \"attributes\" : [ \"first_name\", \"last_name\" ]}]"
		architect = Dynamix::Architect.new
		architect.add_schema(json)
		class_definitions = architect.get_class_definitions()
		class_definitions["customer"].get_attributes.include?("first_name").must_equal true
		class_definitions["customer"].get_attributes.include?("last_name").must_equal true
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
				        "schema": [
				          {
				            "name": "customer",
				            "attributes" : [
				            	"first_name",
				            	"last_name"
				            ]
				          }
				        ]
				      }
				    ]
				  }
				]'
		architect = Dynamix::Architect.new
		architect.add_schema(json)
		class_definitions = architect.get_class_definitions()

		parent = class_definitions["customer"]
		attributes = parent.get_references("parent")
	end
end
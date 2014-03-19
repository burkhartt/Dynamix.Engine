require_relative '../test_helper'

describe Dynamix do
	it "should set the name of the class immediately" do
		class_instance = Dynamix::ClassDefinition.new("customer")
		class_instance.get_name().must_equal "customer"
	end

	it "should be able to add attributes" do
		class_instance = Dynamix::ClassDefinition.new("customer")
		class_instance.add_attribute("first_name")
		class_instance.get_attributes().include?("first_name").must_equal true
	end

	it "should be able to add a reference to another class" do
		customer_instance = Dynamix::ClassDefinition.new("customer")
		parent_instance = Dynamix::ClassDefinition.new("customer")
		customer_instance.add_reference("parent", parent_instance)
		customer_instance.get_reference("parent").include?(parent_instance).must_equal true
	end

	it "should be able to add multiple objects to a single reference" do
		customer_instance = Dynamix::ClassDefinition.new("customer")
		mom_instance = Dynamix::ClassDefinition.new("customer")
		dad_instance = Dynamix::ClassDefinition.new("customer")
		customer_instance.add_reference("parent", mom_instance)
		customer_instance.add_reference("parent", dad_instance)
		customer_instance.get_reference("parent").include?(mom_instance).must_equal true
		customer_instance.get_reference("parent").include?(dad_instance).must_equal true
	end
end
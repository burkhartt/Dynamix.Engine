require_relative '../test_helper'

describe Dynamix do
  it "should convert a json object to a basic schema" do
  	json = "{ \"person\" : { \"attributes\" : [ \"first_name\", \"last_name\", \"email\"]}}"
  	brain = Dynamix::Brain.new(json)
  	person = brain.create("person")
  	person.first_name = "Tim"
  	person.first_name.must_equal "Tim"
  end

  it "should allow attributes to be added after the schema has been defined" do
  	json = "{ \"person\" : { \"attributes\" : [ \"first_name\", \"last_name\", \"email\"]}}"
  	brain = Dynamix::Brain.new(json)
  	brain.add_attribute("person", "date_of_birth")
  	person = brain.create("person")
  	person.date_of_birth = "1/1/2000"
  	person.date_of_birth.must_equal "1/1/2000"
  end

  it "should allow a schema to be added to an existing class definition" do
  	json = "{ \"person\" : { \"attributes\" : [ \"first_name\", \"last_name\", \"email\"]}}"
  	brain = Dynamix::Brain.new(json)
  	brain.attach("person", "parent", json)
  	person.parent.first_name = "Tim"
  	person.parent.first_name.must_equal "Tim"
  end
end
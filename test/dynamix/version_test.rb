require_relative '../test_helper'

describe Dynamix do

  it "should have a version" do
    Dynamix::VERSION.nil?.must_equal false
  end

end

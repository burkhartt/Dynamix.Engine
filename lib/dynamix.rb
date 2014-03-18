require_relative "./dynamix/version"
Dir[File.dirname(__FILE__) + '/dynamix/*.rb'].each { |f| require f }

module Dynamix
end

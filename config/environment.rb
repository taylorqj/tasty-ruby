require 'dotenv'

# set appropriate values in ENV
Dotenv.load

ENV.each do |var, value|
  puts "#{var}=#{value}"
end

require File.expand_path('../application', __FILE__)

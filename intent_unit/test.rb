$:.unshift File.dirname(__FILE__)
require './require/automationrequire'

$var = 25
puts "XXXX"
begin

	#load "./cases/test01.rb"
	system("ruby ./cases/test01.rb")
	puts $?.exitstatus
	puts "Test"

end
puts "XXXX"

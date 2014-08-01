# Case04.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("Log: ==Case04: Verifies the messages when entering a valid email but no passwords==")

#Browser instantiation and open page
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click


#Choose register button without entering any information
loggEr("Log: Enter email but no password then click on the Register button")
#Gets valid email
email = emailGen()
driver.find_element(:id, "user_email").send_keys "#{email}"
driver.find_element(:name, "commit").click



#Match the title error
matchTitle("h2", "3 errors prohibited this user from being saved", driver)

#Match the error messages
matchErrorText("errorExplanation", "Password is too short (minimum is 4 characters)", 1, driver)
matchErrorText("errorExplanation", "Password doesn't match confirmation", 2, driver)
matchErrorText("errorExplanation", "Password confirmation is too short (minimum is 4 characters)", 3, driver)

#Checks that the entry made on the previous page still remains
matchEntryText("Email", "user_email", "#{email}", driver)


driver.close();

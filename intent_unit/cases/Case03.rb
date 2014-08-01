# Case03.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case03: Verifies the messages when entering no email or passwords==")

#Browser instantiation and open page
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click

#Choose register button without entering any information
loggEr("Log: Click on the Register button")
driver.find_element(:name, "commit").click

#Match the title error
matchTitle("h2", "4 errors prohibited this user from being saved", driver)

#Match the error messages
matchErrorText("errorExplanation", "Email should look like an email address.", 1, driver)
matchErrorText("errorExplanation", "Password is too short (minimum is 4 characters)", 2, driver)
matchErrorText("errorExplanation", "Password doesn't match confirmation", 3, driver)
matchErrorText("errorExplanation", "Password confirmation is too short (minimum is 4 characters)", 4, driver)


driver.close();

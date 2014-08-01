# Case08.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case08: Verifies the messages when entering valid passwords with an invalid email==")

#Browser instantiation and open page
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)

#Choose register button without entering any information
loggEr("Log: Enter valid password but no email then click on the Register button")
driver.find_element(:id, "user_email").send_keys "#{INVALID_EMAIL}"
driver.find_element(:id, "user_password").send_keys "#{VALID_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click



#Match the title error
matchTitle("h2", "1 errors prohibited this user from being saved", driver)

#Match the error messages
matchErrorText("errorExplanation", "Email should look like an email address.", 1, driver)

#Mayby we should check if password fields remain blank, I think this is html feature and no need to test



driver.close();

# Case06.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case06: Verifies the messages when entering short matching password==")

#Browser instantiation and open page
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click




#Choose register button without entering any information
loggEr("Log: Enter short matching password and valid email then click on the Register button")
driver.find_element(:id, "user_password").send_keys "#{SHORT_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{SHORT_PASS}"
#Gets valid email
email = emailGen()
driver.find_element(:id, "user_email").send_keys "#{email}"
driver.find_element(:name, "commit").click



#Match the title error
matchTitle("h2", "2 errors prohibited this user from being saved", driver)

#Match the error messages
matchErrorText("errorExplanation", "Password is too short (minimum is 4 characters)", 1, driver)
matchErrorText("errorExplanation", "Password confirmation is too short (minimum is 4 characters)", 2, driver)

#Checks that the entry made on the previous page still remains
matchEntryText("Email", "user_email", "#{email}", driver)


driver.close();

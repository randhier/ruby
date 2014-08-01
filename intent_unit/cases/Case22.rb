# Case22.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case22: Login with a user that is not registered==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Enter blank fields
loggEr("Log: Enter email that was not registered and password then login")
email = emailGen()
driver.find_element(:id, "user_session_email").send_keys "#{email}"
driver.find_element(:id, "user_session_password").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click

#Verify the title and messages
loggEr("Log: Check title and messages")
matchTitle("h1", "Login", driver)
matchTitle("h2", "1 error prohibited:", driver)
matchErrorText("error_explanation", "Email is not valid", 1, driver)

driver.close()

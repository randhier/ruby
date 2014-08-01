# Case20.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case20: Login with all blank fields==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Enter blank fields
loggEr("Log: Enter blank email and password and login")
driver.find_element(:id, "user_session_email").send_keys ""
driver.find_element(:id, "user_session_password").send_keys ""
driver.find_element(:name, "commit").click

#Verify the title and messages
loggEr("Log: Check title and messages")
matchTitle("h1", "Login", driver)
matchTitle("h2", "1 error prohibited:", driver)
matchErrorText("error_explanation", "You did not provide any details for authentication.", 1, driver)

driver.close()

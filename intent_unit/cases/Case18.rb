# Case18.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case18: Create a user with a email that has a trailing whitespace==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)


#Choose register button without entering any information
loggEr("Log: Enter valid email with withspace and password then click on the Register button")
email = emailGen()
driver.find_element(:id, "user_email").send_keys "#{email}  "
driver.find_element(:id, "user_password").send_keys "#{VALID_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click

loggEr("Log: Check that user was created")
#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyNewlogin(email, driver)

driver.close()

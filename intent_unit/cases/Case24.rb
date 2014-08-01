# Case24.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case24: Login with a user that is registered but with the wrong password==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)


#Choose register button without entering any information
loggEr("Log: Enter valid email and password then click on the Register button")
email = emailGen()
driver.find_element(:id, "user_email").send_keys "#{email}"
driver.find_element(:id, "user_password").send_keys "#{VALID_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click

#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyNewlogin(email, driver)

loggEr("Log: Go back to #{URL_HOME}")
driver.get(URL_HOME)
matchUrl(URL_HOME, driver)

#Enter blank fields
loggEr("Log: Enter email and different password then login")
passnew = Time.new.strftime("%Y%m%d%H%M%S")
driver.find_element(:id, "user_session_email").send_keys "#{email}"
driver.find_element(:id, "user_session_password").send_keys "#{passnew}"
driver.find_element(:name, "commit").click

#Verify the title and messages
loggEr("Log: Check title and messages")
matchTitle("h1", "Login", driver)
matchTitle("h2", "1 error prohibited:", driver)
matchErrorText("error_explanation", "Password is not valid", 1, driver)

driver.close()

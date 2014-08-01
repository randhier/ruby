# Case19.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case19: Update a user with an existing user email==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)


#Choose register button without entering any information
loggEr("Log: Enter valid email and password for UserA, then click on the Register button")
email1 = emailGen()
loggEr("Log: UserA email is #{email1}")
driver.find_element(:id, "user_email").send_keys "#{email1}"
driver.find_element(:id, "user_password").send_keys "#{VALID_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click

#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyNewlogin(email1, driver)

#Relaunch browser due to bug
loggEr("Warn: Due to a existing bug the browser be relaunched to add new user")
driver.close()
loggEr("Log: Open page #{URL_HOME} again")
driver = Selenium::WebDriver.for :"#{BROWSER}"
driver.get(URL_HOME)
matchUrl(URL_HOME, driver)

#Choose create a new user button
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)

#Choose register button without entering any information
loggEr("Log: Register another user, UserB, with different email then click on the Register button")
email2 = emailGen()
loggEr("Log: UserB email is #{email2}")
driver.find_element(:id, "user_email").send_keys "#{email2}"
driver.find_element(:id, "user_password").send_keys "#{VALID_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click

#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyNewlogin(email2, driver)

#Click the update button
loggEr("Log: Click the Edit button")
driver.find_element(:link, "Edit").click

#Match the accounts Url
matchUrl(EDITACCOUNT_URL, driver)

#Checks user email is in the email field
matchEntryText("Email", "user_email", "#{email2}", driver)

# Enter new user
loggEr("Log: Update user UserB email #{email2} to UserA email #{email1}")
driver.find_element(:id, "user_email").clear
driver.find_element(:id, "user_email").send_keys "#{email1}"
driver.find_element(:name, "commit").click

#Verify page title and errors
matchTitle("h2", "1 error prohibited this user from being saved", driver)
matchTitle("p", "There were problems with the following fields:", driver)
matchErrorText("errorExplanation", "Email has already been taken", 1, driver)

driver.close()

# Case20.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case20: Update a user with a valid password and verify login==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
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

#Click the update button
loggEr("Log: Click the Edit button")
driver.find_element(:link, "Edit").click
#Match the accounts Url
matchUrl(EDITACCOUNT_URL, driver)

#Checks user email is in the email field
matchEntryText("Email", "user_email", "#{email}", driver)

# Enter new password
loggEr("Log: Enter new valid password then click Update button")
passnew = Time.new.strftime("%Y%m%d%H%M%S") + VALID_PASS
loggEr("Log: Update user #{email} password from #{VALID_PASS} to #{passnew}")
driver.find_element(:id, "user_password").send_keys "#{passnew}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{passnew}"
driver.find_element(:name, "commit").click

#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyUserlogin(email, driver)

#Go back to home page and retry with new login
loggEr("Log: Go back to home page and enter updated user info")
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)
loggEr("Log: Enter new user #{email} info and login")
driver.find_element(:id, "user_session_email").send_keys "#{email}"
driver.find_element(:id, "user_session_password").send_keys "#{passnew}"
driver.find_element(:name, "commit").click


#Verify page then login name again
matchUrl(ACCOUNTS_URL, driver)
#Verify that the user was logged in
verifyUserlogin(email, driver)

driver.close()

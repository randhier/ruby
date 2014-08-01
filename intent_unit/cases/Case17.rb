# Case17.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case17: Update a user with a valid email and verify login==")

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


#Match links
matchLinkandUrl('Show ordered pizzas', SHOWORDER_URL, driver)
matchLinkandUrl('Order a pizza', ORDER_URL , driver)
matchLinkandUrl('Edit', EDITACCOUNT_URL, driver)
#Click the update button
loggEr("Log: Click the Edit button")
driver.find_element(:link, "Edit").click

#Match the accounts Url
matchUrl(EDITACCOUNT_URL, driver)
#Match title
matchTitle("h1", "Edit My Account", driver)
#Match labels
matchLabelText("edit_user", "Email", 1, driver)
matchLabelText("edit_user", "Change password", 2, driver)
matchLabelText("edit_user", "Password confirmation", 3, driver)
#Checks for the Register button
checkButton("Update", driver)
#Checks user email is in the email field
matchEntryText("Email", "user_email", "#{email}", driver)

# Clear field and enter blank user
loggEr("Log: Enter valid email then click Update button")
emailnew = emailGen()
loggEr("Log: Update user #{email} to #{emailnew}")
driver.find_element(:id, "user_email").clear
driver.find_element(:id, "user_email").send_keys "#{emailnew}"
driver.find_element(:name, "commit").click

#Verify page then login name
matchUrl(ACCOUNTS_URL, driver)
verifyUserlogin(emailnew, driver)

#Go back to home page and retry with new login
loggEr("Log: Go back to home page and enter new user user info")
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)
loggEr("Log: Enter new user #{emailnew} info and login")
driver.find_element(:id, "user_session_email").send_keys "#{emailnew}"
driver.find_element(:id, "user_session_password").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click


#Verify page then login name again
matchUrl(ACCOUNTS_URL, driver)
#Verify that the user was logged in
verifyUserlogin(emailnew, driver)

driver.close()

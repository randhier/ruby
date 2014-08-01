# Case12.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case12: Update a user and verify update page==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)


#Choose register button without entering any information
loggEr("Log: Enter valid password but no email then click on the Register button")
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

#class="new_user" id="new_user"

#Match the accounts Url
matchUrl(EDITACCOUNT_URL, driver)

#Match labels
matchLabelText("edit_user", "Email", 1, driver)
matchLabelText("edit_user", "Change password", 2, driver)
matchLabelText("edit_user", "Password confirmation", 3, driver)


#Checks for the Register button
checkButton("Update", driver)

#Checks user email is in the email field
matchEntryText("Email", "user_email", "#{email}", driver)
#Check my profile link
matchLinkandUrl('My Profile', ACCOUNTS_URL, driver)

#Navigate back to the accounts page
loggEr("Log: Click on the My Profile link to go back to accounts page")
driver.find_element(:link, "My Profile").click
matchUrl(ACCOUNTS_URL, driver)

driver.close();

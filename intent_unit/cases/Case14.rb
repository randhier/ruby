# Case14.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case14: Update a user with a short password==")

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

if driver.find_element(:css, "p").text.match(/^["Login: #{email}"]+$/)
  loggEr("Log: New registration was successfull, the user #{email} has been added")
else
  loggEr("Error: User #{email} was not successful")
end

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
loggEr("Log: Enter short password while using the same email, click Update button")
driver.find_element(:id, "user_password").send_keys "#{SHORT_PASS}"
driver.find_element(:id, "user_password_confirmation").send_keys "#{SHORT_PASS}"
driver.find_element(:name, "commit").click

#Matche title and the correct error
matchEntryText("Email", "user_email", "#{email}", driver)
matchTitle("h2", "2 errors prohibited this user from being saved", driver)
matchTitle("p", "There were problems with the following fields:", driver)
matchErrorText("errorExplanation", "Password is too short (minimum is 4 characters)", 1, driver)
matchErrorText("errorExplanation", "Password confirmation is too short (minimum is 4 characters)", 2, driver)

driver.close();

# Case15.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case15: Update a user with a mismatched passwords==")

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
loggEr("Log: Enter mismatched passwords and click Update button")
pass1 = Time.new.strftime("%Y%m%d%H%M%S")
loggEr("Log: First password is #{pass1}")
driver.find_element(:id, "user_password").send_keys "#{pass1}"
sleep(1)
pass2 = Time.new.strftime("%Y%m%d%H%M%S")
loggEr("Log: Second password is #{pass2}")
driver.find_element(:id, "user_password_confirmation").send_keys "#{pass2}"
driver.find_element(:name, "commit").click

#Matche title and the correct error
matchEntryText("Email", "user_email", "#{email}", driver)
matchTitle("h2", "1 errors prohibited this user from being saved", driver)
matchTitle("p", "There were problems with the following fields:", driver)
matchErrorText("errorExplanation", "Password doesn't match confirmation", 1, driver)

driver.close();

# Case11.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case11: Login with existing user==")

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

#Go back to home page and then add a new user
loggEr("Log: Go back to home page and enter the same user info")
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)
loggEr("Log: Enter user #{email} info and login")
driver.find_element(:id, "user_session_email").send_keys "#{email}"
driver.find_element(:id, "user_session_password").send_keys "#{VALID_PASS}"
driver.find_element(:name, "commit").click


#Verify page then login name again
matchUrl(ACCOUNTS_URL, driver)
#Match links again
matchLinkandUrl('Show ordered pizzas', SHOWORDER_URL, driver)
matchLinkandUrl('Order a pizza', ORDER_URL , driver)
matchLinkandUrl('Edit', EDITACCOUNT_URL, driver)
#Verify user is logged in
verifyUserlogin(email, driver)

driver.close()

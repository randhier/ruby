# Case10.rb
$:.unshift File.dirname(__FILE__)
require './require/automationrequire'


#Function to go home page and click new user, it gets called twice in this script so I made it a function
def homeandnewuser(driver)
  #Open page
  loggEr("Log: Open page #{URL_HOME}")
  driver.get(URL_HOME)
  matchUrl(URL_HOME, driver)

  #Choose create a new user button and
  loggEr("Log: Click on the Create a new user button")
  driver.find_element(:link, "Create a new user").click
end

loggEr("Log: ==Case10: Enter valid email and password then verify login==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"
homeandnewuser(driver)


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
loggEr("Log: Go back to home page and click on create new user link")
homeandnewuser(driver)
#Verify the page loads
matchUrl(NEW_URL, driver)

=begin
App will always fail here unless we implement a wipe cookies feature.  No point in building this, will wait
till bug is fixed.  Will also complete automation script at that time.
=end

driver.close()

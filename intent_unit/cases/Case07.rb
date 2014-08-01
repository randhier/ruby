# Case07.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

loggEr("==Case07: Verifies the messages when entering mismatched password==")

#Browser instantiation and open page
driver = Selenium::WebDriver.for :"#{BROWSER}"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and
loggEr("Log: Click on the Create a new user button")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)


#Choose register button without entering any information
loggEr("Log: Enter mismatched password and valid email then click on the Register button")
#Generate random password twice with a one second delay and enter passwords
pass1 = Time.new.strftime("%Y%m%d%H%M%S")
loggEr("Log: First password is #{pass1}")
driver.find_element(:id, "user_password").send_keys "#{pass1}"
sleep(1)
pass2 = Time.new.strftime("%Y%m%d%H%M%S")
loggEr("Log: Second password is #{pass2}")
driver.find_element(:id, "user_password_confirmation").send_keys "#{pass2}"
#Gets valid email
email = emailGen()
driver.find_element(:id, "user_email").send_keys "#{email}"
driver.find_element(:name, "commit").click


#verify { assert_equal "Password doesn't match confirmation", @driver.find_element(:css, "li").text }

#Match the title error
matchTitle("h2", "1 errors prohibited this user from being saved", driver)

#Match the error messages
matchErrorText("errorExplanation", "Password doesn't match confirmation", 1, driver)

#Checks that the entry made on the previous page still remains
matchEntryText("Email", "user_email", "#{email}", driver)


driver.close();

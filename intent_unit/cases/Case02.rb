$:.unshift File.dirname(__FILE__)
require 'automationrequire'
loggEr("==Case02: Verifies the create new users page's Title, URL, Labels and Register button==")

#Browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"

#Loading the intent URL.
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Choose create a new user button and verify page appears
loggEr("Log: Click on the Create a new user link")
driver.find_element(:link, "Create a new user").click
matchUrl(NEW_URL, driver)

#Match title
matchTitle("h1", "Register", driver)

#Match lables
matchLabelText("new_user", "Email", 1, driver)
matchLabelText("new_user", "Password", 2, driver)
matchLabelText("new_user", "Password confirmation", 3, driver)

#Checks for the Register button
loginbtn = driver.find_element(:name, "commit")
if loginbtn.attribute("value") == "Register"
  loggEr("Log: Button Register appears")
else
  loggEr("Error: Button Register does not appear")
end

driver.close();

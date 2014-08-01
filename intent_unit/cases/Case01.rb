#Case01.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'
loggEr("==Case01: Verifies the login page's Title, Labels and New user button==")

#Firefox browser instantiation
driver = Selenium::WebDriver.for :"#{BROWSER}"

#Loading the intent URL.  Either could be used still trying to figure the difference
#driver.navigate.to "http://localhost:3000/"
loggEr("Log: Open page #{URL_HOME}")
driver.get(URL_HOME)

#Verify that the Login title is visable
matchTitle("h1", "Login", driver)

#Match lables
matchLabelText("new_user_session", "Email", 1, driver)
matchLabelText("new_user_session", "Password", 2, driver)

#Checks for the Login button
loginbtn = driver.find_element(:name, "commit")
if loginbtn.attribute("value") == "Login"
	loggEr("Log: Button login appears")
else
	loggEr("Error: Button login does not appear")
end

#Checks the link text and the url
link = driver.find_element(:link, "Create a new user")
if link.text == "Create a new user"
	loggEr("Log: Create user link text appears as \"Create a new user\"")
else
	loggEr("Error: Create user link text does not appear \"Create a new user\"")
end

if link.attribute("href") == "#{NEW_URL}"
	loggEr("Log: Create user link is #{NEW_URL}")
else
	loggEr("Error: Create user link is not #{NEW_URL} it is #{link.attribute("href")}")
end

#Clean up
driver.close()

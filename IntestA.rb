require "selenium-webdriver"

#Firefox browser instantiation
driver = Selenium::WebDriver.for :firefox

#Loading the assertselenium URL
driver.navigate.to "http://GOOGLE.COM"

#Clicking on the Follow link present on the assertselenium home page
#FollowButton  = driver.find_element(:link, "About")
#FollowButton.click


driver.find_element(:id, "gbqfq").clear
driver.find_element(:id, "gbqfq").send_keys "test123"
driver.find_element(:id, "gbqfb").click

@driver.get(@base_url + "/")
@driver.find_element(:id, "user_session_email").clear
@driver.find_element(:id, "user_session_email").send_keys "123"
@driver.find_element(:id, "user_session_password").clear
@driver.find_element(:id, "user_session_password").send_keys "123"
@driver.find_element(:name, "commit").click
verify { (@driver.find_element(:css, "h2").text).should == "1 error prohibited:" }
verify { (@driver.find_element(:css, "li").text).should == "Email is not valid" }


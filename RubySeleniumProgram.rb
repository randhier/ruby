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

require "selenium-webdriver"

#Firefox browser instantiation
driver = Selenium::WebDriver.for :firefox

#Loading the assertselenium URL
driver.navigate.to "http://GOOGLE.COM"

#Clicking on the Follow link present on the assertselenium home page
FollowButton  = driver.find_element(:link, "About")
FollowButton.click

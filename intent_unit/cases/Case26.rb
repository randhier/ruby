# Case26.rb
$:.unshift File.dirname(__FILE__)
require 'automationrequire'

#Function to match the table lables
def matchTableLabel(tblname, tablenum, driver)
  if driver.find_element(:css, "th:nth-of-type(#{tablenum})").text == "#{tblname}"
    loggEr("Log: Table \"#{tblname}\" appears")
  else
    loggEr("Error: Table \"#{tblname}\" does not appear")
  end
end

loggEr("Log: ==Case26: Create a Pizza with one double topping then remove topping before placing order==")

#Browser instantiation and open page
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

loggEr("Log: Click order a pizza link")
driver.find_element(:link, "Order a pizza").click
matchUrl(ORDER_URL, driver)

loggEr("Log: Enter pizza name and size")
driver.find_element(:id, "pizza_name").send_keys "#{PIZZA}"
driver.find_element(:id, "pizza_size").send_keys "#{SIZE}"
driver.find_element(:name, "commit").click

loggEr("Log: Verify page and imputs")
# gets the order ID, I don't know how else to get it.  Don't want to do any db commands
orderid = driver.current_url().split('/')[-1]
addtopping_url = "#{SHOWORDER_URL}/#{orderid}/#{ADDTOPPINGS_PAGE}"
placeorder_url = "#{SHOWORDER_URL}/#{orderid}/#{PLACEORDER_PAGE}"

#Verify the entries were made
matchPizza('Name', "#{PIZZA}", driver)
matchPizza('Size', "#{SIZE}", driver)


#Go to add toppings page
driver.find_element(:link, "Add toppings").click
matchUrl(addtopping_url, driver)

#Enter topping and check box then verify
loggEr("Log: Add topping and set to true for double order")
driver.find_element(:id, "topping_name").send_keys "#{TOPPING}"
driver.find_element(:id, "topping_double_order").click
checkBox('topping_double_order', 'Double Topping', driver)
driver.find_element(:name, "commit").click
matchUrl("#{SHOWORDER_URL}/#{orderid}", driver)

getTopping(1, "#{TOPPING}", "true", driver)

loggEr ("Log: Remove the topping and choose yes at popup confirmation")
driver.find_element(:link, "Remove").click
a = driver.switch_to.alert
if a.text == 'Are you sure?'
  a.accept
else
  a.dismiss
end

matchUrl(addtopping_url, driver)

=begin
Due to but I can't proceed.  Code would have followed to place order
=end

loggEr("Log: Place order by clicking order button")
driver.find_element(:link, "Order this pizza").click
matchUrl("#{SHOWORDER_URL}", driver)

driver.close()

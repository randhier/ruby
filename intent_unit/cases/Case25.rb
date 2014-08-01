# Case25.rb
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

loggEr("Log: ==Case25: Create a Pizza with one double topping and place order, veriy all pages==")

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

loggEr("Log: Verify the order page")
#Match title and lable
matchUrl(ORDER_URL, driver)
matchTitle("h1", "New pizza", driver)
matchPizzaLabelText("new_pizza", "Name", 1, driver)
matchPizzaLabelText("new_pizza", "Size", 2, driver)
checkButton("Create", driver)

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

#Verify page
matchTableLabel("Name", 1, driver)
matchTableLabel("Double order", 2, driver)

matchLinkandUrl('All orders', SHOWORDER_URL, driver)
matchLinkandUrl('Add toppings', "#{addtopping_url}" , driver)
matchLinkandUrl('Order this pizza', "#{placeorder_url}", driver)


#Go to add toppings page and verify before adding a topping
driver.find_element(:link, "Add toppings").click
matchUrl(addtopping_url, driver)
matchTitle("h1", "New topping", driver)
matchPizzaLabelText("new_topping", "Name", 1, driver)
matchPizzaLabelText("new_topping", "Double Order", 2, driver)
checkButton("Create", driver)

#Enter topping and check box then verify
loggEr("Log: Add topping and set to true for double order")
driver.find_element(:id, "topping_name").send_keys "#{TOPPING}"
driver.find_element(:id, "topping_double_order").click
checkBox('topping_double_order', 'Double Topping', driver)
driver.find_element(:name, "commit").click
matchUrl("#{SHOWORDER_URL}/#{orderid}", driver)

getTopping(1, "#{TOPPING}", "true", driver)

loggEr("Log: Place order by clicking order button")
driver.find_element(:link, "Order this pizza").click
matchUrl("#{SHOWORDER_URL}", driver)
matchTitle("h1", "Listing pizzas", driver)

=begin
The followin are not dynamic but since only one order was made it should work
No time at the moment to make a function for later tests.
It looks bad but works, again time has run out.
=end

if driver.find_element(:xpath, "//td[1]").text == "#{PIZZA}"
  if driver.find_element(:xpath, "//td[2]").text == "#{SIZE}"
    if driver.find_element(:xpath, "//td[3]").text == "1"
      if driver.find_element(:xpath, "//td[4]").text == "true"
        loggEr ("Log: Order was placed")
      else
        loggEr ("Error: Order was not placed because it does not have double topping option")
        driver.close()
        exit 1
      end
    else
      loggEr ("Error: Order was not placed because it does not have one topping")
      driver.close()
      exit 1
    end
  else
    loggEr ("Error: Order was not placed because the size is wrong")
    driver.close()
    exit 1
  end
else
  loggEr ("Error: Order was not placed because the name #{PIZZA} is not shown")
  driver.close()
  exit 1
end

driver.close()

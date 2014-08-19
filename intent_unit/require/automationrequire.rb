require "selenium-webdriver"
require "json"
require "time"
#require "test/unit"
#include Test::Unit::Assertions

#Constants that can be changed later if url and individual pages are changed.
BROWSER = 'firefox'
URL_HOME = 'http://localhost:3000/'
LOGIN_PAGE = 'sessions'
LOGIN_URL = URL_HOME + LOGIN_PAGE
NEW_PAGE = 'users/new'
NEW_URL = URL_HOME + NEW_PAGE
ACCOUNTS_PAGE = 'account'
ACCOUNTS_URL = URL_HOME + ACCOUNTS_PAGE
ORDER_PAGE = 'pizzas/new'
ORDER_URL = URL_HOME + ORDER_PAGE
SHOWORDER_PAGE = 'pizzas'
SHOWORDER_URL = URL_HOME + SHOWORDER_PAGE
EDITACCOUNT_PAGE = 'account/edit'
EDITACCOUNT_URL = URL_HOME + EDITACCOUNT_PAGE
PLACEORDER_PAGE = 'order'
ADDTOPPINGS_PAGE = 'toppings/new'


#Constants for user names and passwords
VALID_PASS = 'test123'
SHORT_PASS = 'tes'
VALID_EMAIL = 'Rr@mail.com'
INVALID_EMAIL = 'test@@.'

#Pizza and topping
PIZZA = 'Sweet'
SIZE = 'Large'
TOPPING = 'Peppers'


#Logger date
def loggEr(log)
	now = Time.new.strftime("%b %e %H%M%S")
	puts "#{now} #{log}"
end

#Function to generate a valid email.  Use the current data and time so we don't have duplicates
def emailGen()
	Time.new.strftime("%Y%m%d%H%M%S") + VALID_EMAIL
end

#Function to match urls, if there is no match will stop scipt. Will wait for 5 seconds for page to load
def matchUrl(urlmatch, driver)
	wait = Selenium::WebDriver::Wait.new(:timeout => 5)
	currentUrl = wait.until { driver.current_url() }
	if currentUrl == urlmatch
		loggEr("Log: Url #{urlmatch} matches the current Url")
		return true
	else
		loggEr("Error: Url #{urlmatch} does not match current Url #{currentUrl}")
		loggEr("Error: Current page is not expected, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
		return nil
	end
end



#function to match page Title
def matchTitle(cssh, title, driver)
	elementtext = driver.find_element(:css, "#{cssh}").text
	if elementtext.match(/^["#{title}"]+$/)
		loggEr("Log: The title \"#{title}\" appears")
	else
		loggEr("Error: \"#{title}\" title does not appear, the current title is \"#{elementtext}\"")
	end
rescue Exception
	loggEr ("Error: \"#{title}\" title does not appear, due to the following error")
	loggEr ("Error: #{$!}")
end

#Function to match pizza name or size
def matchPizza(type, ordername, driver)
	if type == "Name"; x=1 else x=2 end
	if driver.find_element(:css, "p:nth-of-type(#{x})").text.match(/^["#{type}: #{ordername}]+$/)
		loggEr("Log: Pizza #{type} \"#{ordername}\" appears")
	else
		loggEr("Error: Pizza #{type} \"#{ordername}\" does not appears, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
	end
end



#Function to match text of a label
def matchLabelText(classid, textla, labelnum, driver)
	if driver.find_element(:xpath, "//form[@class='#{classid}']/label[#{labelnum}]").text.match(/^["#{textla}"]+$/)
		loggEr("Log: Label #{textla } appears")
	else
		loggEr("Error: Label #{textla } does not appears")
	end
end

#Function to match pizza labels
def matchPizzaLabelText(formid, textla, labelnum, driver)
	if driver.find_element(:xpath, "//form[@id='#{formid}']/p[#{labelnum}]/label").text.match(/^["#{textla}"]+$/)
		loggEr("Log: Label \"#{textla }\" appears")
	else
		loggEr("Error: Label \"#{textla }\" does not appears")
	end
end


#Function to match the error messages
def matchErrorText(formid, textla, labelnum, driver)
	if driver.find_element(:xpath, "//div[@id='#{formid}']/ul/li[#{labelnum}]").text.match(/^["#{textla}"]+$/)
		loggEr("Log: Message \"#{textla }\" appears")
	else
		loggEr("Error: Message \"#{textla }\" does not appears")
	end
end





#Function to match the entry of a text field
def matchEntryText(entry, entryid, texten, driver)
	if driver.find_element(:id, "#{entryid}").attribute("value") == "#{texten}"
		loggEr("Log: #{texten} appears in the #{entry} field entry in id #{entryid}")
	else
		loggEr("Error: #{texten} does not appears in the #{entry} field entry in id #{entryid}")
	end
end

#Function to match link name and the url
def matchLinkandUrl(linkna, url, driver)
	link = driver.find_element(:link, "#{linkna}")
	if link
		loggEr("Log: #{linkna} link text appears as \"#{linkna}\"")
	else
		loggEr("Error: #{linkna} link text does not appear as \"#{linkna}\"")
	end

	if link.attribute("href") == "#{url}"
		loggEr("Log: #{linkna} link is #{url}")
	else
		loggEr("Error: #{linkna} link is not #{url} it is #{link.attribute("href")}")
	end
end

#Function to check that button exists
def checkButton(bttnna, driver)
	if driver.find_element(:name, "commit").attribute("value") == "#{bttnna}"
		loggEr("Log: Button #{bttnna} appears")
	else
		loggEr("Error: Button #{bttnna} does not appear")
	end
end

#Function to verify new user
def verifyNewlogin (usremail, driver)
		if driver.find_element(:css, "p").text.match(/^["Login: #{usremail}"]+$/)
		loggEr("Log: New registration was successfull, the user #{usremail} has been added")
	else
		loggEr("Error: User #{usremail} was not successful, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
end
end

#Function to verify that user name appears at the user info page
def verifyUserlogin (usremail, driver)
	if driver.find_element(:css, "p").text.match(/^["Login: #{usremail}"]+$/)
		loggEr("Log: User #{usremail} is currently logged in")
	else
		loggEr("Error: User #{usremail} is not currently logged in, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
	end
end


def getTopping(ordernum, name, double, driver)
	ordernum += 1
	if driver.find_element(:xpath, "//tr[#{ordernum}]/td[1]").text == "#{name}"
		loggEr("Log: Topping name #{name} is listed for this pizza")
	else
		loggEr("Error: Topping name #{name} is not listed for this pizza, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
	end
	if driver.find_element(:xpath, "//tr[#{ordernum}]/td[2]").text == "#{double}"
		loggEr("Log: Topping name #{name} double option is set to #{double}")
	else
		loggEr("Error: Topping name #{name} double option is not set to #{double}, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
	end
end

#Function to verify the checkbox was selected
def checkBox(inputid, checkname, driver)
	if driver.find_element(:xpath, "//input[@id='#{inputid}']").attribute("selected")
		loggEr("Log: Checkbox #{checkname} is selected")
	else
		loggEr("Error: Checkbox #{checkname} is not selected, closing #{BROWSER} and exiting script")
		driver.close
		exit 1
	end
end

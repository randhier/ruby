require "test/unit"
require "selenium-webdriver"
require "json"
#require "time"

module Suber


  def search
      @driver.find_element(:id, "gbqfq").clear
      @driver.find_element(:id, "gbqfq").send_keys "this is a test"
      @driver.find_element(:id, "gbqfb").click
      @driver.find_element(:id, "gbqfb").click
  end


end

class Google < Test::Unit::TestCase

  include Suber

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "https://www.google.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
    #@search = Suber.new()
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_google
    @driver.get(@base_url + "/")
    search
  end

end

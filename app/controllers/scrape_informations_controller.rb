require 'selenium-webdriver'
require 'nokogiri'
require 'httparty'

class ScrapeInformationsController < ApplicationController
  def index
    render json: { data: scrape_information_list.to_json }
  end

  # TODO: Need to refactor this into a service class
  def scrape_information_from_api
    @url = 'https://hamrobazaar.com/mobile-phone-handsets/apple-iphone-iphone-11-pro-max-256-gold-in-kathmandu/1a8657be4c084b33b65dd264fa9361d5'
    options = Selenium::WebDriver::Chrome::Options.new
    options.headless!
    driver = Selenium::WebDriver.for(:chrome, capabilities: [options])
    driver.get @url
    response = Nokogiri::HTML(driver.page_source)
    page_details = response.css('.page--details')
    page_details.each do |page_detail|
      @title = page_detail.css('.page--title').css('h3').text
      @description = page_detail.css('.ad--informations').css('.ad--desc').css('p').text
    end

    page_details_asides = response.css('.page--details--aside')
    page_details_asides.each do |aside|
      @price = aside.css('h2').text
      @phone_number = aside.css('.seller__infos').css('.seller__address').css('span').text
    end
    scrape_informations = {
      url: @url,
      title: @title,
      description: @description,
      price: @price,
      phone_number: @phone_number
    }
    @scrape_info = ScrapeInfo.create!(scrape_informations)
  end

  private

  def scrape_information_list
    @scrape_information_list = ScrapeInfo.order(:id)
  end
end

class ScrapeInformationsController < ApplicationController
  def index
    render json: { data: scrape_information_list.to_json }
  end

  # TODO: Need to refactor this into a service class
  def scrape_information_from_api
    url = 'https://hamrobazaar.com/mobile-phone-handsets/apple-iphone-iphone-11-pro-max-256-gold-in-kathmandu/1a8657be4c084b33b65dd264fa9361d5'
    scrape_results = WebScraper.call(url)
    scrape_infos = ScrapeInfo.create!(scrape_results)
    if scrape_infos.save
      render json: { data: scrape_infos, success: true, message: 'Scraped Successfully!' },
             status: :ok
    else
      render status: 401, json: {
        success: false,
        message: 'Scraped Failure!'
      }
    end
  rescue StandardError => e
    puts e.to_s
  end

  private

  def scrape_information_list
    @scrape_information_list = ScrapeInfo.order(:id)
  end
end

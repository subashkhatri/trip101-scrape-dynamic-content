Rails.application.routes.draw do
  get 'api/scrape_list', controller: 'scrape_informations', action: 'index'
  get 'api/scrape_information', controller: 'scrape_informations', action: 'scrape_information_from_api'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'scrape_informations#index'
end

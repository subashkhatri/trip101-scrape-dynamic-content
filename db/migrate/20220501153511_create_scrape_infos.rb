class CreateScrapeInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :scrape_infos do |t|
      t.string :url
      t.string :title
      t.string :description
      t.string :price
      t.string :phone_number

      t.timestamps
    end
  end
end

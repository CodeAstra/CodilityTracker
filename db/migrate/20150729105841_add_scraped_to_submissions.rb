class AddScrapedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :scraped, :boolean, default: false
  end
end

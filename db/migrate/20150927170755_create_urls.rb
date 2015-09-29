class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :long_url
      t.string :short_url
      t.integer :http_status, :default => 301 # default to :permanent
      t.timestamps
    end
  end
end

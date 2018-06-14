class CreateHits < ActiveRecord::Migration[5.2]
  def change
    create_table :hits do |t|
      t.string :ip
      t.string :browser
      t.string :referrer
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :operating_system
      t.references :shortlink, index: true

      t.timestamps
    end
  end
end

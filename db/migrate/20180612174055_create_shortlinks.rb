class CreateShortlinks < ActiveRecord::Migration[5.2]
  def change
    create_table :shortlinks do |t|
      t.string :link_hash, unique: true
      t.string :name, unique: true
      t.string :url, index: true

      t.timestamps
    end

    add_index :shortlinks, [:link_hash, :name, :url]
  end
end

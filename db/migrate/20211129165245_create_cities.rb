class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.references :country, null: false, foreign_key: true
      t.string :name, limit: 255, null: false

    end
    add_index :cities, [:country_id, :name], unique: true
  end
end

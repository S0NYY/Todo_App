class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.references :user, null: false, foreign_key: true
      t.string :phone_number, limit: 20
      t.date :birth_date
      t.text :about_me

    end
  end
end

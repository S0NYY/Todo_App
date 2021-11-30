class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 255, null: false
      t.string :username, limit: 255, null: false
      t.string :pin, limit: 11, null: false
      t.references :country, null: false, foreign_key: true
      t.references :city, null:false, foreign_key: true
      t.boolean :terms_of_use, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :pin, unique: true

  end
end

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :moderator, index: true, foreign_key: {  to_table: :users }
      t.string :title, limit: 255, null: false
      t.text :body, null: false
      t.datetime :published_at
      t.datetime :scheduled_at
      t.string :cancellation_reason

      t.timestamps
    end
  end
end

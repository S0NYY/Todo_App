class AddStatusStateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :status_state, :string
  end
end

class AddReactIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :react_id, :integer
  end
end

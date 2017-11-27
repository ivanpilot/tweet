class RemoveReactIdToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :react_id, :integer
  end
end

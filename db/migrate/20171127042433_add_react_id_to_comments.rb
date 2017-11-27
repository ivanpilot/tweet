class AddReactIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :react_id, :integer
  end
end

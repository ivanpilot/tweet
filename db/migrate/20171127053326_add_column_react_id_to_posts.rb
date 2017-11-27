class AddColumnReactIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :react_id, :string
  end
end

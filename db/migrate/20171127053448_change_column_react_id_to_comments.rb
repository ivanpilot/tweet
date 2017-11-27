class ChangeColumnReactIdToComments < ActiveRecord::Migration[5.1]
  def change
    change_column :comments, :react_id, :string
  end
end

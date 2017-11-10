class ChangeColumnNameToPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :user_id, :author_id
  end
end

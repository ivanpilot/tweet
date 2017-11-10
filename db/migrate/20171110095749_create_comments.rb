class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :post_id
      t.integer :commenter_id

      t.timestamps
    end
  end
end

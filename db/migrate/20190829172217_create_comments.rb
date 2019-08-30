class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.timestamps
    end
    add_reference( :comments, :author, foreign_key: {to_table: :users} )
    add_reference( :comments, :post, foreign_key: {to_table: :posts} )
  end
end

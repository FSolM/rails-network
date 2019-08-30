class CreateReactions < ActiveRecord::Migration[5.2]
  def change
    create_table :reactions do |t|
      t.integer :reaction_type, default: 0

      t.timestamps
    end
    add_reference( :reactions, :user, foreign_key: { to_table: :users })
    add_reference( :reactions, :post, foreign_key: { to_table: :posts })
  end
end

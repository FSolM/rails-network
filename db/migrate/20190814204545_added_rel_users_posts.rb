# frozen_string_literal: true

class AddedRelUsersPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference(:posts, :author, foreign_key: { to_table: :users })
  end
end

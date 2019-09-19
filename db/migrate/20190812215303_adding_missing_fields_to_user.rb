# frozen_string_literal: true

class AddingMissingFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_link, :string
    add_column :users, :name, :string
    add_column :users, :birth_day, :datetime
    add_column :users, :bio, :text
  end
end

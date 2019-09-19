# frozen_string_literal: true

class BirthDayDatatipeChange < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :birth_day, :date
  end
end

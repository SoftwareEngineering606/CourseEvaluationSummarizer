# frozen_string_literal: true

class CreateExcelSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :excel_sheets do |t|
      t.string :name
      t.text :description
      t.binary :file_data

      t.timestamps
    end
  end
end

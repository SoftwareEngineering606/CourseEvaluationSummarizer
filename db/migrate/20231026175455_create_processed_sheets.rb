# frozen_string_literal: true

class CreateProcessedSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :processed_sheets, id: :integer, primary_key: :report_id_final do |t|
      t.string :name
      t.text :description
      t.binary :file_data
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :user_id
      t.string :report_name
      t.string :report_path
    end
  end
end

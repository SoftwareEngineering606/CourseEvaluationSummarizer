# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
processed_sheets = [
  { name: 'Dummy Sheet 1', description: 'Description for Sheet 1', file_data: '...' },
  { name: 'Dummy Sheet 2', description: 'Description for Sheet 2', file_data: '...' },
  { name: 'Dummy Sheet 3', description: 'Description for Sheet 3', file_data: '...' }
]

# Seed ExcelSheet data
processed_sheets.each do |processed_sheets_params|
  ProcessedSheet.create(processed_sheets_params)
end

class AddDetailsToExcelSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :excel_sheets, :user_id, :integer
    add_column :excel_sheets, :report_id, :integer
    add_column :excel_sheets, :report_name, :string
    add_column :excel_sheets, :report_path, :string
  end
end

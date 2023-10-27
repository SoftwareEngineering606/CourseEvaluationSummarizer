class AddUploadedFilesToExcelSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :excel_sheets, :uploaded_files, :binary
  end
end

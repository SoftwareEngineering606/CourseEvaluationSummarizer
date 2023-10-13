class AddIsProcessesToExcelSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :excel_sheets, :isProcessed, :string
  end
end

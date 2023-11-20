# Assuming you have a factory for ProcessedSheet defined in factories.rb
# spec/factories/processed_sheets.rb
FactoryBot.define do
    factory :processed_sheet do
      # your other attributes if any
      # Define default values for attributes
      
  
      transient do
        report_id_final { nil }
      end
  
      after(:build) do |processed_sheet, evaluator|
        processed_sheet.report_id_final = evaluator.report_id_final if evaluator.report_id_final.present?
      end
    end
  end
  
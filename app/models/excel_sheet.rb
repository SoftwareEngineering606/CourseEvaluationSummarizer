# frozen_string_literal: true

class ExcelSheet < ApplicationRecord
  has_many_attached :uploaded_files
end

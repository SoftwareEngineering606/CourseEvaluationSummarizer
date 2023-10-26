# frozen_string_literal: true

class ExcelSheet < ApplicationRecord
  has_one_attached :uploaded_file
end

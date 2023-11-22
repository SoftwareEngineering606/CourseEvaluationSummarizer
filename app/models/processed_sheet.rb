# frozen_string_literal: true

class ProcessedSheet < ApplicationRecord
    validates :name, presence: true
end

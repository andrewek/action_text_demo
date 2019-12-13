# frozen_string_literal: true

class Essay < ApplicationRecord
  validates :title, presence: true
  has_rich_text :body
end

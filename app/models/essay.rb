# frozen_string_literal: true

class Essay < ApplicationRecord
  has_rich_text :essay_body
  validates :title, presence: true
end

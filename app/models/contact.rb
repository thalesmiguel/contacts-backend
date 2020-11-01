# frozen_string_literal: true

# Contact model. Makes use of paper_trail to store update history
class Contact < ApplicationRecord
  include Validators::ContactValidator

  has_paper_trail on: [:update], ignore: [:updated_at], versions: { scope: -> { order('id desc') } }
end

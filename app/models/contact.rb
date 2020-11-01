# frozen_string_literal: true

class Contact < ApplicationRecord
  include Validators::ContactValidator

  has_paper_trail on: [:update], ignore: [:updated_at], versions: { scope: -> { order('id desc') } }
end

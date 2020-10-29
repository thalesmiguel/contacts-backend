# frozen_string_literal: true

class Contact < ApplicationRecord
  include Validators::ContactValidator
end

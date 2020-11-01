# frozen_string_literal: true

module Rest
  # Presenter class for Contact
  class ContactPresenter
    def initialize(model)
      @model = model
    end

    def as_json
      model&.attributes
    end

    private

    attr_reader :model
  end
end

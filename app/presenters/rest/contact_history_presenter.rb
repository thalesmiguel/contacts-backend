# frozen_string_literal: true

module Rest
  # Presenter class for ContactHistory
  class ContactHistoryPresenter
    def initialize(versions)
      @versions = versions
    end

    def as_json
      return [] if versions.blank?

      versions.map do |version|
        {
          updated_at: version.created_at,
          changes: changes(version.changeset)
        }
      end
    end

    private

    attr_reader :versions

    def changes(changeset)
      changeset.map { |key, val| { attribute: key, old_value: val.first, new_value: val.last } }
    end
  end
end

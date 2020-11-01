# frozen_string_literal: true

# Contact-related service methods
class ContactsService
  delegate :all, :find, to: :model

  def initialize
    @model = Contact
  end

  def history(id)
    find(id).versions
  end

  def create(params)
    model.new(params).tap(&:save!)
  end

  def update(id, params)
    find(id).tap { |contact| contact.update!(params) }
  end

  def destroy(id)
    find(id).destroy
  end

  private

  attr_reader :model
end

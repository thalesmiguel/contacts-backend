# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rest::ContactsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/rest/contacts').to route_to('rest/contacts#index')
    end

    it 'routes to #show' do
      expect(get: '/rest/contacts/1').to route_to('rest/contacts#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/rest/contacts').to route_to('rest/contacts#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/rest/contacts/1').to route_to('rest/contacts#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/rest/contacts/1').to route_to('rest/contacts#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/rest/contacts/1').to route_to('rest/contacts#destroy', id: '1')
    end
  end
end

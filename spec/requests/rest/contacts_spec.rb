# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/contacts', type: :request do
  let(:valid_attributes) { attributes_for(:contact) }
  let(:invalid_attributes) { attributes_for(:contact, first_name: nil) }
  let(:valid_headers) { { 'Accept': 'application/json' } }

  let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

  describe 'GET /index' do
    it 'renders a successful response' do
      Contact.create! valid_attributes
      get rest_contacts_url, headers: valid_headers, as: :json

      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    context 'when record exists' do
      it 'renders a successful response' do
        contact = Contact.create! valid_attributes
        get rest_contact_url(contact), as: :json

        expect(response).to be_successful
      end
    end

    context 'when record does not exist' do
      it 'renders a JSON response with error' do
        get rest_contact_url(9_999_999), as: :json

        expect(response).to have_http_status(:not_found)
        expect(json_response).to eq(errors: "Couldn't find Contact with 'id'=9999999")
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Contact' do
        expect do
          post rest_contacts_url,
               params: { contact: valid_attributes }, headers: valid_headers, as: :json

        end.to change(Contact, :count).by(1)
      end

      it 'renders a JSON response with the new contact' do
        post rest_contacts_url,
             params: { contact: valid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Contact' do
        expect do
          post rest_contacts_url,
               params: { contact: invalid_attributes }, as: :json

        end.to change(Contact, :count).by(0)
      end

      it 'renders a JSON response with errors for the new contact' do
        post rest_contacts_url,
             params: { contact: invalid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(json_response).to eq(errors: { first_name: ["can't be blank"] })
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for(:contact)
      end

      it 'updates the requested contact' do
        contact = Contact.create! valid_attributes
        patch rest_contact_url(contact),
              params: { contact: new_attributes }, headers: valid_headers, as: :json

        expect(json_response.except(:id, :created_at, :updated_at)).to eq(new_attributes)
      end

      it 'renders a JSON response with the contact' do
        contact = Contact.create! valid_attributes
        patch rest_contact_url(contact),
              params: { contact: new_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the contact' do
        contact = Contact.create! valid_attributes
        patch rest_contact_url(contact),
              params: { contact: invalid_attributes }, headers: valid_headers, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(json_response).to eq(errors: { first_name: ["can't be blank"] })
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested contact' do
      contact = Contact.create! valid_attributes
      expect do
        delete rest_contact_url(contact), headers: valid_headers, as: :json
      end.to change(Contact, :count).by(-1)
    end
  end
end

# frozen_string_literal: true

module Rest
  class ContactsController < ApplicationController
    # GET /contacts
    def index
      contacts = ContactsService.new.all

      render json: { collection: contacts.each { |contact| ContactPresenter.new(contact).as_json } }
    end

    # GET /contacts/:id
    def show
      render json: ContactPresenter.new(
        ContactsService.new.find(params[:id])
      ).as_json
    end

    # GET /contacts/:id/history
    def history
      contact_history = ContactsService.new.history(params[:id])

      render json: { collection: ContactHistoryPresenter.new(contact_history).as_json }
    end

    # POST /contacts
    def create
      contact = ContactsService.new.create(contact_params)

      render json: ContactPresenter.new(contact).as_json, status: :created, location: rest_contact_url(contact.id)
    end

    # PATCH/PUT /contacts/:id
    def update
      contact = ContactsService.new.update(params[:id], contact_params)

      render json: ContactPresenter.new(contact).as_json
    end

    # DELETE /contacts/:id
    def destroy
      ContactsService.new.destroy(params[:id])
    end

    private

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end

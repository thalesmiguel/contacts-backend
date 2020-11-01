# frozen_string_literal: true

module Rest
  class ContactsController < ApplicationController
    # GET /contacts
    def index
      @contacts = ContactsService.new.all

      render json: { collection: @contacts }
    end

    # GET /contacts/:id
    def show
      render json: ContactsService.new.find(params[:id])
    end

    # GET /contacts/:id/history
    def history
      render json: { collection: ContactsService.new.history(params[:id]) }
    end

    # POST /contacts
    def create
      contact = ContactsService.new.create(contact_params)

      render json: contact, status: :created, location: rest_contact_url(contact.id)
    end

    # PATCH/PUT /contacts/:id
    def update
      contact = ContactsService.new.update(params[:id], contact_params)

      render json: contact
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

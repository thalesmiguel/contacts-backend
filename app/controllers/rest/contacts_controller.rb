# frozen_string_literal: true

module Rest
  class ContactsController < ApplicationController
    before_action :set_contact, only: %i[show update destroy]

    # GET /contacts
    def index
      @contacts = Contact.all

      render json: { collection: @contacts }
    end

    # GET /contacts/:id
    def show
      render json: @contact
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)
      @contact.save!

      render json: @contact, status: :created, location: rest_contact_url(@contact.id)
    end

    # PATCH/PUT /contacts/:id
    def update
      @contact.update!(contact_params)

      render json: @contact
    end

    # DELETE /contacts/:id
    def destroy
      @contact.destroy
    end

    private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number)
    end
  end
end

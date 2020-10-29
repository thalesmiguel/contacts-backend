# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :rest do
    resources :contacts
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :rest do
    resources :contacts do
      member do
        get :history
      end
    end
  end
end

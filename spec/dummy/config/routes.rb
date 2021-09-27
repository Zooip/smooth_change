# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "api/test_opt_in", to: "api#test_opt_in"
  get "api/test_opt_out", to: "api#test_opt_out"
  get "api/test_model", to: "api#test_model"
end

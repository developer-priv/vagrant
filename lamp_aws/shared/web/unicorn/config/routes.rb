Rails.application.routes.draw do
  root 'main#index'

  get '/dashboard/booking_availability', to: 'dashboard#booking_availability'
end

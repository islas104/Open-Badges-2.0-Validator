Rails.application.routes.draw do
    root 'badge_validations#new'
    get  'badge_validations/new'
    post 'badge_validations/validate'
  
    # Health check route (if needed)
    get "up" => "rails/health#show", as: :rails_health_check
  end
  
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "application#index" 

  namespace :services do 
    namespace :api do 
    	get 'auth/token', to: 'auth#token'

    	namespace :v1 do
    		get 'products/:product_number', to: 'products#show'
    	end
    end
  end
end

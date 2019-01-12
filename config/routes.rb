Rails.application.routes.draw do

  root 'welcome#index'

  namespace :api do
    resources :products


    scope '/users' do

      get ':id',
          to: 'users#show'

      post 'addToCart',
           to: 'users#add_to_cart'

      post 'create',
           to: 'users#create'

      get 'showCart',
          to: 'users#show_cart'

      get 'showCartTotal',
          to: 'users#show_cart_total'

      delete 'removeFromCart',
        to: 'users#remove_from_cart'


    end

  end


end

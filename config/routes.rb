Rails.application.routes.draw do

  root 'welcome#index'

  namespace :api do
    resources :products


    scope '/users' do

      get ':id',
          as: 'user_details',
          to: 'users#show'

      get '/',
          as: 'user_list',
          to: 'users#list'

      post '/',
           as: 'create_user',
           to: 'users#create'

      post ':id/addToCart',
           as: 'add_to_cart',
           to: 'users#add_to_cart'



      get ':id/showCart',
          as: 'show_cart',
          to: 'users#show_cart'

      get ':id/showCartTotal',
          as: 'show_cart_total',
          to: 'users#show_cart_total'


      delete 'removeFromCart/:id',
             as: 'remove_from_cart',
        to: 'users#remove_from_cart'


      post ':id/checkout',
           as: 'checkout',
           to: 'users#checkout'


    end

  end


end

Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

root to: 'public/homes#top'


 namespace :public do
   get "/unsubscribe" => "users#unsbscribe"
   patch "withdrawal" => "users#withdrawal"

   resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update ] do
    resources :post_comments, only: [:create, :destroy ]
    resource :favorites, only:[:create, :destroy]
   end

   resources :users, only: [:show, :edit, :update ]
  end

   namespace :admin do
    get "/" => "homes#top"
    # resources :posts, only: [:index, :show]
    resources :post_comments, only:[:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

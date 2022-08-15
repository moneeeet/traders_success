Rails.application.routes.draw do

  namespace :admin do
    get 'reports/index'
    get 'reports/show'
    get 'reports/update'
  end
  namespace :public do
    get 'reports/new'
    get 'reports/create'
  end
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
   get "/unsubscribe" => "users#unsubscribe"
   patch "withdrawal" => "users#withdrawal"
   get 'post/search' => 'posts#search'

   resources :posts, only: [:new, :index, :show, :edit, :create, :destroy, :update ] do
    resources :post_comments, only: [:create, :destroy ]
    resources :comment_reports, only: [:new, :create]
    resource :favorites, only:[:create, :destroy]
   end



   resources :users, only: [:show, :edit, :update, :index] do
     member do
      get :favorites
     end
     resources :reports, only: [:new, :create]
   end
  end

   namespace :admin do
    get "/"=>"homes#top"
    patch "users/:id/is_deleted" =>"users#is_deleted", as: "is_deleted"
    # resources :posts, only: [:index, :show]
    resources :post_comments, only:[:destroy]
    resources :reports, only: [:index, :show, :update]
    resources :users, only: [:index, :show, :update, :edit]
    resources :comment_reports, only: [:index, :show, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

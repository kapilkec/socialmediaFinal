Rails.application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For devise

  # devise_for :deviseusers

  # devise_scope :deviceuser do
  #   get '/users', to: 'devise/registrations#new'
  #   get '/users/password', to: 'devise/passwords#new'
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


 get 'storys', to: 'storys#index'
   delete 'delete/story', to:'storys#delete', as: 'delete_story'
   post 'create/story', to:'storys#create', as:'new_story'
   get 'add/story', to:"storys#new", as:"add_story"

  get 'allusers', to: 'friends#index'
  get 'allusers/following', to: 'friends#following'
  get 'allusers/followers', to: 'friends#followers'
  post 'friends/Following', to: 'friends#create', as: 'set_follow'
    delete 'friends/unFollowing', to: 'friends#destroy', as: 'set_unfollow'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  delete 'posts/like/delete', to: 'likes#destroyPostLike', as:'post_unlike'
  post 'posts/like/create', to: 'likes#createLikeForPost', as:'post_like'

  post 'comments/like/create', to: 'likes#createLikeForComment', as:'comment_like'
  post 'comments/like/delete', to: 'likes#deleteCommentLike', as:'comment_unlike'

  # Defines the root path route ("/")
  # For group
  get 'groups', to:'groups#show'
  get 'groups/new' , to:'groups#new'
  get 'groups/mygroups' , to:'groups#mygroups'
  post 'groups/new/create' , to:'groups#create', as:'new_group'
  post 'groups/addUser', to:'members#create', as:'add_to_group'
  post 'groups/deleteGroups', to:'groups#delete', as:'delete_group'
  get 'groups/:id/view', to: 'groups#view', as:'view_group'
  get 'groups/join', to: 'groups#join', as:'join_group'



  # get 'groups/mygroups', to:'groups#mygroup'

  root "posts#index"
  resources :likes, only: [:create, :destroy]
  resources :posts do
    resources :comments
  end

  # get 'posts/:postid/comment/:id/', to:'memb'

  resources :users do
    resources :likes
  end
  resources :storys


  # for notifications
    get 'notifications/all', to: 'notifications#view', as:'notifications_all'
    post 'notifications/markasread', to:'notifications#markAsRead', as:'notifications_mark_as_read'



# ``````````````````````````````api start``````````````````````````````````````````````````````
    # For api
    namespace :api ,default: {format: :json} do
      devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For devise

  # devise_for :deviseusers

  # devise_scope :deviceuser do
  #   get '/users', to: 'devise/registrations#new'
  #   get '/users/password', to: 'devise/passwords#new'
  #   get '/users/sign_out' => 'devise/sessions#destroy'
  # end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }


 get 'storys', to: 'storys#index'
   delete 'delete/story/:id', to:'storys#delete', as: 'delete_story'
   post 'create/story', to:'storys#create', as:'new_story'
   get 'add/story', to:"storys#new", as:"add_story"

  get 'allusers', to: 'friends#index'
  get 'allusers/following', to: 'friends#following'
  get 'allusers/followers', to: 'friends#followers'
  post 'friends/Following', to: 'friends#create', as: 'set_follow'
  delete 'friends/unFollowing/:id', to: 'friends#destroy', as: 'set_unfollow'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  delete 'posts/like/delete', to: 'likes#destroyPostLike', as:'post_unlike'
  post 'posts/like/create', to: 'likes#createLikeForPost', as:'post_like'

  post 'comments/like/create', to: 'likes#createLikeForComment', as:'comment_like'
  post 'comments/like/delete', to: 'likes#deleteCommentLike', as:'comment_unlike'

  # Defines the root path route ("/")
  # For group
  get 'groups', to:'groups#show'
  post 'groups/new/create' , to:'groups#create', as:'new_group'
  delete 'groups/deleteGroups/:group_id', to:'groups#delete', as:'delete_group'



  # get 'groups/mygroups', to:'groups#mygroup'

  root "posts#index"

  get 'posts/zerolikes', to: 'posts#postWithZeroLike', as:'post_zerolike'
  get 'posts/mostlikes', to: 'posts#postWithMoreLikes', as:'post_mostlike'
  get 'posts/mostComments', to: 'posts#postWithMoreComments', as:'post_mostComments'
  get 'groups/mostgroups', to: 'groups#userWithMoreGroups', as:'user_mostGroups'

  resources :likes, only: [:create, :destroy]
  resources :posts do
    resources :comments
  end

  # get 'posts/:postid/comment/:id/', to:'memb'

  resources :users do
    resources :likes
  end
  resources :storys


  # for notifications
    get 'notifications/all', to: 'notifications#view', as:'notifications_all'
    post 'notifications/markasread', to:'notifications#markAsRead', as:'notifications_mark_as_read'


    end
    # end for api

end

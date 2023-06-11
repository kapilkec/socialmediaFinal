Rails.application.routes.draw do
  get 'storys', to: 'storys#index'
   delete 'delete/story', to:'storys#delete', as: 'delete_story'
   post 'create/story', to:'storys#create', as:'new_story'

  get 'allusers', to: 'friends#index'
  get 'allusers/following', to: 'friends#following'
  get 'allusers/followers', to: 'friends#followers'
  post 'friends/Following', to: 'friends#create', as: 'set_follow'
    delete 'friends/unFollowing', to: 'friends#destroy', as: 'set_unfollow'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'posts/like/delete', to: 'likes#destroyPostLike', as:'post_unlike'
  post 'posts/like/create', to: 'likes#createLikeForPost', as:'post_like'

  post 'comments/like/create', to: 'likes#createLikeForComment', as:'comment_like'
  post 'comments/like/delete', to: 'likes#deleteCommentLike', as:'comment_unlike'

  # Defines the root path route ("/")
  root "posts#index"
  resources :likes, only: [:create, :destroy]
  resources :posts do
    resources :comments
  end
  resources :users do
    resources :likes
  end
  resources :storys

end
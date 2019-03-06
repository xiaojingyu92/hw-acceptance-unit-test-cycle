Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'movies/same_director/:title' => 'movies#search_same_director', as: :search_same_director
end

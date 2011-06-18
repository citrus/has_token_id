run "rails g scaffold item token:string name:string"

gsub_file "app/models/item.rb", "end", %(
  has_token
  
end)

gsub_file "config/routes.rb", "resources :items", %(
  resources :items
  root :to => "items#index")

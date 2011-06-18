run "rails g scaffold item token:string name:string"

gsub_file "app/models/item.rb", "end", %(
  has_token
  
end)

migration = Dir.entries(File.join(destination_path, "db/migrate")).last
gsub_file File.join("db/migrate/", migration), "t.string :token", "t.token"

gsub_file "config/routes.rb", "resources :items", %(
  resources :items
  root :to => "items#index")

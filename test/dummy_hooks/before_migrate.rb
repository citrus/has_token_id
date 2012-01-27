# Generate an Item model
run "rails g scaffold item token:string name:string"

# Add has_token_id to our Item model
gsub_file "app/models/item.rb", "end", %(
  has_token_id
  
end)

# Ensure our migration is using our `token` TableDefinition
@migration = File.basename(Dir[File.expand_path("db/migrate/*.rb", destination_path)].last)
gsub_file File.join("db/migrate/", @migration), "t.string :token", "t.token"

# Route items#index as the root path
gsub_file "config/routes.rb", "resources :items", %(
  resources :items
  root :to => "items#index")

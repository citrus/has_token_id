# Generate an Item model
run "rails g scaffold item name:string"

# Add has_token_id to our Item model
gsub_file "app/models/item.rb", "end", %(
  has_token_id

end)

# Replace the delete link with a button since we won't have js in the demo
gsub_file "app/views/items/index.html.erb", %(link_to 'Destroy'), %(button_to 'Destroy')

# Ensure our migration is using our `token` TableDefinition
@migration = File.basename(Dir[File.expand_path("db/migrate/*.rb", destination_path)].last)
gsub_file File.join("db/migrate/", @migration), "t.string :name", "t.token\n      t.string :name"

# Route items#index as the root path
gsub_file "config/routes.rb", "resources :items", %(
  resources :items
  root :to => "items#index")

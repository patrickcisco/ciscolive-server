Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/api/v2/cmx/ap_stats' => 'location#ap_stats'
  post '/api/v2/cmx/client/count' => 'location#client_count'
end

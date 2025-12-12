Rails.application.routes.draw do
  root to: 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  get "dashboard/index"
  match 'voting/votes' => 'votes#create', via: :post
  get 'voting/contestants', to: 'contestants#names'
  get 'voting/total', to: 'votes#total'
  get 'voting/total_by_hour', to: 'votes#total_by_hour'
  get 'voting/current_percentage', to: 'votes#current_percentage'
end

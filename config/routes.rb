Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      namespace :private do
        get 'locations/:country_code' => 'countries#locations'
        get 'target_groups/:country_code' => 'countries#target_groups'
        post 'evaluate_target' => 'countries#evaluate_target'
      end
      namespace :public do
        get 'locations/:country_code' => 'countries#locations'
        get 'target_groups/:country_code' => 'countries#target_groups'
      end
    end
  end
end

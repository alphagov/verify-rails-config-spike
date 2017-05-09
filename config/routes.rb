Rails.application.routes.draw do

  get 'config/idps/enabled' => 'idps#all'
  resources :idps, path: '/config/idps', id: /[A-Za-z0-9%._-]+/ do
    resources :idp_display_data, path: '/display-data', only: [:index]
    resources :idp_enabled, path: '/enabled', only: [:index]
  end

  get 'config/transactions/enabled' => 'transactions#all'
  resources :transactions, path: '/config/transactions', id: /[A-Za-z0-9%._-]+/ do
    resources :transactions_display_data, path: '/display-data', only: [:index]
    resources :transactions_levels_of_assurance, path: '/levels-of-assurance', only: [:index]
    resources :transactions_assertion_consumer_service_uri, path: '/assertion-consumer-service-uri', only: [:index]
    resources :transactions_eidas_enabled, path: '/eidas-enabled', only: [:index]
  end

  resources :certificates, path: '/config/certificates', id: /[A-Za-z0-9%._-]+/ do
    resources :certificates_signing, path: '/certs/signing', only: [:index]
  end

  root 'config#index'
end

# Learning Session: write a replacement `config` microservice using Ruby on Rails

**Note:** this is very ambitious in the time we have

**The tl;dr for doing this in the open is - do not put any of this on a public github repo**

## Background

The Verify hub uses several microservices that are mainly Java/Dropwizard.  One of them is `config`.  `config` is used as the source of truth for hub federation configuration by all core hub microservices.  It is essentially a [REST](https://en.wikipedia.org/wiki/Representational_state_transfer) interface over some YAML files.  It used to have more responsibilities but they have reduced over time.  In some older design documents it hints that config would have a [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) interface.

## Challenge

> Write a replacement for config that provides a CRUD interface and allows hub to consume an AuthnRequest from test-rp (i.e. start at test-rp and get to /start)

**Note:** hub caches config so you should restart hub when using your new config service

Rails has an excellent [getting started guide](http://guides.rubyonrails.org/getting_started.html), let's use that.  Work on your own, in pairs or a mob - whatever is best.

`config` provides information about:
* transactions
* identity providers
* matching services [support for these can be left out of this exercise as we are only looking at the very start of the hub journey]

### Plan 

You'll want to make:
* User interface to add/view/delete transactions + identity providers
* Models to represent transactions + identity providers
* Controllers and Views to process requests for information

**Note:** do not call the model Transaction[s], it conflicts with Rails internals

We'll work in the same room and will break to talk about it every hour, with a wrap up discussion towards the end of the day.

### Notes

* most calls to config use path params, notably one doesn't, but if you just ignore that for now you will still be able to progress
* entityIds are url encoded into the path param - you'll need to deal with that
* in this challenge there is no need to consume the existing YAML
* tl;dr for doing this in the open is - do not put any of this on a public github repo

### Pre-requisites

* Ruby installed and ready to go
* Best to have a local copy of hub to run your `config` against (you could write a service without testing it though)

### Spoilers

<details>
  <summary>Spoiler: listing of config's resources</summary>
  <p>

```
    GET     /config/certificates/health-check (uk.gov.ida.hub.config.resources.CertificatesResource)
    GET     /config/certificates/invalid (uk.gov.ida.hub.config.resources.CertificatesResource)
    GET     /config/certificates/{entityId}/certs/encryption (uk.gov.ida.hub.config.resources.CertificatesResource)
    GET     /config/certificates/{entityId}/certs/signing (uk.gov.ida.hub.config.resources.CertificatesResource)
    GET     /config/countries (uk.gov.ida.hub.config.resources.CountriesResource)
    GET     /config/idps/enabled (uk.gov.ida.hub.config.resources.IdentityProviderResource)
    GET     /config/idps/{entityId}/display-data (uk.gov.ida.hub.config.resources.IdentityProviderResource)
    GET     /config/idps/{entityId}/enabled (uk.gov.ida.hub.config.resources.IdentityProviderResource)
    GET     /config/matching-services (uk.gov.ida.hub.config.resources.MatchingServiceResource)
    GET     /config/matching-services/{entityId} (uk.gov.ida.hub.config.resources.MatchingServiceResource)
    GET     /config/transactions/enabled (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/assertion-consumer-service-uri (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/display-data (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/eidas-enabled (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/levels-of-assurance (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/matching-process (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/matching-service-entity-id (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/should-hub-sign-response-messages (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/should-hub-use-legacy-saml-standard (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /config/transactions/{entityId}/user-account-creation-attributes (uk.gov.ida.hub.config.resources.TransactionsResource)
    GET     /internal/version-info (uk.gov.ida.resources.VersionInfoResource)
    GET     /service-name (uk.gov.ida.resources.ServiceNameResource)
    GET     /service-status (uk.gov.ida.resources.ServiceStatusResource)
```
</details>

<details>
  <summary>Spoiler: listing of what is accessed on config to process the start of a new journey</summary>
  <p>

```
 "GET /config/certificates/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/certs/signing HTTP/1.1" 200 1623 "-" "SamlProxy Service (samlProxyClient)" 30
 "GET /config/certificates/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/certs/signing HTTP/1.1" 200 1623 "-" "Saml Engine Service (samlEngineClient)" 5
 "GET /config/transactions/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/assertion-consumer-service-uri HTTP/1.1" 200 49 "-" "Policy Service (policyClient)" 16
 "GET /config/transactions/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/eidas-enabled HTTP/1.1" 200 4 "-" "Policy Service (policyClient)" 4
 "GET /config/idps/enabled?transactionEntityId=http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD HTTP/1.1" 200 566 "-" "Policy Service (policyClient)" 21
 "GET /config/transactions/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/levels-of-assurance HTTP/1.1" 200 11 "-" "Policy Service (policyClient)" 5
 "GET /config/transactions/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/display-data HTTP/1.1" 200 95 "-" "Frontend Service (frontendClient)" 8
 "GET /config/transactions/http%3A%2F%2Fwww.test-rp.gov.uk%2FSAML2%2FMD/levels-of-assurance HTTP/1.1" 200 11 "-" "Frontend Service (frontendClient)" 2
 "GET /config/idps/http%3A%2F%2Flocalhost%3A50400%2Fmetadata/display-data HTTP/1.1" 200 121 "-" "Frontend Service (frontendClient)" 6
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fstub-idp-two%2FSSO%2FPOST/display-data HTTP/1.1" 200 124 "-" "Frontend Service (frontendClient)" 4
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fstub-idp-demo%2FSSO%2FPOST/display-data HTTP/1.1" 200 124 "-" "Frontend Service (frontendClient)" 2
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fexperian%2FSSO%2FPOST/display-data HTTP/1.1" 200 120 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fmorpho%2FSSO%2FPOST/display-data HTTP/1.1" 200 108 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fcitizensafe%2FSSO%2FPOST/display-data HTTP/1.1" 200 113 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fdigidentity%2FSSO%2FPOST/display-data HTTP/1.1" 200 123 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fstud-idp-three%2FSSO%2FPOST/display-data HTTP/1.1" 200 126 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fbarclays%2FSSO%2FPOST/display-data HTTP/1.1" 200 110 "-" "Frontend Service (frontendClient)" 3
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fpost-office-test-rp%2FSSO%2FPOST/display-data HTTP/1.1" 200 118 "-" "Frontend Service (frontendClient)" 2
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Fheadless-idp%2FSSO%2FPOST/display-data HTTP/1.1" 200 124 "-" "Frontend Service (frontendClient)" 2
 "GET /config/idps/http%3A%2F%2Fstub_idp.acme.org%2Froyal-mail%2FSSO%2FPOST/display-data HTTP/1.1" 200 112 "-" "Frontend Service (frontendClient)" 4
```
</details>

<details>
  <summary>Spoiler: here is a `routes.rb` file that may help</summary>
  <p>
  
  <details>
    <summary>are you really sure that you don't want to try and do this yourself first?</summary>
    <p>
    
```ruby
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
```
</details>
</details>

<details>
  <summary>Spoiler: here is model generation command for transactions that may help</summary>
  <p>
  
`./bin/rails generate model RPTransaction simple_id:string eidas_enabled:boolean entity_id:string signing_cert:string levels_of_assurance:string assertion_consumer_service_uri:string service_homepage:string`
</details>

<details>
  <summary>Spoiler: here is model generation command for identity providers that may help</summary>
  <p>
  
`./bin/rails generate model Idp simple_id:string enabled:boolean entity_id:string signing_cert:string`
</details>

<details>
  <summary>Spoiler: here is `routes.rb` along with details about what each should return</summary>
  <p>
   
```ruby
 Rails.application.routes.draw do
 
   # render json: @idps
   get 'config/idps/enabled' => 'idps#all'
   resources :idps, path: '/config/idps', id: /[A-Za-z0-9%._-]+/ do
     # render json: { simpleId: 'stub-idp-two', enabled: true, supportedLevelsOfAssurance: [ 'LEVEL_2' ], useExactComparisonType: false }
     resources :idp_display_data, path: '/display-data', only: [:index]
     # render json: { enabled: @idp.enabled }
     resources :idp_enabled, path: '/enabled', only: [:index]
   end
 
   # render json: @transactions
   get 'config/transactions/enabled' => 'transactions#all'
   resources :transactions, path: '/config/transactions', id: /[A-Za-z0-9%._-]+/ do
     # render json: { simpleId: @transaction.simple_id, loaList: [ @transaction.levels_of_assurance ], serviceHomepage: @transaction.service_homepage }
     resources :transactions_display_data, path: '/display-data', only: [:index]
     # render json: [ @transaction.levels_of_assurance ]
     resources :transactions_levels_of_assurance, path: '/levels-of-assurance', only: [:index]
     # render json: { target: @transaction.assertion_consumer_service_uri }
     resources :transactions_assertion_consumer_service_uri, path: '/assertion-consumer-service-uri', only: [:index]
     # render json: @transaction.eidas_enabled
     resources :transactions_eidas_enabled, path: '/eidas-enabled', only: [:index]
   end
 
   resources :certificates, path: '/config/certificates', id: /[A-Za-z0-9%._-]+/ do
     # render json: [{issuerId: entity_id, certificate: @entity.signing_cert, keyUse: 'SIGNING', federationEntityType: 'RP'}]
     resources :certificates_signing, path: '/certs/signing', only: [:index]
   end
 
   root 'config#index'
 end 
 ```
</details>
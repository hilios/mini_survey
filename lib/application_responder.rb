class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder

  # Uncomment this responder if you want your resources to redirect to the collection
  # path (index action) instead of the resource path for POST/PUT/DELETE requests.
  include Responders::CollectionResponder
end

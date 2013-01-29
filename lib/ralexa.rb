%w{
  abstract_service
  canonicalized_query_string
  client
  result
  lazy_collection
  paginating_collection
  paginator
  session
  top_sites
  url_info
  uri_signer
  version
}.each do |file|
  require "ralexa/#{file}"
end

module Ralexa

  # An authenticated Session instance.
  # Holds credentials, provides access to service instances.
  def self.session(access_key_id, secret_access_key)
    Session.new(access_key_id, secret_access_key)
  end

end

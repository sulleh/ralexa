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
  def self.session(api_key)
    Session.new(api_key)
  end

end

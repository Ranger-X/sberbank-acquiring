require "sberbank/acquiring/constants"
require "sberbank/acquiring/service_base"

module Sberbank::Acquiring
  class ServiceREST < ServiceBase

    def initialize(client, methods_data, version = :v1)
      super(client, methods_data)
      @version = version
    end

    def exec_request(method, request_body = {})
      @client.gateway.request method, request_body, 'rest', @version
    end
  end
end
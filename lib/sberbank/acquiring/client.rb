require "sberbank/acquiring/constants"
require "sberbank/acquiring/gateway"
require "sberbank/acquiring/service_rest"
require "sberbank/acquiring/exception"

require 'time'

module Sberbank::Acquiring
  # Sberbank API client class
  class Client
    attr_reader :cache_timestamp, :gateway, :rest, :config

    # Initializes a new Client object
    #
    # @param config [Hash]
    # @return [Sberbank::Acquiring::Client]
    def initialize(config = {})
      @config = {
          auth: { token: nil, username: nil, password: nil, },
          mode: :test,
          service: :rest,
          service_version: :v1,
          ssl: true,
          debug: false
      }.merge(config)

      raise "You must specify config[:auth][:token] OR config[:auth][:username] and config[:auth][:password]" if @config[:auth][:token].nil? && (@config[:auth][:username].nil? || @config[:auth][:password].nil?)

      # check API version
      raise "Allowed Sberbank services are: #{ALLOWED_API_VERSIONS.inspect}" unless ALLOWED_API_VERSIONS.keys.include?(@config[:service])
      raise "Allowed Sberbank service '#{@config[:service]}' versions are: #{ALLOWED_API_VERSIONS[@config[:service]].inspect}" unless ALLOWED_API_VERSIONS[@config[:service]].include?(@config[:service_version])

      @gateway = Sberbank::Acquiring::Gateway.new @config

      init_rest
      #start_cache! if @config[:cache]
      yield self if block_given?
    end

    # Start caching. Executed automatically, if @congif[:cache] is true.
    #
    # @return [String] New timestamp value.
    # def start_cache!
    #   case @config[:api]
    #   when :v4
    #     result = @gateway.request("GetChanges", {}, nil, :v4live)
    #     timestamp = result[:data]['data']['Timestamp']
    #   when :v5
    #     result = @gateway.request("checkDictionaries", {}, "changes", :v5)
    #     timestamp = result[:data]['result']['Timestamp']
    #     update_units_data result[:units_data]
    #   end
    #   @cache_timestamp = Time.parse(timestamp)
    #   @cache_timestamp
    # end

    private

    def init_rest
      @rest = ServiceREST.new(self, REST_V1_METHODS, @config[:service_version])
    end

    # def init_v5
    #   @v5 = {}
    #   API_V5.each do |service, methods|
    #     service_item = DirectServiceV5.new(self, service, methods)
    #     service_key = service_item.service_url
    #     @v5[service_key] = service_item
    #     self.class.send :define_method, service_key do @v5[service_key] end
    #   end
    # end
  end
end
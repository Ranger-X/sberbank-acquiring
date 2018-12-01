require "net/http"
require "openssl"
require "json"

require "sberbank/acquiring/constants"
require "sberbank/acquiring/url_helper"

module Sberbank::Acquiring
  class Gateway
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def request(method, params, service = nil, version = nil)
      ver = version || :v1
      url = UrlHelper.sb_api_url @config[:mode], service, ver, method

      header = generate_header ver
      body = generate_body method, params, ver

      uri = URI.parse url
      request = Net::HTTP::Post.new(uri.path, initheader = header)
      request.body = body.to_json

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = @config[:ssl] ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE

      response = http.request(request)

      if response.kind_of? Net::HTTPSuccess
        UrlHelper.parse_data response, ver
      else
        raise response.inspect
      end
    end

    def generate_header(ver)
      header = {}
      # if [:v5].include? ver
      #   header.merge!({
      #                     'Client-Login' => @config[:login],
      #                     'Accept-Language' => @config[:locale],
      #                     'Authorization' => "Bearer %{token}" % @config
      #                 })
      # end
    end

    def generate_body(method, params, ver)
      body = {
          'TOKEN' => @config[:token],
      }

      body
    end
  end
end
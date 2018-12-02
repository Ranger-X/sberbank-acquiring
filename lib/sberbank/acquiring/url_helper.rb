require "json"
require "sberbank/acquiring/exception"

module Sberbank::Acquiring

  # Static class with helping functions for url formatting.
  class UrlHelper
    # Generate Sberbank API url for a call
    #
    # @param mode [Symbol] API mode, `:test` or `:production`
    # @param version [Symbol] API version, only `:v1` for now
    # @param service [Symbol] API service to use (rest, applepay, samsung, samsungWeb, google)
    # @param method [String] API method name (without any postfix), like 'register' and NOT 'register.do'
    # @return [String] Generated Sberbank API URL
    def self.sb_api_url(mode = :test, service = nil, version = :v1, method = nil)
      #puts "mode: #{mode.inspect} service: #{service.inspect} version: #{version.inspect} method: #{method.inspect}"
      protocol = "https"

      api_prefixes = {
          test: "3dsec",
          production: "api"
      }

      api_prefix = api_prefixes[mode || :test]
      site = "%{api}.sberbank.ru" % {api: api_prefix}

      api_urls = {
          rest: {
              v1: "%{protocol}://%{site}/payment/%{service}/%{method}#{REST_V1_METHOD_POSTFIX}",
          },
      }

      api_urls[service][version] % {
          protocol: protocol,
          site: site,
          service: service.to_s,
          method: method.to_s
      }
    end

    private

    def self.parse_data(response, ver)
      #p "parse_data: response: #{response.inspect} content-type: #{response['Content-Type']} body: #{response.body.inspect}"
      response_body = JSON.parse(response.body)
      validate_response! response_body
      result = { data: response_body }

      result

      # if response["Content-Type"] =~ /application\/json;.*charset=utf-8/
      # else
      #   {data: from_tsv_to_json(response.body)}
      # end
    end

    def self.validate_response!(response_body)
      if response_body.has_key?('errorCode')
        raise Exception.new(response_body['errorMessage'], response_body['errorCode'])
      end
    end

    def self.from_tsv_to_json(response_body)
      report_name = response_body.slice!(/^(.+?)\n/)
      keys = response_body.slice!(/^(.+?)\n/).split("\t")
      rows = response_body.match(/rows:(.+?)\n/)[1].to_i - 1
      values = []
      rows.times do |row|
        hash_values = {}
        response_body.slice!(/^(.+?)\n/).split("\t").each_with_index do |value, index|
          hash_values[keys[index].gsub("\n", "")] = value.gsub("\n", "")
        end
        values.push(hash_values)
      end
      values
    end
  end
end
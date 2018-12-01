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
    # @return [String] Generated Sberbank API URL
    def self.sb_api_url(mode = :test, version = :v1, service = nil)
      protocol = "https"

      api_prefixes = {
          test: "3dsec",
          production: "api"
      }

      api_prefix = api_prefixes[mode || :test]
      site = "%{api}.sberbank.ru" % {api: api_prefix}

      api_urls = {
          rest: {
              v1: '%{protocol}://%{site}/payment/%{service}',
          },
      }

      api_urls[service][version] % {
          protocol: protocol,
          site: site,
          service: service.to_s
      }
    end

    private

    def self.parse_data(response, ver)
      if response["Content-Type"] == "application/json; charset=utf-8"
        response_body = JSON.parse(response.body)
        validate_response! response_body
        result = { data: response_body }

        result
      else
        {data: from_tsv_to_json(response.body)}
      end
    end

    def self.validate_response!(response_body)
      if response_body.has_key? 'error'
        response_error = response_body['error']
        raise Exception.new(response_error['error_detail'], response_error['error_string'], response_error['error_code'])
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
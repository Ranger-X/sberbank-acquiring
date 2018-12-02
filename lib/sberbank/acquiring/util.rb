module Sberbank::Acquiring

  class Util

    # Stringify all hash's keys
    # @param [Hash] hash
    def self.stringify_all_keys(hash)
      stringified_hash = {}
      hash.each do |k, v|
        stringified_hash[k.to_s] = v.is_a?(Hash) ? self.stringify_all_keys(v) : v
      end
      stringified_hash
    end

  end
end
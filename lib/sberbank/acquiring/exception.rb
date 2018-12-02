require "sberbank/acquiring/constants"

module Sberbank::Acquiring
  class Exception < StandardError
    attr_reader :error_code, :error_msg

    def initialize(error_msg, error_code)
      @error_msg = error_msg
      @error_code = error_code
    end

    def to_s
      "Error ##{@error_code}: #{@error_msg}"
    end
  end
end
module Sberbank
  module Acquiring

    ALLOWED_API_VERSIONS = {
        rest: [:v1],
    }.freeze

    REST_V1_METHOD_POSTFIX = '.do'
    REST_V1_METHODS = [
        'register',
    ]
  end
end

module Sberbank::Acquiring
  class ServiceBase
    attr_reader :method_items, :version

    def initialize(client, methods_data)
      @client = client
      @method_items = methods_data
      init_methods
    end

    protected

    def init_methods
      @method_items.each do |method|
        # replace "non-method" characters with '_'
        method.gsub!(/[\.]/, '_')

        self.class.send :define_method, method do |params = {}|
          result = exec_request(method, params || {})
          callback_by_result result
          result[:data]
        end
      end
    end

    def exec_request(method, request_body)
      client.gateway.request method, request_body, @version
    end

    def callback_by_result(result={})
    end
  end
end
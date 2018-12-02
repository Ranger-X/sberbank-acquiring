require 'sberbank/acquiring'
require 'minitest/autorun'
require 'webmock/minitest'

describe Sberbank::Acquiring::Client do
  TOKEN = "TOKEN"
  ORDER_NUM = 4959080
  AMOUNT_RUB = 111

  before do

    @register_body = {
        "orderId" => "92f590a4-2d84-7007-a8d6-5eff04b3362a",
        "formUrl" => "https://3dsec.sberbank.ru/payment/merchants/sbersafe/payment_ru.html?mdOrder=92f590a4-2d84-7007-a8d6-5eff04b3362a"
    }

    stub_request(:post, "https://3dsec.sberbank.ru/payment/rest/register.do").
        with(
            body: "token=TOKEN&orderNumber=4959080&amount=11100&returnUrl=https%3A%2F%2Fwww.example.com%2F",
            headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'Ruby'
            }).
        to_return(status: 200, body: @register_body.to_json, headers: {})

    @restClientV1 = Sberbank::Acquiring::Client.new(auth: { token: TOKEN })
  end

  describe "when does a request" do
    it "works well with REST version 1" do
      assert @restClientV1.rest.register(orderNumber: ORDER_NUM, amount: AMOUNT_RUB * 100, returnUrl: 'https://www.example.com/') == @register_body
    end
  end
end
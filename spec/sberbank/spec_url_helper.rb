require 'sberbank/acquiring'
require 'minitest/autorun'
require 'minitest/spec'

describe Sberbank::Acquiring::UrlHelper do
  describe "when generates URL by params" do
    it "generates right URL for REST v1" do
      assert_equal Sberbank::Acquiring::UrlHelper.sb_api_url(:production, :v1, :rest), "https://api.sberbank.ru/payment/rest"
    end
    it "generates right URL for test REST v1" do
      assert_equal Sberbank::Acquiring::UrlHelper.sb_api_url(:test, :v1, :rest), "https://3dsec.sberbank.ru/payment/rest"
    end
  end

end
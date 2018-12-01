require 'sberbank/acquiring'
require 'minitest/autorun'
require 'minitest/spec'

describe Sberbank::Acquiring::UrlHelper do
  describe "when generates URL by params" do
    it "generates right URL for REST v1 'register'" do
      assert_equal Sberbank::Acquiring::UrlHelper.sb_api_url(:production, :rest, :v1, 'register'), "https://api.sberbank.ru/payment/rest/register.do"
    end
    it "generates right URL for test REST v1 'register'" do
      assert_equal Sberbank::Acquiring::UrlHelper.sb_api_url(:test, :rest, :v1, 'register'), "https://3dsec.sberbank.ru/payment/rest/register.do"
    end

    # it "raises error for wrong REST v1 method name" do
    #   err = assert_raises Exception { Sberbank::Acquiring::UrlHelper.sb_api_url(:test, :rest, :v1, 'unknown') }
    #   assert_match //
    # end
  end

end
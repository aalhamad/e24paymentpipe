require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Parser" do
  context "secure settings" do
    before(:each) do
      @secure_data = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><terminal><id>89001</id>
                    <password>89001</password><webaddress>www.knetpaytest.com.kw</webaddress>
                    <passwordhash>=89001-</passwordhash>
                    <port>443</port><context>CGW302</context></terminal>"
      @secure_data.gsub!(/\s\B/,'')
    end
    it "should return the xml attribute and store it instant variables" do
      parser = E24PaymentPipe::Parser.parse_settings(@secure_data)
      parser[:id]          == "89001"
      parser[:password]    == "89001"
      parser[:web_address] == "www.knetpaytest.com.kw"
      parser[:port]        == "443"
      parser[:context]     == "CGW302"
    end    
  end
end

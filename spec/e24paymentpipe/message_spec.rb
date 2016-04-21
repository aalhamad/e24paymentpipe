require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Message" do
  context "reponse result" do
    it "should get the repond result when payment initialization is made" do
      @settings = { :web_address => "www.knetpaytest.com.kw", :port => "443", :context => "CGW302",
                    :id => "89001", :passwordhash => "hash", :password => "89001", :amt => "100", :currency_code => "414", 
                    :action => "1", :lang_id => "USA", :response_url => "https://www.example.com", 
                    :error_url => "https://www.example.com", :track_id => "", :udf1 => "", :udf2 => "", 
                    :udf3 => "", :udf4 => "", :udf5 => ""}
      url = "https://www.knetpaytest.com.kw:443/CGW302/servlet/PaymentInitHTTPServlet"
      p = E24PaymentPipe::Message.send(@settings, "PaymentInitHTTPServlet")
      p.should be_include(":")
    end
  end
end

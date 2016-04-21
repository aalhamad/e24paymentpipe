require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Url" do
  context "creating the payment query" do
    before(:each) do
      @messages = { :id => "89001", :passwordhash => "", :password => "89001", :amt => "",
                     :currency_code => "", :action => "", :lang_id => "",
                     :response_url => "", :error_url => "", :track_id => "",
                     :udf1 => "", :udf2 => "", :udf3 => "", :udf4 => "", :udf5 => "" }
      @format = "id=89001&password=89001&"
    end

    it "should match password and id in the correct format" do
      E24PaymentPipe::Url.create_payment_query(@messages).should == @format
    end

    it "should match password, id, amt in the correct format" do
      @messages.merge!(:amt => "200")
      @format << "amt=200&"
      E24PaymentPipe::Url.create_payment_query(@messages).should == @format
    end

    it "should match amt only without password or id" do
      @messages.merge!(:id => "", :password => "", :amt => "200")
      format = "amt=200&"
      E24PaymentPipe::Url.create_payment_query(@messages).should == format
    end

    it "should match errorURL with password, id, amt, currenycode" do
      @messages.merge!(:amt => "200", :currency_code => "USA", 
                       :error_url => "www.example.com/error.html")
      @format << "amt=200&" << "currencycode=USA&" << "errorURL=www.example.com/error.html&"
      E24PaymentPipe::Url.create_payment_query(@messages).should == @format
    end
  end
  
  context "creating the message url" do
    before(:each) do
      @settings = { :web_address => "www.knetpaytest.com.kw", :port => "443", :context => "CGW302" }
    end
    
    it "should have the correct url when context no backspace is present" do
      url = "https://www.knetpaytest.com.kw:443/CGW302/servlet/PaymentInitHTTPServlet"
      p = E24PaymentPipe::Url.create_message_url(@settings, "PaymentInitHTTPServlet")
      p.should == url
    end
    
    it "should have the correct url when context has backspace" do
      url = "https://www.knetpaytest.com.kw:443/CGW302/servlet/PaymentInitHTTPServlet"
      p = E24PaymentPipe::Url.create_message_url(@settings.merge(:context => "/CGW302/"), "PaymentInitHTTPServlet")
      p.should == url
    end
    
    it "should change to http if different port is set" do
      url = "http://www.knetpaytest.com.kw:80/CGW302/servlet/PaymentInitHTTPServlet"
      p = E24PaymentPipe::Url.create_message_url(@settings.merge(:port => "80"), "PaymentInitHTTPServlet")
      p.should == url
    end
    
    it "should have the correct url when no context is given" do
      url = "https://www.knetpaytest.com.kw:443/servlet/PaymentInitHTTPServlet"
      p = E24PaymentPipe::Url.create_message_url(@settings.merge(:context => ""), "PaymentInitHTTPServlet")
      p.should == url
    end
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Url" do
  context "creating the payment url" do
    before(:each) do
      @messages = { :id => "89001", :password => "89001", :amt => "",
                     :currencycode => "", :action => "", :langid => "",
                     :responseURL => "", :errorURL => "", :trackid => "",
                     :udf1 => "", :udf2 => "", :udf3 => "", :udf4 => "", :udf5 => "" }
      @format = "id=89001&password=89001&"
    end

    it "should match password and id in the correct format" do
      E24PaymentPipe::Url.create_url_for_payment(@messages).should == @format
    end

    it "should match password, id, amt in the correct format" do
      @messages.merge!(:amt => "200")
      @format << "amt=200&"
      E24PaymentPipe::Url.create_url_for_payment(@messages).should == @format
    end

    it "should match amt only without password or id" do
      @messages.merge!(:id => "", :password => "", :amt => "200")
      format = "amt=200&"
      E24PaymentPipe::Url.create_url_for_payment(@messages).should == format
    end

    it "should match errorURL with password, id, amt, currenycode" do
      @messages.merge!(:amt => "200", :currencycode => "USA", 
                       :errorURL => "www.example.com/error.html")
      @format << "amt=200&" << "currencycode=USA&" << "errorURL=www.example.com/error.html&"
      E24PaymentPipe::Url.create_url_for_payment(@messages).should == @format
    end
  end
end
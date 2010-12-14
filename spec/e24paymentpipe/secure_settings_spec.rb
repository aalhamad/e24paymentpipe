require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SecureSettings" do
  
  context "file and directory" do
    it "should have a default settings" do
      secure_settings = E24PaymentPipe::SecureSettings.new(:alias => "alias")
      secure_settings.input_file_name.should   == "resource.cgn"
      secure_settings.output_file_name.should  == "resource.cgz"
    end
    
    it "should keep the resource path a current when file change" do
      secure_settings = E24PaymentPipe::SecureSettings.new(:input_file_name => "in.file", 
                                                           :output_file_name => "out.file",
                                                           :alias => "alias")
      secure_settings.input_file_name.should   == "in.file"
      secure_settings.output_file_name.should  == "out.file"
    end
    
    it "should have the changed resource path in both input and output file" do
      secure_settings = E24PaymentPipe::SecureSettings.new(:input_file_name => "in.file", 
                                                           :output_file_name => "out.file",
                                                           :resource_path => "/aalhamad/home/",
                                                           :alias => "alias")
      secure_settings.input_file_name.should   == "/aalhamad/home/in.file"
      secure_settings.output_file_name.should  == "/aalhamad/home/out.file"
    end
    
    it "should delete the output file: resource.cgz" do
      path = File.dirname(__FILE__) + "/../data/"
      p = E24PaymentPipe::SecureSettings.new(:alias => "twseel.xml", :resource_path => path)
      p.output_file_name.should == path + "resource.cgz"
      File.exists?(p.output_file_name).should be_false
    end
  end

  context "zip file data" do
    before(:each) do
      @path = File.dirname(__FILE__) + "/../data/"
    end
    
    it "should read a given data of security settings" do
      data = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><terminal><id>89001</id>
             <password>89001</password><webaddress>www.knetpaytest.com.kw</webaddress>
             <port>443</port><context>CGW302</context></terminal>"
      data.gsub!(/\s\B/,'')
      p = E24PaymentPipe::SecureSettings.new(:alias => "twseel.xml", :resource_path => @path)
      p.secure_data.should == data
    end
  end
end

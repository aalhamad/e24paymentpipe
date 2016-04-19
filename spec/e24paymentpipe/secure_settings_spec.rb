require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SecureSettings" do
  before(:each) do
    @settings = { :alias => "alias",
                  :resource_path => "",
                  :input_file_name => "resource.cgn", 
                  :output_file_name => "resource.cgz" }
  end
  
  context "file and directory" do
    it "should have a default settings" do
      secure_settings = E24PaymentPipe::SecureSettings.new(@settings)
      secure_settings.input_file_name.should   == "resource.cgn"
      secure_settings.output_file_name.should  == "resource.cgz"
    end
    
    it "should keep the resource path a current when file change" do
      secure_settings = E24PaymentPipe::SecureSettings.new(@settings.merge(:input_file_name => "in.file",
                                                                           :output_file_name => "out.file"))
      secure_settings.input_file_name.should   == "in.file"
      secure_settings.output_file_name.should  == "out.file"
    end
    
    it "should have the changed resource path in both input and output file" do
      secure_settings = E24PaymentPipe::SecureSettings.new(@settings.merge(:resource_path => "/aalhamad/home/"))
      secure_settings.input_file_name.should   == "/aalhamad/home/resource.cgn"
      secure_settings.output_file_name.should  == "/aalhamad/home/resource.cgz"
    end
    
    it "should delete the output file: resource.cgz" do
      path = File.dirname(__FILE__) + "/../data/"
      p = E24PaymentPipe::SecureSettings.new(@settings.merge(:alias => "twseel.xml", :resource_path => path))
      p.output_file_name.should == path + "resource.cgz"
      File.exists?(p.output_file_name).should be_falsey
    end
  end
end

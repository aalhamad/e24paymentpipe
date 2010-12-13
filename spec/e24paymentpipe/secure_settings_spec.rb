require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "SecureSettings" do
  before(:each) do 
    @secure_settings = E24PaymentPipe::SecureSettings.new(:alias => "alias")
  end
  
  context "file and directory" do
    it "should have a default settings" do
      @secure_settings.resource_path.should     == ""
      @secure_settings.input_file_name.should   == "resource.cgn"
      @secure_settings.output_file_name.should  == "resource.cgz"
    end
    
    it "should keep the resource path a current when file change" do
      @secure_settings.input_file_name  = "in.file"
      @secure_settings.output_file_name = "out.file"
      
      @secure_settings.resource_path.should     == ""
      @secure_settings.input_file_name.should   == "in.file"
      @secure_settings.output_file_name.should  == "out.file"
    end
    
    it "should have the changed resource path in both input and output file" do
      @secure_settings.resource_path    = "/aalhamad/home/"
      @secure_settings.input_file_name  = "in.file"
      @secure_settings.output_file_name = "out.file"
      
      @secure_settings.resource_path.should     == "/aalhamad/home/"
      @secure_settings.input_file_name.should   == "/aalhamad/home/in.file"
      @secure_settings.output_file_name.should  == "/aalhamad/home/out.file"
    end
  end
end

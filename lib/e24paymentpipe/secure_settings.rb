require "zip/zip"

module E24PaymentPipe
  class SecureSettings
    attr_accessor :resource_path
    attr_writer   :input_file_name
    attr_writer   :output_file_name
    
    DEFAULT_PATH = ""
    DEFAULT_INPUT_NAME = "resource.cgn"
    DEFAULT_OUTPUT_NAME = "resource.cgz"
    
    def initialize
      @resource_path    = DEFAULT_PATH
      @input_file_name  = DEFAULT_INPUT_NAME
      @output_file_name = DEFAULT_OUTPUT_NAME
    end
    
    def input_file_name
      @resource_path + @input_file_name
    end
    
    def output_file_name
      @resource_path + @output_file_name
    end
    
    def read_zip
      create_readable_zip
      zip_entry = nil
      
      zip_file = Zip::ZipFile.open(output_file_name)
      
      begin
        zip_entry = zip_file.get_entry("twseel.xml")
      ensure
        zip_file.close
      end
      
      if !zip_file.nil?
        zip_stream = zip_file.get_input_stream(zip_entry)
      end
      
      zip_stream.each do |z|
        z.unpack("c*")
      end
      
    end
    
    private
    
    def create_readable_zip
      File.open(output_file_name, "wb") do |file|
        file.write(simple_xor.pack("c*"))
      end
    end
    
    def simple_xor            
      str = <<-EOS.gsub(/\s+/, " ").strip
        Those who profess to favour freedom and yet depreciate agitation
        are men who want rain without thunder and lightning
      EOS
      
      result = []
      file_bytes = []
      str_bytes = []
      File.open(input_file_name, 'rb') do |file|
        file_bytes = file.read.unpack("c*")
      end    
      
      str.each_byte { |b| str_bytes << b }
      
      i = 0
      while i != file_bytes.length
        str_bytes.each do |str_byte|
          result[i] = (file_bytes[i] ^ str_byte)
          i += 1
          break if i == file_bytes.length
        end
      end
      result
    end
        
  end
end

p = E24PaymentPipe::SecureSettings.new
p.resource_path = File.join(File.dirname(__FILE__), "../../data/")
p.read_zip

require "zip/zip"

module E24PaymentPipe
  class SecureSettings    
    DEFAULT_PATH = ""
    DEFAULT_INPUT_NAME = "resource.cgn"
    DEFAULT_OUTPUT_NAME = "resource.cgz"
    
    def initialize(options = {})
      @resource_path    = options[:resource_path]    || DEFAULT_PATH
      @input_file_name = options[:inputt_file_name] || DEFAULT_INPUT_NAME 
      @output_file_name = options[:output_file_name] || DEFAULT_OUTPUT_NAME
      @alias            = options[:alias]
      
      raise E24PaymentPipe::SecureSettingsError, "You need to set an alias" unless @alias
      if block_given?
        yield secure_data
      end
    end
    
    def input_file_name
      @resource_path + @input_file_name
    end
    
    def output_file_name
      @resource_path + @output_file_name
    end
    
    def secure_data
      read_zip
    end
    
    private
    
    def read_zip
      create_readable_zip
      zip_entry = nil
      xml_content = []
      
      zip_file = Zip::ZipFile.open(output_file_name)
      
      begin
        zip_entry = zip_file.get_entry(@alias)
      ensure
        zip_file.close
      end
      
      if !zip_file.nil?
        zip_stream = zip_file.get_input_stream(zip_entry)
      end
      
      zip_stream.each { |z| xml_content << z.unpack("c*") }
      result = simple_xor(xml_content.flatten).pack("c*")
      raise E24PaymentPipe::SecureSettingsError, "Empty zip file" if result.empty?
      result
    end
    
    def create_readable_zip
      file_bytes = []
      File.open(input_file_name, 'rb') do |in_file|
        file_bytes = in_file.read.unpack("c*")
      end
      
      File.open(output_file_name, "wb") do |out_file|
        out_file.write(simple_xor(file_bytes).pack("c*"))
      end
      
    end
    
    def simple_xor(bytes)            
      str = <<-EOS.gsub(/\s+/, " ").strip
        Those who profess to favour freedom and yet depreciate agitation
        are men who want rain without thunder and lightning
      EOS
      
      result = []
      str_bytes = []
           
      str.each_byte { |b| str_bytes << b }
      
      i = 0
      while i != bytes.length
        str_bytes.each do |str_byte|
          result[i] = (bytes[i] ^ str_byte)
          i += 1
          break if i == bytes.length
        end
      end
      result
    end   
  end
end

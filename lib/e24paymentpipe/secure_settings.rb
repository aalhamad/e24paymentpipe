require "zip"

module E24PaymentPipe
  
  # The secure data found in resource file. If passed a block, 
  # then you get the secure data as string.
  #
  # Example:
  #   E24PaymentPipe::SecureSettings.new(:alias => "a.xml") do |secure_data|
  #     secure_data # do something with it
  #   end
  # You need to set an alias, if not, an errors is going to be raised.
  
  class SecureSettings   
        
    # Open resource file and create a readable one. Error thrown if no resource
    # file is found or alias options is not set.
    #
    # Options:
    #
    # - <tt>:resource_path</tt>    - Set the directory of the resource path.
    # - <tt>:input_file_name</tt>  - Set the input file name.
    # - <tt>:output_file_name</tt> - Set the output file name.
    
    def initialize(options = {})
      @resource_path    = options[:resource_path]
      @input_file_name  = options[:input_file_name]
      @output_file_name = options[:output_file_name]
      @alias            = options[:alias]
      
      raise E24PaymentPipe::SecureSettingsError, "You need to set an alias" unless @alias
      if block_given?
        yield secure_data
      end
    end
    
    # Return the resource file input file with directory.
    def input_file_name
      @resource_path + @input_file_name
    end
    
    # Return the output readable zip file from the secure setting file
    # with directory.
    def output_file_name
      @resource_path + @output_file_name
    end
    
    # Return the secure settings data.
    def secure_data
      E24PaymentPipe::Parser.parse_settings(read_zip)
    end
    
    private
    
    def read_zip
      create_readable_zip
      zip_entry = nil
      xml_content = []
      
      zip_file = Zip::File.open(output_file_name)
      
      begin
        zip_entry = zip_file.get_entry("#{@alias}.xml")
      ensure
        zip_file.close
      end
      
      if !zip_file.nil?
        zip_stream = zip_file.get_input_stream(zip_entry)
      end
      
      zip_stream.each { |z| xml_content << z.unpack("c*") }
      result = simple_xor(xml_content.flatten).pack("c*")
      raise E24PaymentPipe::SecureSettingsError, "Empty zip file" if result.empty?
      # delete the out put file
      File.delete(output_file_name)
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

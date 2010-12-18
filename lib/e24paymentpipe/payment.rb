module E24PaymentPipe
  class Payment          
    attr_reader :settings
    attr_reader :response
    attr_accessor :id
    attr_accessor :page
    
    SETTINGS_DEFAULT_PATH_FILE = File.dirname(__FILE__) + "/../../resource/config.yaml"
    
    def initialize(settings = {}, config_file = SETTINGS_DEFAULT_PATH_FILE)
      @settings = { :action           => "", 
                    :amt              => "", 
                    :currency_code    => "",
                    :lang_id          => "",
                    :response_url     => "",
                    :error_url        => "",
                    :track_id         => "",
                    :resource_path    => "",
                    :input_file_name  => "",
                    :output_file_name => "resource.zip",
                    :alias            => "",
                    :udf1             => "",
                    :udf2             => "",
                    :udf3             => "",
                    :udf4             => "",
                    :udf5             => ""                                                                                
                  }
      
      
      load_yaml(@settings, config_file)
      @settings.merge!(values_to_string(settings))
                     
      settings_error(:action, :currency_code, :lang_id, :response_url, :error_url, 
                     :track_id, :resource_path, :input_file_name, :alias, :amt => "amount")
                     
      respond_from_securce_settings(@settings)
      
      raise E24PaymentPipe::PaymentError, @response if @response.include?("!ERROR!")
      
      match(response, @settings, settings)
      
    end
    
    def redirect_url
      @page << "?PaymentID=" << @id
    end
    
    private
    
    def load_yaml(settings, path_to_settings)
      path = File.open(path_to_settings)
       begin
         yaml_settings = YAML.load(path)
         settings.merge!(values_to_string(yaml_settings))
       rescue Exception => e
         raise E24PaymentPipe::PaymentError, e
       end
    end
    
    def values_to_string(hash)
      str_values = {}
      hash.each { |key, value| str_values.merge!({ key.to_sym => value.to_s }) }
      str_values
    end
    
    def respond_from_securce_settings(settings)
       settings.merge!(:alias => settings[:alias])
       secure_settings = E24PaymentPipe::SecureSettings.new(settings)
       parsed_secure_settings = secure_settings.secure_data      
       settings.merge!(parsed_secure_settings)      
       @response = E24PaymentPipe::Message.send(settings, "PaymentInitHTTPServlet")
     end
     
    def match(response, settings, default_settings)
      match = /:/.match(response)
       if !match.nil?
         @id, @page = match
         @id = match.pre_match
         @page = match.post_match
         settings.merge!(settings[:payment_id] || :payment_id => @id)
       end
    end
    
    def settings_error(*args)
      args.each do |arg|
        msg = arg.is_a?(Symbol) ? replace_underscore(arg.to_s) : arg.values.to_s
        arg_sym = arg.is_a?(Symbol) ? arg : arg.keys.to_s.to_sym
        
        raise E24PaymentPipe::PaymentError, "Please set #{msg}" if @settings[arg_sym].nil? || @settings[arg_sym].empty? 
      end
    end
    
    def replace_underscore(str)
      str.gsub("_", " ")
    end
           
  end
end

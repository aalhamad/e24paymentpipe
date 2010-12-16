module E24PaymentPipe
  class Payment          
    attr_reader :settings
    attr_reader :response
    attr_accessor :id
    attr_accessor :page
    
    def initialize(settings)
      @settings = { :action           => "1", 
                    :amt              => "", 
                    :currency_code    => "414",
                    :lang_id          => "USA",
                    :response_url     => "",
                    :error_url        => "",
                    :track_id         => "#{rand(1000000000)}",
                    :resource_path    => "",
                    :input_file_name  => "resource.cgn",
                    :output_file_name => "resource.cgz",
                    :alias            => "",
                    :udf1             => "",
                    :udf2             => "",
                    :udf3             => "",
                    :udf4             => "",
                    :udf5             => ""                                                                                
                  }.merge(settings)
                  
      raise E24PaymentPipe::PaymentError, "Please set payment amount" if @settings[:amt].empty?
      raise E24PaymentPipe::PaymentError, "Please set response url"   if @settings[:response_url].empty?
      raise E24PaymentPipe::PaymentError, "Please set error url"      if @settings[:error_url].empty?
      raise E24PaymentPipe::PaymentError, "Please set alias"          if @settings[:alias].empty?
            
      @settings.merge!(:alias => @settings[:alias])      
      secure_settings = E24PaymentPipe::SecureSettings.new(@settings)
      parsed_secure_settings = secure_settings.secure_data      
      @settings.merge!(parsed_secure_settings)      
      @response = E24PaymentPipe::Message.send(@settings, "PaymentInitHTTPServlet")
      
      match = /:/.match(@response)
      
      if !match.nil?
        @id, @page = match
        @id = match.pre_match
        @page = match.post_match
        @settings.merge!(settings[:payment_id] || :payment_id => @id)
      end  
    end
    
    def redirect_url
      @page << "?PaymentID=" << @id
    end
        
  end
end

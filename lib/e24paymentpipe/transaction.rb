module E24Payment
  class Transaction          
    def initialize(settings = {})
      @settings = { :action         => "1", 
                    :amt            => "", 
                    :currency       => "414",
                    :langauge       => "USA",
                    :reponse_url    => "",
                    :error_url      => "",
                    :track_id       => "#{rand(1000000000)}",
                    :resource_path  => "",
                    :alias          => "",
                    :udf1           => "",
                    :udf2           => "",
                    :udf3           => "",
                    :udf4           => "",
                    :udf5           => ""                                                                                
                  }.merge(settings)
                  
      raise E24PaymentPipe::TransactionError, "Please set payment amount" if @settings[:amt].empty?
      raise E24PaymentPipe::TransactionError, "Please set respone url"    if @settings[:reponse_url].empty?
      raise E24PaymentPipe::TransactionError, "Please set error url"      if @settings[:error_url].empty?
      raise E24PaymentPipe::TransactionError, "Please set alias"          if @settings[:alias].empty?
    end
    
    def settings
      @settings
    end
  end
end

settings = { :amt => "100", 
             :reponse_url => "https://www.aalhamad.com", 
             :error_url => "https://www.aalhamad.com",
             :alias => "tawseel" }
             
p E24Payment::Transaction.new(settings)

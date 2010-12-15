module E24PaymentPipe
  class Transaction    
    attr_reader :settings
    attr_reader :response
      
    def initialize(settings)
      @settings = { :trans_id => ""}.merge(settings)
      @settings.merge!(:payment_id => settings[:payment_id])
      @response = E24PaymentPipe::Message.send(@settings,"PaymentTranHTTPServlet", :transaction)
    end    
  end
end

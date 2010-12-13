module E24PaymentPipe
  class Payment
    attr_accessor :params
    def initialize(params = {})
      @params = params
    end
    
    def perform_init_transaction
      E24PaymentPipe::Transation.new(@params)
    end
    
  end
end


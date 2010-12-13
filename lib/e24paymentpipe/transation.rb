module E24PaymentPipe
  class Transation
    attr_accessor :params
    FAIL = -1
    def initialize(params)
      @params = params
    end
    
  end
end
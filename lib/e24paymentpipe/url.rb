module E24PaymentPipe
  class Url
    # A helper class for creating urls
    
    attr_accessor :payment_messages
    attr_accessor :transation_messages
    
    def self.create_url_for_payment(messages)
      result = ""
      result << "id=#{messages[:id]}&" unless messages[:id].empty? 
      result << "password=#{messages[:password]}&" unless messages[:password].empty?
      result << "amt=#{messages[:amt]}&" unless messages[:amt].empty?
      result << "currencycode=#{messages[:currencycode]}&" unless messages[:currencycode].empty?
      result << "action=#{messages[:action]}&" unless messages[:action].empty?
      result << "langid=#{messages[:langid]}&" unless messages[:langid].empty?
      result << "responseURL=#{messages[:responseURL]}&" unless messages[:responseURL].empty?
      result << "errorURL=#{messages[:errorURL]}&" unless messages[:errorURL].empty? 
      result << "trackid=#{messages[:trackid]}&" unless messages[:trackid].empty? 
      result << "udf1=#{messages[:udf1]}&" unless messages[:udf1].empty? 
      result << "udf2=#{messages[:udf2]}&" unless messages[:udf2].empty?
      result << "udf3=#{messages[:udf3]}&" unless messages[:udf3].empty?
      result << "udf4=#{messages[:udf4]}&" unless messages[:udf4].empty?
      result << "udf5=#{messages[:udf5]}&" unless messages[:udf5].empty?
      result
    end
  end
end
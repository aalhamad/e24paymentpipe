require 'errors'

module E24PaymentPipe
  class Url
    # A helper class for creating urls
    
    attr_accessor :payment_messages
    attr_accessor :transation_messages
    
    def self.create_payment_query(messages)
      result = ""
      result << "id=#{messages[:id]}&" unless messages[:id].empty? 
      result << "password=#{messages[:password]}&" unless messages[:password].empty?
      result << "passwordhash=#{messages[:passwordhash]}&" unless messages[:passwordhash].empty?
      result << "amt=#{messages[:amt]}&" unless messages[:amt].empty?
      result << "currencycode=#{messages[:currency_code]}&" unless messages[:currency_code].empty?
      result << "action=#{messages[:action]}&" unless messages[:action].empty?
      result << "langid=#{messages[:lang_id]}&" unless messages[:lang_id].empty?
      result << "responseURL=#{messages[:response_url]}&" unless messages[:response_url].empty?
      result << "errorURL=#{messages[:error_url]}&" unless messages[:error_url].empty? 
      result << "trackid=#{messages[:track_id]}&" unless messages[:track_id].empty? 
      result << "udf1=#{messages[:udf1]}&" unless messages[:udf1].empty? 
      result << "udf2=#{messages[:udf2]}&" unless messages[:udf2].empty?
      result << "udf3=#{messages[:udf3]}&" unless messages[:udf3].empty?
      result << "udf4=#{messages[:udf4]}&" unless messages[:udf4].empty?
      result << "udf5=#{messages[:udf5]}&" unless messages[:udf5].empty?
      result
    end
    
    def self.create_transaction_query(messages)
      result = ""
      result << "id=#{messages[:id]}&" unless messages[:id].empty? 
      result << "password=#{messages[:password]}&" unless messages[:password].empty?
      result << "passwordhash=#{messages[:passwordhash]}&" unless messages[:passwordhash].empty?
      result << "amt=#{messages[:amt]}&" unless messages[:amt].empty?
      result << "currencycode=#{messages[:currency_code]}&" unless messages[:currency_code].empty?
      result << "action=#{messages[:action]}&" unless messages[:action].empty?
      result << "paymentid=#{messages[:payment_id]}&" unless messages[:payment_id].empty?
      result << "transid=#{messages[:trans_id]}&" unless messages[:trans_id].empty? 
      result << "trackid=#{messages[:track_id]}&" unless messages[:track_id].empty? 
      result << "udf1=#{messages[:udf1]}&" unless messages[:udf1].empty? 
      result << "udf2=#{messages[:udf2]}&" unless messages[:udf2].empty?
      result << "udf3=#{messages[:udf3]}&" unless messages[:udf3].empty?
      result << "udf4=#{messages[:udf4]}&" unless messages[:udf4].empty?
      result << "udf5=#{messages[:udf5]}&" unless messages[:udf5].empty?
      result
    end
    
    def self.create_message_url(settings, send_to)
      from = ""
      raise E24PaymentPipe::UrlError, "No Url specified" if settings[:web_address].empty?

      # check if need ssl support
      if settings[:port] == "443"
        from << "https://"
      else
        from << "http://"
      end
      # append web address
      from << settings[:web_address]

      # check if port avaible 
      raise E24PaymentPipe::UrlError, "No port defined" if settings[:port].empty?
      from << ":" << settings[:port]

      # append context
      if settings[:context].empty?
        from << "/"
      else 
        from << "/" unless settings[:context].start_with?("/")
        from << settings[:context]
        from << "/" unless settings[:context].end_with?("/")
      end

      # finish up the from web url
      from << "servlet/"
      from << send_to
    end
  end
end

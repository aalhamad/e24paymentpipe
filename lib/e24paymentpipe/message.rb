require 'httparty'

module E24PaymentPipe
  
  # Messages connections between client and server
  
  class Message
    include HTTParty
    
    # Send settings (hash) to server via post.
    def self.send(settings, to, option = :payment) 
      message = E24PaymentPipe::Url.create_message_url(settings, to)
      
      query = nil
      if option == :payment
        query = E24PaymentPipe::Url.create_payment_query(settings)
      elsif option == :transaction
        query = E24PaymentPipe::Url.create_transaction_query(settings)
      end
      
      raise MessageError, "No data to post" if query.empty? || query.nil?
      response = HTTParty.post(message, :body => query).body
    end
  end
end
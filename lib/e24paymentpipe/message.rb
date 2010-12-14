require 'httparty'

module E24PaymentPipe
  
  # Messages connections between client and server
  
  class Message
    include HTTParty
    
    # Send settings (hash) to server via post.
    def self.send(settings, to) 
      message = E24PaymentPipe::Url.create_message_url(settings, to)
      query = E24PaymentPipe::Url.create_payment_query(settings)
      raise MessageError, "No data to post" if query.empty?
      response = HTTParty.post(message, :body => query).body
    end
  end
end
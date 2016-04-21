module E24PaymentPipe
  class Payment
    attr_reader :settings
    attr_reader :response
    attr_accessor :id
    attr_accessor :page

    MANDATORY = %i(
      action
      currency_code
      lang_id
      response_url
      error_url
      track_id
      amt
    )

    def initialize(amount, track_id, currency_code: "414")
      @settings = E24PaymentPipe.settings.merge(
        amt: amount.to_s,
        track_id: track_id.to_s,
        currency_code: currency_code,
        action: "1"
      )

      settings_error(MANDATORY)
      @response = respond_from_securce_settings(@settings)

      raise(E24PaymentPipe::PaymentError, @response) if @response.include?("!ERROR!")

      match(response, @settings)
    end

    def redirect_url
      @page << "?PaymentID=" << @id
    end

    private

    def respond_from_securce_settings(settings)
      E24PaymentPipe::Message.send(settings, "PaymentInitHTTPServlet")
    end

    def match(response, settings)
      match = /:/.match(response)

      if !match.nil?
        @id, @page = match
        @id = match.pre_match
        @page = match.post_match
        settings.merge!(settings[:payment_id] || :payment_id => @id)
      end
    end

    def settings_error(args)
      args.each do |arg|
        raise E24PaymentPipe::PaymentError, "Please set #{arg_sym}" if settings[arg].nil? || settings[arg].empty?
      end
    end
  end
end

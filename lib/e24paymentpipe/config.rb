module E24PaymentPipe
  @@settings = {
    web_address: "www.knetpaytest.com.kw",
    port: "443",
    context: "",
    id: "",
    password: "",
    passwordhash: "",
    currency_code: "414",
    action: "1",
    lang_id: "USA",
    response_url: "",
    error_url: "",
    track_id: "",
    udf1: "",
    udf2: "",
    udf3: "",
    udf4: "",
    udf5: ""
  }

  def self.settings
    @@settings
  end

  def self.settings=(settings)
    @@settings.merge!(settings)
  end

  def self.configure
    yield(self)
  end
end

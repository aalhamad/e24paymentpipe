Given /^payment settings (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*)$/ do |action, amt, currency, language, response_url, error_url, track_id, a_alias, udf1, udf2, udf3, udf4, udf5|
  path = File.dirname(__FILE__) + "/../../spec/data/"
  
  @settings = { :action => action, :amt => amt, :currency => currency,
                :language => language, :response_url => response_url, 
                :error_url => error_url, :track_id => track_id,
                :alias => a_alias, :udf1 => udf1, :udf2 => udf2,
                :udf3 => udf3, :udf4 => udf4, :udf5 => udf5,
                :resource_path => path }
  @payment = E24PaymentPipe::Payment.new(@settings)              
end

When /^perform a initialization with gateway$/ do
end

Then /^gateway replies with transaction unique ID and gateway payment url$/ do
  @payment.id != be_empty
  @payment.page != be_empty
end


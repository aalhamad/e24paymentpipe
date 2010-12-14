Given /^payment settings (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*) (.*)$/ do |action, amt, currency, language, reponse_url, error_url, track_id, a_alias, udf1, udf2, udf3, udf4, udf5|
  @settings = { :action => action, :amt => amt, :currency => currency,
                :language => language, :reponse_url => reponse_url, 
                :error_url => error_url, :track_id => track_id,
                :alias => a_alias, :udf1 => udf1, :udf2 => udf2,
                :udf3 => udf3, :udf4 => udf4, :udf5 => udf5 }
  @payment = E24PaympentPipe::Transaction.new(@settings)              
end

When /^perform a initialization with gateway$/ do
end

Then /^gateway replies with transaction unique ID and gateway payment url$/ do
  @payment.id.should_not be_empty
  @payment.payment_page.should_not be_empty
end


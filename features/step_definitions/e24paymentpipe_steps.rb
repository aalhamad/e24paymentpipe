Given /^payment default parameters$/ do
  @payment = E24PaymentPipe::Payment.new
end

When /^perform a initialization with Knet$/ do
  @payment.perform_init_transaction
end

Then /^Knet replies with transaction unique ID and Knet payment url$/ do
  payment_id  = @payment.params[:id]
  payment_url = @payment.params[:url]
  
  payment_id.should be_true
  payment_url.should be_true 
end

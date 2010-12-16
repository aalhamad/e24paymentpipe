Feature: Merchant payment initialization
  In order to perform a payment initialization
  As a Merchant
  I want to perform a payment initialization with payment gateway

	Scenario Outline: payment init
	  Given payment settings <action> <amt> <currency> <language> <reponse_url> <error_url> <track_id> <alias> <udf1> <udf2> <udf3> <udf4> <udf5> 
	  When perform a initialization with gateway
	  Then gateway replies with transaction unique ID and gateway payment url

	Scenarios: 
	  | action | amt | currency | language | response_url | error_url | track_id | alias  | udf1 | udf2 | udf3 | udf4 | udf5 |
 | 1 | 100 | 414 | USA | https://www.example.com | https://www.example.com | 1000 | twseel.xml | UDF1 | UDF2 | UDF3 | UDF4 | UDF5 |




	 

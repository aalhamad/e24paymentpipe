Feature: Payment initialization
  In order to perform a payment initialization
  As a buyer
  I want to perform payment initialization with Knet

	Scenario: payment init
	  Given payment default parameters
	  When perform a initialization with Knet
	  Then Knet replies with transaction unique ID and Knet payment url

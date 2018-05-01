component name="accountService" accessors="true" extends="baseService" {
	
	public any function sendConfirmation (required string cellPhone) {

		var twilioUsername = "ACd6a883356e91b974356c9bd72b3aae7c";
		var twilioPassword = "5685a4e29927ac6624848515bee9a736";
		var twilioPhoneNumber = "19017308883";
		var messageBody = "Your appointment has been confirmed.";

		cfhttp(method="POST" 
			, url="https://api.twilio.com/2010-04-01/Accounts/#twilioUsername#/Messages.json"
			, username="#twilioUsername#"
			, password="#twilioPassword#"
			, result="postCFHTTP") {

			cfhttpparam(name="From", type="formfield", value="#twilioPhoneNumber#");
			cfhttpparam(name="To", type="formfield", value="#cellPhone#");
			cfhttpparam(name="Body", type="formfield", value="#messageBody#");
		}
	}
}
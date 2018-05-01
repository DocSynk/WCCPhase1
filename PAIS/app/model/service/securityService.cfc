component extends="baseService" accessors="true" {

	property array nonSecuredSections;
	property array nonSecuredItems;
	property string loginFormItem;
	property string loginSubmitItem;
	property string logoutSubmitItem;
	property string resetPasswordFormItem;

	function init (
			  required array security_nonSecuredSections
			, required array security_nonSecuredItems
			, required string security_loginFormItem
			, required string security_loginSubmitItem
			, required string security_logoutSubmitItem
			, required string security_resetPasswordFormItem
			) {

		setNonSecuredSections(cleanEvents(security_nonSecuredSections));
		setNonSecuredItems(cleanEvents(security_nonSecuredItems));
		setLoginFormItem(cleanEvent(security_loginFormItem));
		setLoginSubmitItem(cleanEvent(security_loginSubmitItem));
		setLogoutSubmitItem(cleanEvent(security_logoutSubmitItem));
		setResetPasswordFormItem(cleanEvent(security_resetPasswordFormItem));

		addNonSecuredItem(getLoginFormItem());
		addNonSecuredItem(getLoginSubmitItem());
		addNonSecuredItem(getLogoutSubmitItem());

	}

	private void function addNonSecuredItem (required string value) {
		if (!arrayFindNoCase(nonSecuredItems, value)) {
			arrayAppend(nonSecuredItems, value);
		}
	}

	private string function cleanEvent (required string event) {
		return replace(event, "/", ".");
	}

	private function cleanEvents (required any set) {
		return arrayMap(set, function (item) {
			return cleanEvent(item);
		});
	}

	boolean function isSecuredEvent (required string currentSection, required string currentItem) {
		var currentAction = currentSection & "." & currentItem;

		if (arrayFindNoCase(nonSecuredSections, currentSection)
			|| arrayFindNoCase(nonSecuredItems, currentAction)) {
			return false;
		}

		return true;
	}

	boolean function isAuthorized (required User user, required string currentSection, required string currentItem) {
		return !isSecuredEvent(currentSection, currentItem) && !user.isLoggedIn();
	}




}
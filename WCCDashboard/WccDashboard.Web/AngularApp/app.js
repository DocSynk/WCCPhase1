var app = angular.module('wccDashboardApp',
                            [
                             'ui.router',
                             'ngResource',
                             'ui.bootstrap',
                             'darthwade.loading',
                             'wccDashboard.clinicDashboard',
                             'wccDashboard.patientDashboard'
                            ]
                        )
.factory('authHttpResponseInterceptor', ['$q', '$location', '$window', function ($q, $location, $window) {
    return {
        response: function (response) {
            if (typeof response.data === 'string' && response.data.indexOf("Account Login") > -1) {
                console.log("LOGIN!!");
                $window.location.href = "/account/login";
                alert('Session timed out. Please re-login.');
                //return response;
            }else{
                return response;
            }
        },
        responseError: function (rejection) {
            if (rejection.status === 401) {
                console.log("Response Error 401", rejection);
                $location.path('/account/login').search('returnTo', $location.path());
            }
            return $q.reject(rejection);
        }
    }
}])
.config(['$httpProvider', function ($httpProvider) {
    //Http Intercpetor to check auth failures for xhr requests
    $httpProvider.interceptors.push('authHttpResponseInterceptor');
}]);
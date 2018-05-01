app.config(['$stateProvider', '$urlRouterProvider', function ($stateProvider, $urlRouterProvider) {
    $stateProvider.state('default', {
        url: '/',
        templateUrl: "/AngularApp/clinicDashboard/clinic-dashboard.tpl.html",
        controller: "clinicDashboardController"
    });

    $stateProvider.state('clinicDashboard', {
        url: '/clinic',
        templateUrl: "/AngularApp/clinicDashboard/clinic-dashboard.tpl.html",
        controller: "clinicDashboardController"
    });

    $stateProvider.state('patientDashboard', {
        url: '/patient',
        templateUrl: "/AngularApp/patientDashboard/patient-dashboard.tpl.html",
        controller: "patientDashboardController",
        params: {
            patient: null
        }
    });

    $urlRouterProvider.otherwise('/');
}]);
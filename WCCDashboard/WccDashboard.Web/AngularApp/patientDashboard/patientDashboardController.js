patientDashboardModule.controller('patientDashboardController',
    ['$scope', '$state', '$stateParams',
    function ($scope, $state, $stateParams) {
        var me = this;

        $scope.patient = null;
           
        me.initialize = function () {
            me.getPatientDetails();
        }

        me.getPatientDetails = function () {
            $scope.patient = $stateParams.patient;

            if (!$scope.patient) {
                $state.go('clinicDashboard');
            }
        }

        me.initialize();
}]);
clinicDashboardModule.controller('clinicDashboardController',
    ['$scope', '$state', 'ClinicService',
    function (scope, state, clinicService) {
        var me = this;

        scope.patientCount = 0;
        scope.patients = null;
        //scope.selectedPatient = undefined;

        me.initialize = function () {
            me.getPatients();
        }

        me.getPatients = function (clinicId, viewValue) {
            clinicService.getPatients().then(function (response) {
                scope.patients = response;
            }).catch(function (err) {
                console.log('Error while fetching patients count:' + err);
                alert('Error while fetching patients count');
            });
        }

        scope.onPatientSelect = function (patient) {
            state.go('patientDashboard', { patient: patient });
        }

        me.initialize();
}]);
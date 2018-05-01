directivesModule.directive("apptLocationHistory", ['AppointmentService',
    function (appointmentService) {
        return {
            restrict: 'E',
            templateUrl: '/AngularApp/common/directives/appointments/appt-location-history.tpl.html',
            scope : {
                patientId: '='
            },
            link : function(scope, element, attrs, ngModel) {
                
            },
            controller: function ($scope, $element, $timeout, $loading) {
                var me = this;

                $scope.apptLocationHistoryData = null;
               
                me.initialize = function () {
                    me.patientId = $scope.patientId;
                    me.getLocationHistoryData();
                }

                me.getLocationHistoryData = function (duration) {
                    $loading.start('locHistory');
                    appointmentService.getLocationHistory(me.patientId).then(function (response) {
                        $scope.apptLocationHistoryData = response;
                        $loading.finish('locHistory');
                    }).catch(function (err) {
                        $loading.finish('locHistory');
                        console.log('Error while fetching Location History:' + err);
                        alert('Error while fetching Location History');
                    });
                }

                me.initialize();
            }
        }
    }
]);
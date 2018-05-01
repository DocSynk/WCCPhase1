servicesModule.service('AppointmentService', ['$http', '$q',
        function ($http, $q) {
            var me = this;

            me.getNoShowsAndCancels = function (patientId) {
                var deferred = $q.defer(),
                    url;

                url = patientId ? './appointments/NoShowsAndCancels/?patientId=' + patientId : './appointments/NoShowsAndCancels';

                $http.get(url)
                    .then(function (response) {
                        deferred.resolve(response.data);
                    }, function (response) {
                        deferred.reject(response.error);
                    });

                return deferred.promise;
            }

            me.getDelays = function (delayType, patientId) {
                var deferred = $q.defer(),
                    url;

                url = './appointments/delays/?delayType=' + delayType;

                if (patientId) {
                    url = url + '&patientId=' + patientId;
                }

                $http.get(url)
                    .then(function (response) {
                        deferred.resolve(response.data);
                    },function (response) {
                        deferred.reject(response.error);
                    });

                return deferred.promise;
            }

            me.getLocationHistory = function (patientId) {
                var deferred = $q.defer(),
                    url;

                url = patientId ? './appointments/locationhistory/?patientId=' + patientId : './appointments/locationhistory';

                $http.get(url)
                    .then(function (response) {
                        deferred.resolve(response.data);
                    },function (response) {
                        deferred.reject(response.error);
                    });

                return deferred.promise;
            }

            me.getApptDelayFilters = function () {
                /*var filters = [
                    { Code: 'R', Description: 'Appt Rescheduled' },
                    { Code: 'P', Description: 'Patient Related' },
                    { Code: 'U', Description: 'UnKnown' }
                ];*/

                var filters = [
                    { Code: '', Description: 'All' },
                    { Code: '%R%', Description: 'Rescheduled' },
                    { Code: '%PA%', Description: 'Patient Related' },
                    { Code: '%O%', Description: 'UnKnown' },
                ];

                return filters;
            }
        }
]);
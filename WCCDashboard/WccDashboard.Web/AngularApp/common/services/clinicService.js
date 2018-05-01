servicesModule.service('ClinicService', ['$http', '$q',
        function ($http, $q) {
            var me = this;

            me.getPatients = function () {
                var deferred = $q.defer();
                
                $http.get('./clinic/patients/').then(function (response) {
                    deferred.resolve(response.data);
                }, function (response) {
                    deferred.reject(response.error);
                });

                return deferred.promise;
            }

            me.getCabRequests = function (patientId) {
                var deferred = $q.defer(),
                    url;

                url = patientId ? './clinic/cabrequests/?patientId=' + patientId : './clinic/cabrequests';

                $http.get(url)
                    .then(function (response) {
                        deferred.resolve(response.data);
                    },function (data, status) {
                        deferred.reject(response.error);
                    });

                return deferred.promise;
            }

            me.getActivityHistory = function (patientId) {
                var deferred = $q.defer(),
                    url;

                url = patientId ? './clinic/activityhistory/?patientId=' + patientId : './clinic/activityhistory';

                $http.get(url)
                    .then(function (response) {
                        deferred.resolve(response.data);
                    },function (data, status) {
                        deferred.reject(response.error);
                    });

                return deferred.promise;
            }

           
        }
]);
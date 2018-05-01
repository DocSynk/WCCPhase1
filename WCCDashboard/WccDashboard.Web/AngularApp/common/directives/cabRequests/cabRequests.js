directivesModule.directive("cabRequests", ['ClinicService', 
    function (clinicService) {
        return {
            restrict: 'E',
            templateUrl: '/AngularApp/common/directives/cabRequests/cab-requests.tpl.html',
            scope : {
                patientId: '='
            },
            link : function(scope, element, attrs, ngModel) {
                
            },
            controller: function ($scope, $element, $timeout, $loading) {
                var me = this;

                me.cabRideData = null;
                me.weekly_ride_data = [];
                me.monthly_ride_data = [];
               
                $scope.chartData = {};
                $scope.chartOptions = {};

                $scope.currWeek_rides = 0;
                $scope.currMonth_rides = 0;
             

                me.initialize = function () {
                    me.patientId = $scope.patientId;
                    $scope.displayMode = 'month';
                    me.getCabRidesData();
                }

                me.getCabRidesData = function () {
                    $loading.start('cabRequests');
                    clinicService.getCabRequests(me.patientId).then(function (response) {
                        me.cabRideData = response;

                        if (me.cabRideData.CurrentWeekData && me.cabRideData.CurrentWeekData.Data) {
                            angular.forEach(me.cabRideData.CurrentWeekData.Data, function (ride) {
                                me.weekly_ride_data.push({ Date: ride.Date, Count: ride.TotalRequests });
                                $scope.currWeek_rides = $scope.currWeek_rides + ride.TotalRequests;
                            });
                        }

                        if (me.cabRideData.CurrentMonthData && me.cabRideData.CurrentMonthData.Data) {
                            angular.forEach(me.cabRideData.CurrentMonthData.Data, function (ride) {
                                me.monthly_ride_data.push({ Date: ride.Date, Count: ride.TotalRequests });
                                $scope.currMonth_rides = $scope.currMonth_rides + ride.TotalRequests;
                            });
                        }
                        $loading.finish('cabRequests');
                        me.showChart();
                    }).catch(function (err) {
                        $loading.finish('cabRequests');
                        console.log('Error while fetching Cab Requests:' + err);
                        alert('Error while fetching Cab Requests');
                    });
                }

                me.parseDate = function (d) {
                    var jsDate = new Date(parseInt(d.substr(6)));
                    return new Date(jsDate);
                };

                $scope.showCurrWeekData = function () {
                    $scope.displayMode = 'week';
                    me.showChart();
                }

                $scope.showCurrMonthData = function () {
                    $scope.displayMode = 'month';
                    me.showChart();
                }

                me.showChart = function () {
                    var ride_data = [],
                        startDate,
                        endDate,
                        maxCount,
                        mode;

                    mode = $scope.displayMode;

                    $scope.chartOptions = {
                        chart: {
                            type: 'lineChart',
                            height: 250,
                            margin: {
                                top: 20,
                                right: 30,
                                bottom: 80,
                                left: 30
                            },

                            x: function (d) { return me.parseDate(d.Date); },
                            y: function (d) { return d.Count; },
                            useInteractiveGuideline: true,
                            yAxis: {
                                showMaxMin: false
                            },
                            showValues: false,
                            xScale: d3.time.scale(),
                            xAxis: {
                                showMaxMin: true,
                                ticks: d3.time.days,
                                tickFormat: function (d) {
                                    return d3.time.format('%d/%b')(new Date(d));
                                }
                            },
                            showLabels: false,
                            showLegend: false
                        },
                        title: {
                            enable: false
                        },
                        subtitle: {
                            enable: false
                        },
                        caption: {
                            enable: false
                        }
                    };

                    if (mode === 'week') {
                        ride_data = me.weekly_ride_data;
                        startDate = me.parseDate(me.cabRideData.CurrentWeekData.StartDate);
                        endDate = me.parseDate(me.cabRideData.CurrentWeekData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 0;
                    } else {
                        ride_data = me.monthly_ride_data;
                        startDate = me.parseDate(me.cabRideData.CurrentMonthData.StartDate);
                        endDate = me.parseDate(me.cabRideData.CurrentMonthData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 90;
                        $scope.chartOptions.chart.xAxis.ticks = (ride_data.length >= 10) ? 10 : $scope.chartOptions.chart.xAxis.ticks;
                    }

                    maxCount = Math.max.apply(Math, ride_data.map(function (item) { return item.Count; }));
                    $scope.chartOptions.chart.xDomain = [new Date(startDate), new Date(endDate)];
                    $scope.chartOptions.chart.yDomain = [0, maxCount];

                    $scope.chartData = [
                        {
                            key: 'Hails ',
                            strokeWidth: 2,
                            color: '#0000ff',
                            values: ride_data
                        }
                    ];
                }

                me.initialize();
            }
        }
    }
]);
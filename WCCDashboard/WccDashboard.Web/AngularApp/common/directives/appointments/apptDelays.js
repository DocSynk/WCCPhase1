directivesModule.directive("apptDelays", ['AppointmentService',
    function (appointmentService) {
        return {
            restrict: 'E',
            templateUrl: '/AngularApp/common/directives/appointments/appt-delays.tpl.html',
            scope : {
                patientId: '='
            },
            link : function(scope, element, attrs, ngModel) {
                
            },
            controller: function ($scope, $element, $timeout, $loading) {
                var me = this;

                me.apptDelaysData = null;
                me.weekly_apptDelay_data = [];
                me.monthly_apptDelay_data = [];
               
                $scope.chartData = {};
                $scope.chartOptions = {};

                $scope.displayMode = 'month';
                $scope.delayFilter = '';

                $scope.currWeek_delays = 0;
                $scope.currMonth_delays = 0;
             

                me.initialize = function () {
                    me.patientId = $scope.patientId;
                    $scope.displayMode = 'month';
                    me.getApptDelaysFilters();
                    if ($scope.delayFilters && $scope.delayFilters.length > 0) {
                        $scope.delayFilter = $scope.delayFilters[0].Code;
                    }
                    me.getApptDelaysData();
                }

                me.getApptDelaysFilters = function (duration) {
                    $scope.delayFilters = appointmentService.getApptDelayFilters();
                };

                me.getApptDelaysData = function () {
                    $loading.start('aptDelays');

                    me.weekly_apptDelay_data = [];
                    me.monthly_apptDelay_data = [];
                    $scope.currWeek_delays = 0;
                    $scope.currMonth_delays = 0;

                    appointmentService.getDelays($scope.delayFilter, me.patientId).then(function (response) {
                        me.apptDelaysData = response;

                        if (me.apptDelaysData.CurrentWeekData && me.apptDelaysData.CurrentWeekData.Data) {
                            angular.forEach(me.apptDelaysData.CurrentWeekData.Data, function (appt) {
                                me.weekly_apptDelay_data.push({ Date: appt.Date, Count: appt.TotalDelays });
                                $scope.currWeek_delays = $scope.currWeek_delays + appt.TotalDelays;
                            });
                        }

                        if (me.apptDelaysData.CurrentMonthData && me.apptDelaysData.CurrentMonthData.Data) {
                            angular.forEach(me.apptDelaysData.CurrentMonthData.Data, function (appt) {
                                me.monthly_apptDelay_data.push({ Date: appt.Date, Count: appt.TotalDelays });
                                $scope.currMonth_delays = $scope.currMonth_delays + appt.TotalDelays;
                            });
                        }
                        $loading.finish('aptDelays');
                        me.showChart();
                    }).catch(function (err) {
                        $loading.finish('aptDelays');
                        console.log('Error while fetching Appointment Delays:' + err);
                        alert('Error while fetching Appointment Delays');
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
                    var delaysData = [],
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
                                showMaxMin: true
                            },
                            showValues: true,
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
                        delaysData = me.weekly_apptDelay_data;
                        startDate = me.parseDate(me.apptDelaysData.CurrentWeekData.StartDate);
                        endDate = me.parseDate(me.apptDelaysData.CurrentWeekData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 0;
                        //$scope.chartOptions.chart.xAxis.ticks = delaysData.length;
                    } else {
                        delaysData = me.monthly_apptDelay_data;
                        startDate = me.parseDate(me.apptDelaysData.CurrentMonthData.StartDate);
                        endDate = me.parseDate(me.apptDelaysData.CurrentMonthData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 90;
                        $scope.chartOptions.chart.xAxis.ticks = (delaysData.length >= 10) ? 10 : $scope.chartOptions.chart.xAxis.ticks;
                    }
                    maxCount = Math.max.apply(Math, delaysData.map(function (item) { return item.Count; }));
                    $scope.chartOptions.chart.xDomain = [new Date(startDate), new Date(endDate)];
                    $scope.chartOptions.chart.yDomain = [0, maxCount];

                    $scope.chartData = [
                        {
                            key: 'Appointment Delay(s)',
                            strokeWidth: 2,
                            color: '#0000ff',
                            values: delaysData
                        }
                    ];
                }

                $scope.filterChanged = function() {
                    me.getApptDelaysData();
                }

                me.initialize();
            }
        }
    }
]);
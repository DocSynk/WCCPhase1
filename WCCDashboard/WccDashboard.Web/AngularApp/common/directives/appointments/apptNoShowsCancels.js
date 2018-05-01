directivesModule.directive("apptNoshowsCancels", ['AppointmentService', 
    function (appointmentService) {
        return {
            restrict: 'E',
            templateUrl: '/AngularApp/common/directives/appointments/appt-noshows-cancels.tpl.html',
            scope : {
                patientId: '='
            },
            link : function(scope, element, attrs, ngModel) {
                
            },
            controller: function ($scope, $element, $timeout, $loading) {
                var me = this;

                me.apptsData = null;
                me.weekly_cancel_data = [];
                me.weekly_noshow_data = [];
                me.monthly_cancel_data = [];
                me.monthly_noshow_data = [];

                $scope.chartData = {};
                $scope.chartOptions = {};

                $scope.displayMode = 'month';

                $scope.currWeek_noshows = 0;
                $scope.currWeek_cancels = 0;
                $scope.currMonth_noshows = 0;
                $scope.currMonth_cancels = 0;


                me.initialize = function () {
                    me.patientId = $scope.patientId;
                    $scope.displayMode = 'month';
                    me.getAppointmentsData();
                }

                me.getAppointmentsData = function () {
                    $loading.start('aptNoShowCancels');
                    appointmentService.getNoShowsAndCancels(me.patientId).then(function (response) {
                        me.apptsData = response;

                        if (me.apptsData.CurrentWeekData && me.apptsData.CurrentWeekData.Data) {
                            angular.forEach(me.apptsData.CurrentWeekData.Data, function (appt) {
                                me.weekly_cancel_data.push({ Date: appt.Date, Count: appt.TotalCancelled });
                                me.weekly_noshow_data.push({ Date: appt.Date, Count: appt.TotalNoShows });

                                $scope.currWeek_noshows = $scope.currWeek_noshows + appt.TotalNoShows;
                                $scope.currWeek_cancels = $scope.currWeek_cancels + appt.TotalCancelled;
                            });
                        }

                        if (me.apptsData.CurrentMonthData && me.apptsData.CurrentMonthData.Data) {
                            angular.forEach(me.apptsData.CurrentMonthData.Data, function (appt) {
                                me.monthly_cancel_data.push({ Date: appt.Date, Count: appt.TotalCancelled });
                                me.monthly_noshow_data.push({ Date: appt.Date, Count: appt.TotalNoShows });

                                $scope.currMonth_noshows = $scope.currMonth_noshows + appt.TotalNoShows;
                                $scope.currMonth_cancels = $scope.currMonth_cancels + appt.TotalCancelled;
                            });
                        }
                        $loading.finish('aptNoShowCancels');
                        me.showChart();
                    }).catch(function (err) {
                        $loading.finish('aptNoShowCancels');
                        console.log('Error while fetching AppointmentsData:' + err);
                        alert('Error while fetching AppointmentsData');
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
                    var cancel_data = [],
                        noshow_data = [],
                        startDate,
                        endDate,
                        maxNoshows,
                        maxCancels, 
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
                        cancel_data = me.weekly_cancel_data;
                        noshow_data = me.weekly_noshow_data;
                        startDate = me.parseDate(me.apptsData.CurrentWeekData.StartDate);
                        endDate = me.parseDate(me.apptsData.CurrentWeekData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 0;
                    } else {
                        cancel_data = me.monthly_cancel_data;
                        noshow_data = me.monthly_noshow_data;
                        startDate = me.parseDate(me.apptsData.CurrentMonthData.StartDate);
                        endDate = me.parseDate(me.apptsData.CurrentMonthData.EndDate);
                        $scope.chartOptions.chart.xAxis.rotateLabels = 90;
                        $scope.chartOptions.chart.xAxis.ticks = (noshow_data.length >= 10) ? 10 : $scope.chartOptions.chart.xAxis.ticks;
                    }

                    maxNoshows = Math.max.apply(Math, noshow_data.map(function (item) { return item.Count; }));
                    maxCancels = Math.max.apply(Math, cancel_data.map(function (item) { return item.Count; }));
                    $scope.chartOptions.chart.xDomain = [new Date(startDate), new Date(endDate)];
                    $scope.chartOptions.chart.yDomain = [0, maxNoshows > maxCancels ? maxNoshows : maxCancels];

                    $scope.chartData = [
                        {
                            key: 'No-Show',
                            strokeWidth: 2,
                            color: '#0000ff',
                            values: noshow_data
                        },
                        {
                            key: 'Cancelled',
                            color: '#ff7f0e',
                            strokeWidth: 2,
                            color: '#ff7f0e',
                            classed: 'dashed',
                            values: cancel_data
                        }
                    ];
                }

                me.initialize();
            }
        }
    }
]);
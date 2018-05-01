directivesModule.directive("activityHistory", ['ClinicService', 
    function (clinicService) {
        return {
            restrict: 'E',
            templateUrl: '/AngularApp/common/directives/activityHistory/activity-history.tpl.html',
            scope : {
                patientId: '='
            },
            link : function(scope, element, attrs, ngModel) {
                
            },
            controller: function ($scope, $element, $timeout, $loading) {
                var me = this;

                me.activityHistoryData = null;
                me.weekly_sent_data = [];
                me.weekly_opens_data = [];
                me.monthly_sent_data = [];
                me.monthly_opens_data = [];

                $scope.chartData = {};
                $scope.chartOptions = {};

                $scope.currWeek_opens = 0;
                $scope.currWeek_sent = 0;
                $scope.currMonth_opens = 0;
                $scope.currMonth_sent = 0;


                me.initialize = function () {
                    me.patientId = $scope.patientId;
                    $scope.displayMode = 'month';
                    me.getActivityHistoryData();
                }

                me.getActivityHistoryData = function (duration) {
                    $loading.start('actHistory');
                    clinicService.getActivityHistory(me.patientId).then(function (response) {
                        me.activityHistoryData = response;

                        if (me.activityHistoryData.CurrentWeekData && me.activityHistoryData.CurrentWeekData.Data) {
                            angular.forEach(me.activityHistoryData.CurrentWeekData.Data, function (act) {
                                me.weekly_sent_data.push({ Date: act.Date, Count: act.TotalSent });
                                me.weekly_opens_data.push({ Date: act.Date, Count: act.TotalOpens });

                                $scope.currWeek_opens = $scope.currWeek_opens + act.TotalOpens;
                                $scope.currWeek_sent = $scope.currWeek_sent + act.TotalSent;
                            });
                        }

                        if (me.activityHistoryData.CurrentMonthData && me.activityHistoryData.CurrentMonthData.Data) {
                            angular.forEach(me.activityHistoryData.CurrentMonthData.Data, function (act) {
                                me.monthly_sent_data.push({ Date: act.Date, Count: act.TotalSent });
                                me.monthly_opens_data.push({ Date: act.Date, Count: act.TotalOpens });

                                $scope.currMonth_opens = $scope.currMonth_opens + act.TotalOpens;
                                $scope.currMonth_sent = $scope.currMonth_sent + act.TotalSent;
                            });
                        }
                        $loading.finish('actHistory');
                        me.showChart();
                    }).catch(function (err) {
                        $loading.finish('actHistory');
                        console.log('Error while fetching Activity History:' + err);
                        alert('Error while fetching Activity History');
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
                    var act_sent_data = [],
                        act_opens_data = [],
                        startDate,
                        endDate,
                        maxOpens,
                        maxSents,
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
                                showMaxMin: false,
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
                        act_sent_data = me.weekly_sent_data;
                        act_opens_data = me.weekly_opens_data;
                        startDate = me.parseDate(me.activityHistoryData.CurrentWeekData.StartDate);
                        endDate = me.parseDate(me.activityHistoryData.CurrentWeekData.EndDate);
                        maxCount = $scope.currWeek_opens > $scope.currWeek_sent ? $scope.currWeek_opens : $scope.currWeek_sent;
                        $scope.chartOptions.chart.xAxis.rotateLabels = 0;
                    } else {
                        act_sent_data = me.monthly_sent_data;
                        act_opens_data = me.monthly_opens_data;
                        startDate = me.parseDate(me.activityHistoryData.CurrentMonthData.StartDate);
                        endDate = me.parseDate(me.activityHistoryData.CurrentMonthData.EndDate);
                        maxCount = $scope.currMonth_opens > $scope.currMonth_sent ? $scope.currMonth_opens : $scope.currMonth_sent;
                        $scope.chartOptions.chart.xAxis.rotateLabels = 90;
                        $scope.chartOptions.chart.xAxis.ticks = (act_opens_data.length >= 10) ? 10 : $scope.chartOptions.chart.xAxis.ticks;
                    }

                    maxOpens = Math.max.apply(Math, act_opens_data.map(function (item) { return item.Count; }));
                    maxSents = Math.max.apply(Math, act_sent_data.map(function (item) { return item.Count; }));

                    $scope.chartOptions.chart.xDomain = [new Date(startDate), new Date(endDate)];
                    $scope.chartOptions.chart.yDomain = [0, maxOpens > maxSents ? maxOpens : maxSents];

                   $scope.chartData = [
                        {
                            key: 'Opens',
                            strokeWidth: 2,
                            color: '#0000ff',
                            values: act_opens_data
                        },
                        {
                            key: 'Sent', //key  - the name of the series.
                            color: '#ff7f0e',  //color - optional: choose your own line color.
                            strokeWidth: 2,
                            color: '#ff7f0e',
                            classed: 'dashed',
                            values: act_sent_data
                        }
                    ];
                }

                me.initialize();
            }
        }
    }
]);
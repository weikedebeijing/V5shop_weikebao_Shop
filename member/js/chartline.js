// JavaScript Document

//today
$(function () {
    var date = GetToDayPrice();
    $('#totaltoday').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '成交额统计'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['00:00-6:00', '6:00-12:00', '12:00-18:00', '18:00-24:00']
        },
        yAxis: {
            title: {
                text: '成交额(元)'
            },
            min:0
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'°C';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: '成交额',
            data: date
        }]
    });
});	

//yestoday
$(function () {
    var yesterday = GetYesterDayPrice();
    $('#yestoday').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '成交额统计'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['00:00-6:00', '6:00-12:00', '12:00-18:00', '18:00-24:00']
        },
        yAxis: {
            title: {
                text: '成交额(元)'
            },
            min: 0
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'°C';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: '成交额',
            data: yesterday
        }]
    });
});	
//weekday
$(function () {
    var thisweek = GetThisWeekPrice();
    $('#weekday').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '成交额统计'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
        },
        yAxis: {
            title: {
                text: '成交额(元)'
            },
            min: 0
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'°C';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: '成交额',
            data: thisweek
        }]
    });
});	

//moonth
$(function () {
    var thismonth = GetThisMonthPrice();
    $('#moonth').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: '成交额统计'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: ['01-07', '07-14', '14-21', '21-31']
        },
        yAxis: {
            title: {
                text: '成交额(元)'
            },
            min: 0
        },
        tooltip: {
            enabled: false,
            formatter: function() {
                return '<b>'+ this.series.name +'</b><br/>'+this.x +': '+ this.y +'°C';
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: '成交额',
            data: thismonth
        }]
    });
});	
$(function () {
  $("div[id^=gauge]").each(function(index, element) {
    renderGauge(
      element.id,
      parseFloat($(element).attr('data-hours'), 10),
      $(element).attr('data-title')
    );
  });

  renderMonthlyGraph();

});

function renderGauge(container, hours, title)
{
  $('#' + container).highcharts({
    chart: {
      type: 'gauge',
      plotBackgroundColor: null,
      plotBackgroundImage: null,
      plotBorderWidth: 0,
      plotShadow: false,
      backgroundColor: 'transparent'
    },

    title: {
      text: title
    },

    pane: {
      startAngle: -150,
      endAngle: 150,
      background: [{
        backgroundColor: {
          linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
          stops: [
            [0, '#FFF'],
            [1, '#333']
          ]
        },
        borderWidth: 0,
        outerRadius: '109%'
      }, {
        backgroundColor: {
          linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
          stops: [
            [0, '#333'],
            [1, '#FFF']
          ]
        },
        borderWidth: 1,
        outerRadius: '107%'
      }, {
        // default background
      }, {
        backgroundColor: '#DDD',
        borderWidth: 0,
        outerRadius: '105%',
        innerRadius: '103%'
      }]
    },

    // the value axis
    yAxis: {
      min: 0,
      max: 20,

      minorTickInterval: 'auto',
      minorTickWidth: 1,
      minorTickLength: 10,
      minorTickPosition: 'inside',
      minorTickColor: '#666',

      tickPixelInterval: 30,
      tickWidth: 2,
      tickPosition: 'inside',
      tickLength: 10,
      tickColor: '#666',
      labels: {
        step: 2,
        rotation: 'auto'
      },
      title: {
        text: 'Hours This Week'
      },
      plotBands: [{
        from: 0,
        to: 2,
        color: '#DF5353' // red
      }, {
        from: 2,
        to: 6,
        color: '#DDDF0D' // yellow
      }, {
        from: 6,
        to: 20,
        color: '#55BF3B' // green
      }]
    },

    series: [{
      name: 'Hours',
      data: [hours],
      tooltip: {
        valueSuffix: ' Hours'
      }
    }]

  });
}


function renderMonthlyGraph()
{
  $('#container').highcharts({
    chart: {
      type: 'line',
      backgroundColor: 'transparent'
    },
    title: {
      text: 'Monthly Hours Worked'
    },
    xAxis: {
      categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },
    yAxis: {
      title: {
        text: 'Hours Worked Per Month'
      }
    },
    tooltip: {
      enabled: true,
      formatter: function() {
        return '<b>'+ this.series.name +'</b><br/>'+
          this.x +': '+ this.y +' hours';
      }
    },
    plotOptions: {
      line: {
        dataLabels: {
          enabled: true,
          style: {
            textShadow: '0 0 3px white, 0 0 3px white'
          }
        },
        enableMouseTracking: true
      }
    },
    series: formatData()
  });

}

function formatData() {
  var dataPoints = {};

  $("table tbody tr").each(function(index, row) {
    var developer = $(row).children().eq(0).html();
    var amount = parseFloat($(row).children().eq(2).html());

    if (typeof(dataPoints[developer]) == "undefined") {
      dataPoints[developer] = [];
    }

    dataPoints[developer].push(amount);
  });

  var results = [];
  for (var prop in dataPoints) {
    results.push({name: prop, data: dataPoints[prop]});
  }

  return results;
}

$(document).ready(renderGraph);

function formatData() {
  var dataPoints = [];

  $("table tbody tr").each(function(index, row) {
    var developer = $(row).children().eq(0).html();
    var amount = parseFloat($(row).children().eq(1).html());

    dataPoints.push([ developer, amount ]);
  });

  return dataPoints;
}

function renderGraph() {
  $('#chartContainer').highcharts({
    chart: {
      plotBackgroundColor: null,
      plotBorderWidth: null,
      plotShadow: false,
      backgroundColor: "transparent"
    },
    title: {
      text: 'Hours By Developer'
    },
    tooltip: {
      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
      pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: false
        },
        showInLegend: true
      }
    },
    series: [{
      type: 'pie',
      name: 'Work Share',
      data: formatData()
    }]
  });
}

$(document).ready(renderGraph);

function formatData() {
  var currentDev = "";
  var series = [];
  var data = [];

  $("table tbody tr").each(function(index, row) {
    var developer = $(row).children().eq(0).html();
    var project = $(row).children().eq(1).html();
    var amount = parseFloat($(row).children().eq(2).html());

    if (currentDev != developer) {
      if ( "" != currentDev ) {
        series.push({ name: currentDev, data: data });
      }

      currentDev = developer;
      data = [];
    }

    data.push(amount);
  });

  series.push({ name: currentDev, data: data });

  return series;
}

function arrayUnique(a) {
  return a.reduce(function(uniques, c) {
    if (uniques.indexOf(c) < 0) uniques.push(c);
    return uniques;
  }, []);
}

function renderGraph() {
  var labels = $.map($("table tr td:nth-child(2)"), function(element) {
    return $(element).html();
  });

  $('#chartContainer').highcharts({
    chart: {
      type: 'bar',
      backgroundColor: 'transparent'
    },
    title: {
      text: 'Hours By Developer By Project'
    },
    xAxis: {
      categories: arrayUnique(labels)
    },
    yAxis: {
      min: 0,
      title: {
        text: 'Total Hours Billed'
      }
    },
    legend: {
      backgroundColor: '#FFFFFF',
      reversed: true
    },
    plotOptions: {
      series: {
        stacking: 'normal'
      }
    },
    series: formatData()
  });
}

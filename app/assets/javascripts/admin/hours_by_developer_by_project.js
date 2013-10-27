$(document).ready(renderGraph);

function formatData() {
  var currentDev = "";
  var allData = [];
  var dataPoints = [];

  $("table tbody tr").each(function(index, row) {
    var developer = $(row).children().eq(0).html();
    var project = $(row).children().eq(1).html();
    var amount = parseFloat($(row).children().eq(2).html());

    if (currentDev != developer) {
      if ( "" != currentDev ) {
        allData.push(formatDataPointEntry(dataPoints, currentDev));
      }

      currentDev = developer;
      dataPoints = [];
    }

    dataPoints.push({ y: amount, label: project });
  });

  allData.push(formatDataPointEntry(dataPoints, currentDev));

  return allData;
}

function formatDataPointEntry(dataPoints, developer) {
  return { type: "bar",
           showInLegend: true,
           legendText: developer,
           dataPoints: dataPoints.reverse()
         };
}

function renderGraph() {
  var chart = new CanvasJS.Chart("chartContainer",
                                 {
                                   backgroundColor: "transparent",
                                   title:{
                                     text: "Hours By Developer By Project"
                                   },
                                   axisY: {
                                     title: "Total Hours"
                                   },
                                   data: formatData()
                                 });

  chart.render();
}

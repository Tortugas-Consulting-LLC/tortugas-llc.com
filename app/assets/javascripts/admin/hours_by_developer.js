$(document).ready(renderGraph);

function formatData() {
  var dataPoints = [];

  $("table tbody tr").each(function(index, row) {
    var developer = $(row).children().eq(0).html();
    var amount = $(row).children().eq(1).html();

    dataPoints.push({ y: amount, legendText: developer, indexLabel: developer });
  });

  return dataPoints;
}

function renderGraph() {
  var chart = new CanvasJS.Chart("chartContainer",
                                 {
                                   backgroundColor: "transparent",
                                   title:{
                                     text: "Hours By Developer"
                                   },
                                   legend: {
                                     verticalAlign: "bottom",
                                     horizontalAlign: "center"
                                   },
                                   data: [
                                     {
                                       type: "pie",
                                       showInLegend: true,
                                       dataPoints: formatData()
                                     }
                                   ]
                                 });

  chart.render();
}

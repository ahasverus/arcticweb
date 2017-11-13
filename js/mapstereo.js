/********************************************/

var width1 = 560,
    height1 = 560;

var projection1 = d3.geo.stereographic()
    .scale(375) // ZOOM
    .translate([width1 / 2, height1 / .75]) // CENTRE
    .rotate([-20, 0])
    .clipAngle(180 - 1e-4)
    .clipExtent([[0, 0], [width1, height1]])
    .precision(.1);

var path1 = d3.geo.path()
    .projection(projection1);

var graticule1 = d3.geo.graticule();

var svg1 = d3.select("#mapstereo").append("svg")
    .attr("width", width1)
    .attr("height", height1);

var tooltip1 = d3.select(".d3-tip")
    .style("position", "absolute")
    .style("z-index", "10")
    .style("visibility", "hidden");

svg1.append("path")
    .datum(graticule1)
    .attr("class", "graticule")
    .attr("d", path1);

d3.json("data/world-50m.json", function(error, world) {

  svg1.insert("path", ".graticule")
  .datum(topojson.feature(world, world.objects.land))
  .attr("class", "land")
  .attr("d", path1);

  svg1.insert("path", ".graticule")
  .datum(topojson.mesh(world, world.objects.countries, function(a, b) { return a !== b; }))
  .attr("class", "boundary")
  .attr("d", path1);

  d3.csv("data/stations.csv", function(error, data) { 

    svg1.selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("cx", function(d) { return projection1([d.lon, d.lat])[0]; })
    .attr("cy", function(d) { return projection1([d.lon, d.lat])[1]; })
    .attr("r", "5px")
    .style("fill", "red")
    .on("mouseover", function(d){
      return tooltip1
      .style("visibility", "visible")
      .style("top", (event.pageY+10)+"px")
      .style("left",(event.pageX+10)+"px")
      .text(d.sta);
    })
    .on("click", function(d){ 
      window.open(d.lin);
    })
    .on("mouseout", function(){
      return tooltip1
      .style("visibility", "hidden");
    });
  });
});

d3.select(self.frameElement).style("height", height1 + "px");



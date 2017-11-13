/********************************************/

var width = 750,
    height = 450;

var projection = d3.geo.albers()
    .rotate([96, 0])
    .center([3, 61])
    .parallels([29.5, 45.5])
    .scale(700)
    .translate([width / 2, height / 2])
    .precision(.1);

var path = d3.geo.path()
    .projection(projection);

var graticule = d3.geo.graticule();

var svg = d3.select("#maportho").append("svg")
    .attr("width", width)
    .attr("height", height);

var tooltip = d3.select(".d3-tip2")
    .style("position", "absolute")
    .style("z-index", "10")
    .style("visibility", "hidden");

svg.append("path")
    .datum(graticule)
    .attr("class", "graticule")
    .attr("d", path);

d3.json("data/world-50m.json", function(error, world) {

  svg.insert("path", ".graticule")
  .datum(topojson.feature(world, world.objects.land))
  .attr("class", "land")
  .attr("d", path);

  svg.insert("path", ".graticule")
  .datum(topojson.mesh(world, world.objects.countries, function(a, b) { return a !== b; }))
  .attr("class", "boundary")
  .attr("d", path);

  d3.csv("data/stations.csv", function(error, data) { 

    svg.selectAll("circle")
    .data(data)
    .enter()
    .append("circle")
    .attr("cx", function(d) { return projection([d.lon, d.lat])[0]; })
    .attr("cy", function(d) { return projection([d.lon, d.lat])[1]; })
    .attr("r", "5px")
    .style("fill", "red")
    .on("mouseover", function(d){
      return tooltip
      .style("visibility", "visible")
      .style("top", (event.pageY+10)+"px")
      .style("left",(event.pageX+10)+"px")
      .text(d.sta);
    })
    .on("click", function(d){ 
      window.open(d.lin);
    })
    .on("mouseout", function(){
      return tooltip
      .style("visibility", "hidden");
    });
  });
});

d3.select(self.frameElement).style("height", height + "px");



var player = document.getElementById('player');
var currentLine = "This Land Is Your Land";
var loadCues = function() {
  //console.log('in loadCues');
  if (!!player.textTracks) {
    //console.dir(player.textTracks);
    for (var i = 0; i < player.textTracks[0].cues.length; i++) {
      //console.log('loadCue ' + i.toString() + ' ' + player.textTracks[0].cues[i].text);
      player.textTracks[0].cues[i].onenter = function() {
        loadLine(this.text);
        showLine();
      };
      player.textTracks[0].cues[i].oncuechange = function() {
        if (!!this.activeCues) {
          var cue = this.activeCues[0];
          loadLine(cue.text);
          showLine();
        }
      };
    }
  }
};

var muteRatio = 0;

var forceLine = function() {
  if (!!player.textTracks && !!player.textTracks[0].activeCues && (player.textTracks[0].activeCues.length > 0)) {
    var cue = player.textTracks[0].activeCues[0];
    if (cue.text != currentLine) {
      loadLine(cue.text);
      showLine();
    }
  }
};

var changeMute = function() {
  if (muteRatio > 0) {
    if (Math.random() <= muteRatio) {
      player.volume = 0;
    }
    else {
      player.volume = 1;
    }
    forceLine();
  }
};

var showLine = function() {
  $('div.content > h1').html('<h1>' + muteText(currentLine) + '</h1>');
};

var showCounty = function(d) {
  var text = '...';
  if (!!d) {
    text = nameById.get(d.id);
  } 
  d3.select("h2.county")
    .html('<h2 class="county">' + text + '</h2>');
};

var showPercentage = function(r) {
  var text = '(touch or click on the map, then listen)'; 
  if (!!r) {
    text = r + ' of children living in poverty';
  }
  d3.select("h3.percentage")
    .html('<h3 class="percentage">' + text + '</h3>');
};

var playerSupport = function() {
  if (!!player.textTracks && player.textTracks.length > 0 && 
      !!player.textTracks[0].cues && player.textTracks[0].cues.length > 0 &&
      !!player.textTracks[0].cues[0])
    return true;
  else {
    return false;
  }
};
      
var startPlayer = function() {
  //if (!!player.textTracks && (player.textTracks[0].cues[0].onenter == null)) {
  if (playerSupport()) {
    loadCues();
  }
  if (player.paused) {
    player.play();
    
  }
};

var pausePlayer = function() {
  if (!player.paused) {
    player.pause();
  }
};

var muteIndices = function(text) {
  var isSpace = /\s/;
  var chars = text.split('');
  var wordChars = _.map(chars, function(v, k, l) {
    if (v.match(isSpace) == null) { // FIXME: use regex instead
      return parseInt(k);
    }
  });

  return _.sample(wordChars, Math.round(muteRatio * wordChars.length));
};

var muteText = function(text) {
  var chars = text.split('');
  var mutes = muteIndices(text);
  chars = _.map(chars, function(v, k, l) {
    if (v == ' ') {
      return v;
    }
    else if (_.contains(mutes, k)) {
      return '_';
    }
    else {
      return v;
    }
  });
  return chars.join('');
};

var loadLine = function(text) {
  currentLine = text;
  //console.log('in loadLine for '  + text);
};

var width = Math.max(960, window.innerWidth);
var height = Math.max(600, window.innerHeight);
var prefix = prefixMatch(["webkit", "ms", "Moz", "O"]);
var tile = d3.geo.tile()
  .size([width, height]);

var rateById = d3.map();
var nameById = d3.map();

var quantize = d3.scale.quantize()
  .domain([0, .6])
  .range(d3.range(9).map(function(i) { return "q" + i + "-9"; }));

var projection = d3.geo.mercator()
  .center([-96.0, 36.0]) //.center([-98.6, 39.8])
  .scale(890)
  .translate([width / 2, height / 2]);

var path = d3.geo.path()
  .projection(projection);

var tile = d3.geo.tile()
  .scale(projection.scale() * 2 * Math.PI)
  .translate(projection([0, 0]))
  .zoomDelta((window.devicePixelRatio || 1) - .5);

var map = d3.select('div.map');

var svg = map
  .append("svg")
  .attr('width', width)
  .attr('height', height)
  .call(d3.behavior.zoom().on('zoom', redraw))
  .append('g');

function redraw() {
  svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
}

function matrix3d(scale, translate) {
  var k = scale / 256, r = scale % 1 ? Number : Math.round;
  return "matrix3d(" + [k, 0, 0, 0, 0, k, 0, 0, 0, 0, k, 0, r(translate[0] * scale), r(translate[1] * scale), 0, 1 ] + ")";
}
 
function prefixMatch(p) {
  var i = -1, n = p.length, s = document.body.style;
  while (++i < n) if (p[i] + "Transform" in s) return "-" + p[i].toLowerCase() + "-";
  return "";
}
 
function formatLocation(p, k) {
  var format = d3.format("." + Math.floor(Math.log(k) / 2 - 2) + "f");
  return (p[1] < 0 ? format(-p[1]) + "°S" : format(p[1]) + "°N") + " "
       + (p[0] < 0 ? format(-p[0]) + "°W" : format(p[0]) + "°E");
}

queue()
  .defer(d3.json, "data/us.json")
  .defer(d3.tsv, "data/childPoverty3.tsv", function(d) {
    rateById.set(d.id, +d.rate);
    nameById.set(d.id, d.county);
  })
  .await(ready);

var tiles = tile();

function ready(error, us) {
  var defs = svg.append("defs");
  defs.append("path")
    .attr("id", "land")
    .datum(topojson.feature(us, us.objects.counties).features)
    .attr("d", path);

  defs.append("clipPath")
    .attr("id", "clip")
    .append("use")
    .attr("xlink:href", "#land");

  svg.append("g")
    .attr("class", "counties")
    .selectAll("path")
    .data(topojson.feature(us, us.objects.counties).features)
    .enter()
      .append("path")
      .attr("class", function(d) { return quantize(rateById.get(d.id)); })
      .attr("id", function(d) { return nameById.get(d.id); })
      .attr("d", path)
      .append("title")
      .text(function(d) {
        return nameById.get(d.id) + "\n" + Math.round(rateById.get(d.id) * 10000) / 100 + "% of children living in poverty";
      })
      .attr("clip-path", "url(#clip)")
      .selectAll("image")
        .data(tiles)
      .append("image")
      .attr("xlink:href", function(d) { return "http://" + ["a", "b", "c", "d"][Math.random() * 4 | 0] + ".tiles.mapbox.com/v3/mapbox.natural-earth-2/" + d[2] + "/" + d[0] + "/" + d[1] + ".png"; })
      .attr("width", Math.round(tiles.scale))
      .attr("height", Math.round(tiles.scale))
      .attr("x", function(d) { return Math.round((d[0] + tiles.translate[0]) * tiles.scale); })
      .attr("y", function(d) { return Math.round((d[1] + tiles.translate[1]) * tiles.scale); });

  svg.append("use")
    .attr("xlink:href", "#land")
    .attr("class", "stroke");


  svg.append("path")
    .datum(topojson.mesh(us, us.objects.states, function(a, b) { return a !== b; }))
    .attr("class", "states")
    .attr("d", path)
    .attr('stroke-width', 1);

  svg.selectAll("g.counties > path")
    .on("mouseover", function (d) {
      var r = Math.round(rateById.get(d.id) * 10000) / 100;
      r = r + "%";
      //console.log(nameById.get(d.id) + r);
      muteRatio = rateById.get(d.id);
      startPlayer();
      showLine();
      showCounty(d);
      showPercentage(r);
    })
    .on("mouseout", function(d) {
      muteRatio = 0;
      showCounty();
      showPercentage();
    });

  d3.select("g.counties")
    .on("mouseleave", function() {
      pausePlayer();
      $('div.content > h1').html('<h1>Th_s Lan_ Is Yo_r L_nd</h1>');
    });
}

d3.select(self.frameElement).style("height", height + "px");


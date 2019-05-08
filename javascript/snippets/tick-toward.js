function tickToward(start,end){
  var [x1, y1] = start;
  var [x2, y2] = end;
  
  var maxX = x2 - x1;
  var maxY = y2 - y1;
  
  var xDirection = Math.sign(maxX);
  var yDirection = Math.sign(maxY);
  
  var xSteps = [];
  var ySteps = [];
  var finalSteps = [];
  
  for (var x = 0; Math.abs(x) < Math.abs(maxX + xDirection); x += xDirection) {
    xSteps.push(x);
  }
  
  debugger;
  
  for (var y = 0; Math.abs(y) < Math.abs(maxY + yDirection); y += yDirection) {
    ySteps.push(y);
  }
  
  var highestSteps = xSteps.length > ySteps.length ? xSteps.length : ySteps.length;
  
  for (var i = 0; i < highestSteps; i++) {
    var xCoord = i > xSteps.length - 1 ? xSteps[xSteps.length - 1] : xSteps[i];
    var yCoord = i > ySteps.length - 1 ? ySteps[ySteps.length - 1] : ySteps[i];
  
    finalSteps.push([x1 + (xCoord || 0), y1 + (yCoord || 0)]);
  } 
  
  return finalSteps;
}

tickToward([5,1],[5,-2])

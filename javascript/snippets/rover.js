var DIRECTIONS = {
    NORTH: 0,
    EAST: 1,
    SOUTH: 2,
    WEST: 3
};

var MOVEMENT_SPEED = 1;
var GRID_WIDTH = 5;
var GRID_HEIGHT = 5;

var rover = {};
var directionDisplayMapping = ['N', 'E', 'S', 'W'];
var movements = [[0, MOVEMENT_SPEED], [MOVEMENT_SPEED, 0], [0, -1 * MOVEMENT_SPEED], [-1 * MOVEMENT_SPEED, 0]];

function setGrid(config) {
    if (!config || typeof config !== 'string') return;
    const splitConfig = config.split(' ');
    if (splitConfig.length < 2) return;
    const [gridWidth, gridHeight] = splitConfig;
    GRID_WIDTH = gridWidth;
    GRID_HEIGHT = gridHeight;
}

function setRover(config) {
    if (!config || typeof config !== 'string') return;
    const splitConfig = config.split(' ');
    if (splitConfig.length < 3) return;
    const [startingX, startingY, startingDirection] = splitConfig;
    return { 
        x: Number(startingX) || 0, 
        y: Number(startingY) || 0, 
        direction: directionDisplayMapping.indexOf(startingDirection) || 0
    };
}

function parseInstructions(instructions) {
    if (!instructions || typeof instructions !== 'string') return;
    instructions.split('').forEach(instruction => {
        switch (instruction) {
            case 'M':
                const [xDelta,yDelta] = movements[rover.direction];
                if (rover.x + xDelta <= GRID_WIDTH && rover.x + xDelta >= 0) rover.x += xDelta;
                if (rover.y + yDelta <= GRID_HEIGHT && rover.y + yDelta >= 0) rover.y += yDelta;
                break;
            case 'L':
            case 'R':
                const rotation = instruction === 'R' ? 1 : -1;
                const newDirection = rover.direction + rotation;
                rover.direction = newDirection < 0 
                    ? movements.length - 1 
                    : newDirection % movements.length;           
                break;
        }
    });

    console.log(rover.x, rover.y, directionDisplayMapping[rover.direction]);
}

setGrid('5 5');
rover = setRover('1 2 N');
parseInstructions('LMLMLMLMM');

rover = setRover('3 3 E');
parseInstructions('MMRMMRMRRM');

import boidz.Boid;
import boidz.Flock;
import boidz.Point;
import boidz.rules.*;
import thx.color.RGB;

class Player {
  public var color : RGB;
  public var swarms : Array<Swarm>;
  public var home : HomeBase;
  public var waypoints : Waypoints;

  public var canvasWidth : Int;
  public var canvasHeight : Int;

  public function new(color : RGB, canvasWidth : Int, canvasHeight : Int) {
    this.color = color;
    this.canvasWidth = canvasWidth;
    this.canvasHeight = canvasHeight;
    swarms = [];
  }

  public function setHome(x : Int, y : Int) {
    home = new HomeBase(x, y);
  }

  public function setSwarmPath(swarm : Swarm, path : Array<Point>) {
    swarm.waypoints.goals = path;
  }

  public function addFlock(numberOfBoidz : Int) {
    var swarm = new Swarm();
    addBoidz(swarm, numberOfBoidz);

    // add swarm to the player's swarm array
    swarms.push(swarm);
  }

  public function addBoidz(swarm: Swarm, howMany : Int) {
    var w = Math.min(canvasWidth, canvasHeight);
    for (i in 0...howMany) {
      // create a new boid and add it to the swarm
      var a = Math.random() * 2 * Math.PI,
        d = w * Math.random(),
        b = new Boid(
          20 + (canvasWidth - 20 * 2) * Math.random(),
          20 + (canvasHeight - 20 * 2) * Math.random(),
          6.0,
          Math.random() * 360
        );
      swarm.boids.push(b);
    }
  }
}
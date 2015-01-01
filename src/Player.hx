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

  public function addFlock(numberOfBoidz : Int, ?attack = 10, ?defense = 10) {
    var swarm = new Swarm(attack, defense);
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
          home.x + Math.random() * 200 - 100,
          home.y + Math.random() * 200 - 100,
          6.0,
          Math.random() * 360
        );
        b.data = { neighbors : [] };
      swarm.boids.push(b);
    }
  }
}
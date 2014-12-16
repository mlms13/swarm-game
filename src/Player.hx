import boidz.Boid;
import boidz.Flock;
import boidz.rules.*;
import thx.color.RGB;

class Player {
  public var color : RGB;
  public var flocks : Array<Flock>;
  public var home : HomeBase;

  public var canvasWidth : Int;
  public var canvasHeight : Int;

  public function new(color : RGB, canvasWidth : Int, canvasHeight : Int) {
    this.color = color;
    this.canvasWidth = canvasWidth;
    this.canvasHeight = canvasHeight;
    flocks = [];
  }

  public function setHome(x : Int, y : Int) {
    home = new HomeBase(x, y);
  }

  public function addFlock(numberOfBoidz : Int) {
    var flock = new Flock();
    addBoidz(flock, numberOfBoidz);

    // add default rules to flock
    flock.addRule(new SteerTowardCenter(flock, 10));
    flock.addRule(new AvoidCollisions(flock, 10.0, 10));

    // add flock to the player's flock array
    flocks.push(flock);
  }

  public function addBoidz(flock: Flock, howMany : Int) {
    var w = Math.min(canvasWidth, canvasHeight);
    for (i in 0...howMany) {
      // create a new boid and add it to the flock
      var a = Math.random() * 2 * Math.PI,
        d = w * Math.random(),
        b = new Boid(
          20 + (canvasWidth - 20 * 2) * Math.random(),
          20 + (canvasHeight - 20 * 2) * Math.random(),
          6.0,
          Math.random() * 360
        );
      flock.boids.push(b);
    }
  }
}
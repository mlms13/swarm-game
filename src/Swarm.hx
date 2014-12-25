import boidz.Flock;
import boidz.rules.*;

class Swarm extends Flock {
  // goals that all swarms must have
  public var waypoints : boidz.rules.Waypoints;
  public var towardCenter : boidz.rules.SteerTowardCenter;
  public var avoidCollisions: boidz.rules.AvoidCollisions;

  // TODO: add other properties of the swarm that can be upgraded

  // initialize with basic flock rules
  public function new() {
    super();

    // set up the initial rules
    waypoints = new Waypoints(this, 30);
    towardCenter = new SteerTowardCenter(this, 10);
    avoidCollisions = new boidz.rules.AvoidCollisions(this, 30.0);

    this.addRule(avoidCollisions);
    this.addRule(towardCenter);
    this.addRule(waypoints);
  }
}
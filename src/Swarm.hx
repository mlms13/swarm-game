import boidz.Flock;
import boidz.rules.*;

class Swarm extends Flock {
  // goals that all swarms must have
  public var waypoints : boidz.rules.Waypoints;
  public var towardCenter : boidz.rules.SteerTowardCenter;
  public var avoidCollisions: boidz.rules.AvoidCollisions;
  public var neighbors: boidz.rules.CollectNeighbors;

  // TODO: add other properties of the swarm that can be upgraded
  public var attack : Float;
  public var defense : Float;
  public var attackBonus : Float;
  public var defenseBonus : Float;

  // initialize with basic flock rules
  public function new(?attack = 10.0, ?defense = 10.0) {
    super();

    this.attack = attack;
    this.defense = defense;

    this.attackBonus = 0;
    this.defenseBonus = 0;

    // set up the initial rules
    waypoints = new Waypoints(this, 30);
    towardCenter = new SteerTowardCenter(this, 10);
    neighbors = new boidz.rules.CollectNeighbors(this, 20.0);
    avoidCollisions = new boidz.rules.AvoidCollisions();

    this.addRule(neighbors);
    this.addRule(avoidCollisions);
    this.addRule(towardCenter);
    this.addRule(waypoints);
  }
}
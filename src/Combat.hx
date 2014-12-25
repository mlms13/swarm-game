import boidz.Boid;
import boidz.IFlockRule;

class Combat implements IFlockRule {
  @:isVar public var radius(get, set) : Float;
  public var enemySwarms : Array<Swarm>;
  public var enabled = true;

  var squareRadius : Float;

  public function new(enemies : Array<Swarm>, ?radius : Float = 5) {
    enemySwarms = enemies;
    this.radius = radius;
  }

  public function before() return true;

  public function modify (boid : Boid):Void {
    var dx = 0.0,
        dy = 0.0;

    for (swarm in enemySwarms) {
      for (enemy in swarm.boids) {
        dx = boid.x - enemy.x;
        dy = boid.y - enemy.y;

        // if enemy is within some radius of boid
        // attaaaaack!
        if ((dx * dx + dy * dy) <= squareRadius) {
          // you dead
          if (Math.random() > .5) {
            // delete enemy from swarm
            swarm.boids.remove(enemy);
          }
        }
      }
    }
  }

  function get_radius() return radius;

  function set_radius(r : Float) {
    radius = r;
    squareRadius = r * r;
    return r;
  }
}
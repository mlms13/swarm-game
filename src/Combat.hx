import boidz.Boid;
import boidz.IFlockRule;
import boidz.rules.NeighborData;

class Combat implements IFlockRule<NeighborData> {
  @:isVar public var radius(get, set) : Float;
  public var enemySwarms : Array<Swarm>;
  public var mySwarm : Swarm;
  public var enabled = true;
  public var kills : Array<{ x : Float, y : Float}>;

  var squareRadius : Float;

  public function new(mySwarm: Swarm, enemies : Array<Swarm>, ?radius : Float = 5) {
    enemySwarms = enemies;
    this.mySwarm = mySwarm;
    this.radius = radius;
    this.kills = [];
  }

  public function before() return true;

  public function modify (boid : Boid<NeighborData>):Void {
    var dx = 0.0,
        dy = 0.0,
        totalAttack = 0.0,
        totalDefense = 0.0;

    for (swarm in enemySwarms) {
      for (enemy in swarm.boids) {
        var enemy : Boid<NeighborData> = cast enemy;
        dx = boid.x - enemy.x;
        dy = boid.y - enemy.y;

        // if enemy is within some radius of boid
        // attaaaaack!
        if ((dx * dx + dy * dy) <= squareRadius) {
          totalAttack = mySwarm.attack + (boid.data.neighbors.length * mySwarm.attackBonus);
          totalDefense = swarm.defense + (enemy.data.neighbors.length * swarm.defenseBonus);
          // enemy dead
          if (totalAttack / (totalAttack + totalDefense) > Math.random()) {
            swarm.boids.remove(enemy);
            kills.push({ x : enemy.x, y : enemy.y });
          }

          totalAttack = swarm.attack + (enemy.data.neighbors.length * swarm.attackBonus);
          totalDefense = mySwarm.defense + (boid.data.neighbors.length * mySwarm.defenseBonus);
          // you dead
          if (totalAttack / (totalAttack + totalDefense) > Math.random()) {
            mySwarm.boids.remove(boid);
            kills.push({ x : boid.x, y : boid.y });
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
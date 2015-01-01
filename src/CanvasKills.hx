import boidz.render.canvas.CanvasRender;
import boidz.IRenderable;
import thx.color.HSL;

class CanvasKills implements IRenderable<CanvasRender> {
  public var enabled : Bool = true;
  var combats : Array<Combat>;
  var trail : Int;
  var trails : Array<Array<{ x : Float, y : Float, c : HSL, r : Float }>>;
  var counter = 0;

  public function new(combats : Array<Combat>, trail = 400) {
    this.combats = combats;
    this.trails = [];
    this.trail = trail;
  }

  public function render(render : CanvasRender) {
    var ctx = render.ctx;

    for(combat in combats) {
      var t = [];
      for(kill in combat.kills) {
        t.push({
          x : kill.x,
          y : kill.y,
          c : HSL.create(
                Math.random() * 30 - 15,
                Math.random() * 0.5 + 0.5,
                Math.random() * 0.5 + 0.3),
          r : Math.random() * 3.2
        });
      }
      trails.unshift(t);
      combat.kills = [];
    }

    var t = 0;
    for(trail in trails) {
      for(item in trail) {
        ctx.beginPath();
        ctx.fillStyle = item.c.withAlpha((1-t/trails.length)).toCSS3();
        ctx.arc(item.x, item.y, item.r, 0, 2 * Math.PI, false);
        item.r = item.r * (t < 50 ? 1.03 : 0.99);
        ctx.fill();
      }
      t++;
    }

    trails = trails.slice(0, trail);

    counter++;
  }
}
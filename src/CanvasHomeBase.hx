import boidz.render.canvas.CanvasRender;
import boidz.IRenderable;
import thx.color.RGB;

class CanvasHomeBase implements IRenderable<CanvasRender> {
  public var enabled : Bool = true;
  var homeX : Int;
  var homeY : Int;
  var playerColor : thx.color.RGB;

  public function new(home : HomeBase, color : thx.color.RGB) {
    homeX = home.x;
    homeY = home.y;
    playerColor = color;
  }

  public function render(render : CanvasRender) {
    var ctx = render.ctx;

    // draw the base
    ctx.beginPath();
    ctx.fillStyle = playerColor.toString();
    ctx.fillRect(homeX - 10, homeY - 10, 20, 20);
    ctx.fill();
  }
}
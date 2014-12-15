import boidz.Display;
import boidz.render.canvas.*;
import js.Browser;
import thx.core.Timer;

class Main {
  public static var stageWidth = 800;
  public static var stageHeight = 600;
  public static var players : Array<Player>;

  public static function main() {
    var canvas = getCanvas(),
        render = new CanvasRender(canvas),
        display = new Display(render),
        players = [];

    players.push(new Player(0x00aadd, stageWidth, stageHeight));
    players.push(new Player(0xffbb00, stageWidth, stageHeight));

    for (player in players) {
      player.addFlock(200);

      for (flock in player.flocks) {
        display.addRenderable(new CanvasFlock(flock, player.color));
      }
    }

    // handle drawing
    var renderings = [],
        residue = 0.0,
        step    = 50;

    thx.core.Timer.frame(function(delta) {
      delta += residue;
      while(delta - step >= 0) {

        var time = Timer.time();
        for (player in players) {
          for (flock in player.flocks) {
            flock.update();
          }
        }

        delta -= step;
      }
      residue = delta;
      var before = Timer.time();
      display.render();
      renderings.splice(1, 10);
      renderings.push(Timer.time() - before);
    });
  }

  static function getCanvas() {
    var canvas = Browser.document.createCanvasElement();
    canvas.width = stageWidth;
    canvas.height = stageHeight;
    Browser.document.body.appendChild(canvas);
    return canvas;
  }
}

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

    players.push(new Player("#00aadd", stageWidth, stageHeight));
    players.push(new Player("#ffbb00", stageWidth, stageHeight));

    players[0].setHome(50, 50);
    players[1].setHome(stageWidth - 50, stageHeight - 50);

    for (player in players) {
      player.addFlock(200);
      display.addRenderable(new CanvasHomeBase(player.home, player.color));

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

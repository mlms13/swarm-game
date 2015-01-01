import boidz.Display;
import boidz.render.canvas.*;
import boidz.Point;
import boidz.rules.*;
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
        players = [],
        boundaries = new RespectBoundaries(0, stageWidth, 0, stageHeight, 20, 25),
        canvasBoundaries = new CanvasBoundaries(boundaries);

    players.push(new Player("#00aadd", stageWidth, stageHeight));
    players.push(new Player("#ffbb00", stageWidth, stageHeight));

    // set friendly home bases for both players
    players[0].setHome(50, 50);
    players[1].setHome(stageWidth - 50, stageHeight - 50);

    var combats = [];
    display.addRenderable(new CanvasKills(combats));

    for (player in players) {
      player.addFlock(200);
      display.addRenderable(new CanvasHomeBase(player.home, player.color));

      for (swarm in player.swarms) {
        swarm.addRule(boundaries);
        display.addRenderable(new CanvasFlock(swarm, player.color));
      }
    }

    // create combat rule for both players
    // FIXME super messy code
    for (swarm in players[0].swarms) {
      var combat = new Combat(swarm, players[1].swarms);
      combats.push(combat);
      swarm.addRule(combat);
      swarm.attack = 3;
      swarm.defense = 3;
    }
    for (swarm in players[1].swarms) {
      var combat = new Combat(swarm, players[0].swarms);
      combats.push(combat);
      swarm.addRule(combat);
      swarm.attack = 1;
      swarm.defense = 6;
    }

    // set swarm path for each player
    // TODO: eventually this will be defined by the user
    players[0].setSwarmPath(
        players[0].swarms[0],
        [
          {x: 50, y: 50},
          {x: stageWidth - 50, y: stageHeight - 50},
          {x: 50, y: 50}
        ]
    );

    players[1].setSwarmPath(
        players[1].swarms[0],
        [
          {x: stageWidth - 50, y: stageHeight - 50},
          {x: 50, y: 50},
          {x: stageWidth - 50, y: stageHeight - 50}
        ]
    );

    display.addRenderable(canvasBoundaries);

    // handle drawing
    var renderings = [],
        residue = 0.0,
        step    = 50;

    thx.core.Timer.frame(function(delta) {
      delta += residue;
      while(delta - step >= 0) {

        var time = Timer.time();
        for (player in players) {
          for (swarm in player.swarms) {
            swarm.update();
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

    // set up ui for adjusting swarm properties
    var ui = new sui.Sui();
    for (i in 0...players.length) {
      var folder = ui.folder("Player " + (i + 1));
      for (swarm in players[i].swarms) {
        folder.float("Attack", swarm.attack, {
          min: 1,
          max: 20
        }, function (v) {
          swarm.attack = v;
        });
        folder.float("Defense", swarm.defense, {
          min: 1,
          max: 20
        }, function (v) {
          swarm.defense = v;
        });
        folder.float("Attack Bonus", swarm.attackBonus, {
          min: 0,
          max: 5
        }, function (v) {
          swarm.attackBonus = v;
        });
        folder.float("Defense Bonus", swarm.defenseBonus, {
          min: 0,
          max: 5
        }, function (v) {
          swarm.defenseBonus = v;
        });
      }
    }
    ui.attach();
  }

  static function getCanvas() {
    var canvas = Browser.document.createCanvasElement();
    canvas.width = stageWidth;
    canvas.height = stageHeight;
    Browser.document.body.appendChild(canvas);
    return canvas;
  }
}

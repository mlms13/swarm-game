# Swarm Game

Swarm Game is a competitive flocking simulation. Someday it might grow up to be a game, where you make decisions and those decisions have consequences. There may even be winning!

## Building and Running

You've probably already installed Haxe and Haxelib, because you are a champion. Next up, you'll need a fresh copy of the open source [Boidz](https://github.com/mlms13/boidz) library, and you'll need to tell Haxelib to use boidz from git.

    # assuming you are starting in swarm-game folder...
    cd ..
    git clone https://github.com/mlms13/boidz.git
    haxelib dev boidz ./boidz/src/

Then, change back into the swarm-game folder and install the rest of the dependencies:

    cd ./swarm-game
    haxelib install all

And finally, build and run the simulation:

    haxe build.hxml
    xdg-open bin/index.html # or just `open` on Mac

## Success and Victory

You earned it.

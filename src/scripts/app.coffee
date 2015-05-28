View = require 'view/MainView'
World = require 'model/World'
Orb = require 'model/Orb'
Controller = require 'ViewController'


world = new World()

world.addOrb \
  (new Orb {position: {x: x * 4, y: y * 4, z: z * 4}}) \
  for x in [-1..1] \
  for y in [-1..1] \
  for z in [-1..1]

view = new View {parentElement: document.body}
controller = new Controller world, view

console.log view.objects
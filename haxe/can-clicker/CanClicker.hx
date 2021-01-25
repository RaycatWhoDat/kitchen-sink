package;

class BeerCan {
  var object: h2d.Object;
  var tile: h2d.Tile;
  var interaction: h2d.Interactive;
  var drawable: h2d.Bitmap;

  public function new(s2d: h2d.Scene, x: Float, y: Float) {
    object = new h2d.Object(s2d);
    object.x = Std.int(s2d.width / 2);
    object.y = Std.int(s2d.height / 2);
    object.scaleX = 0.5;
    object.scaleY = 0.5;

    tile = hxd.Res.beerCan.toTile().center();

    drawable = new h2d.Bitmap(tile, object);
    
    interaction = new h2d.Interactive(Std.int(tile.width / 2), Std.int(tile.height / 2), drawable);

    interaction.onOver = function (event: hxd.Event) {
      trace("Hover!");
    }
    
    interaction.onClick = function (event: hxd.Event) {
      trace("Clicked!");
    }
  }
}


class CanClicker extends hxd.App {
  override function init() {
    new BeerCan(s2d, 0, 0);
  }
  
  static function main() {
    hxd.Res.initEmbed();
    new CanClicker();
  }
}

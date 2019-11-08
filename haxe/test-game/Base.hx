class Base {
  static var player: Player = new Player(0, 0, 64, [1, 0, 0]);
  
  public static function load(args: lua.Table<Dynamic, Dynamic>) {
    
  }

  public static function keypressed(key: String, scanCode: String, isRepeat: Bool) {
    if (key == "q") Le.quit();
  }
  
  public static function update(dt: Float) {
    player.update(dt);
  }

  public static function draw() {
    player.draw();
  }
}
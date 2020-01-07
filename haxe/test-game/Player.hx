class Player {
  public var x:Float = 0;
  public var y:Float = 0;
  public var width:Int = 0;
  public var color:Array<Float> = [0, 0, 0];

  public function new(x:Float, y:Float, width:Int, ?color:Array<Float>) {
    this.x = x;
    this.y = y;
    this.width = width;
    if (color != null)
      this.color = color;
  }

  public function update(dt:Float) {
    if (Lk.isDown("left"))
      this.x -= 1;
    if (Lk.isDown("right"))
      this.x += 1;
    if (Lk.isDown("up"))
      this.y -= 1;
    if (Lk.isDown("down"))
      this.y += 1;
  }

  public function draw() {
    Lg.setColor(this.color[0], this.color[1], this.color[2], 0.3);
    Lg.rectangle(DrawMode.Fill, this.x, this.y, this.width, this.width);
    Lg.setColor(this.color[0], this.color[1], this.color[2], 1);
    Lg.rectangle(DrawMode.Line, this.x, this.y, this.width, this.width);
    Lg.setColor(1, 1, 1, 1);
  }
}

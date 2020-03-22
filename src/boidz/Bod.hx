package boidz;

//import thx.unit.angle.Degree;

class Bod implements boidz.IBoid{
    public var x : Float;
  public var y : Float;
  public var v : Float;
  public var d : Degree;
   public var image:js.html.Image;
   public var state:Int;

    public function new(x : Float, y : Float, ?v = 0.0, ?d : Degree) {
    if(null == d)
      d = 0.0;
    this.x = x;
    this.y = y;
    this.v = v;
    this.d = d;

    }

}
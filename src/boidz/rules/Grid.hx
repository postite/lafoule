package boidz.rules;
import boidz.IFlockRule;

class GridTri implements boidz.IFlockRule  {

    public var enabled : Bool;
    var goal:{x:Float,y:Float};
    var grid:Grid;
  public function new(){
      grid = new Grid(10,13);
  }
  public function before(){
      goal={};
      goal.x = grid.next().x;
      return true;

  }

  public function modify(b : Boid) {
      if(b.x <goal.x)

  }
}
class Grid {
    var numcol:Int;
    var numrow:Int;
    var cells:Array<Cell>;
    var iter:Iterator<Cell>;
    public public function new( numcol,numrow,?w,?h)
    {
       this.numcol=numcol;
       this.numrow=numrow;
       construct();
    }
    public function next():Cell{
        if (iter.hasNext())
        return iter.next();
        return null;
    }
    public function construct()
    {
        cells=[];
        for( i in 0...numcol){
      // for(var i = 0; i < 400; i += 50) 
       for( j in 0...numrow){
           var cell = new Cell(i*50, j*50, 50, 50); 
           cells.push (cell);
       }
        }
        iter=cells.iterator();

    }
    
}
class Cell{
    public var x:Int;
    public var y:Int;
    public var w:Int;
    public var h:Int;
    public function new(x,y,w,h)
    {
         this.x=x;
         this.y=y;
         this.w=w;
         this.h=h;
    }

}
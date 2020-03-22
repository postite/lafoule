package boidz.rules;
import postite.geom.CoolPoint.Rect;
import murmur.scenarios.Murmurator;
import boidz.IFlockRule;
//import thx.unit.angle.Degree;
import boidz.render.canvas.ZoneBounds;
import boidz.util.Steer;
import postite.geom.PolyGon;
using postite.geom.GeomFilters;


class SteerTowardPoly implements IFlockRule {
  public var flock : Flock;
  public var goal : SteerTowardGoal;
  public var enabled : Bool = true;
  public var maxSteer : Float;
  var bound:Rect;
  var centroid:Point;
  var zone:PolyGon;
  var map:Map<IBoid,Point>= new Map();
 public var points:Array<Point>=[];
  // move 1% toward the perceived center of all other boids
  public function new(flock:Flock,zone:PolyGon, ?maxSteer : Degree) {
    if(null == maxSteer)
      maxSteer = 10;
    this.flock = flock;
    this.zone=zone;
     bound=zone.boundingBox();
     centroid= zone.centroid();
    doZone();


    //this.goal = new SteerTowardGoal(flock.x, flock.y, maxSteer);
  }

  public function doZone(){
for (b in flock.boids){
var p:Point={
        x:bound.x+(Math.random()*(bound.width)),
        y:bound.y+(Math.random()*(bound.height))
        }
      if( zone.contains(p)){
      points.push(p);
      }else{
        p=GeomFilters.randomInCircle(
          Math.min(bound.width,bound.height)/2,//rayon
          centroid//centre
        );
        points.push(p);
      }
      map.set(b,p);
    }
  }

  public function before() {
    //goal.x = zone.minx+(Math.random()*zone.maxx);

    //goal.y = zone.miny+(Math.random()*zone.maxy);
    return true;
  }
  var done=new Map<IBoid,Bool>();
  var count=0;
  var go=true;
  var run=true;
  var no=false;


   public function modify(b:IBoid){
    if(no || map.get(b)==null)return ;
    if( count> 10) doit();
    if(go)
    b.d += Steer.toward(b, map.get(b), maxSteer);
  
  return;
   
    //trace( "yo" +b.x);
    if(!done.get(b)){
    if(
      Math.round(b.y)==Math.round(map.get(b).y) 
      && Math.round(b.x)==Math.round(map.get(b).x) 
      ){
      done.set(b,true);
      count++;
     // gof(b);
      b.v=Murmurator.lowSpeed;
      
       // b.d += Steer.away(b, cast this, maxSteer);
    }}else{


    
      
        //b.v=2;
      //b.d+=3;
      
       // b.d+= Steer.away(b, goal, 1);
        // goal.modify(b);
    }
    
    }

    function doit(){
      no=true;
      // DoneSignal.getInstance().dispatch();
    }

    function gof(b:boidz.IBoid){
     // go=false;
      
      var t=haxe.Timer.delay(function(){
        
        //trace( "after delay");
        //go=true;
        run=false;
      },3000);
    }
    //goal.modify(b);
}
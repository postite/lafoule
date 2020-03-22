package boidz.rules;

import postite.geom.CoolPoint.Point;
import postite.geom.CoolPoint.Points;
import postite.geom.GeomFilters;
import postite.geom.PolyGon;
import boidz.IFlockRule;
//import thx.unit.angle.Degree;
import boidz.render.canvas.ZoneBounds;
import boidz.util.Steer;

class IGloz implements IFlockRule {
	
	public var flock:Flock;
	public var goal:SteerTowardGoal;
	public var enabled:Bool = true;
	public var maxSteer:Float;

	var zone:ZoneBounds;
	var map:Map<IBoid, Point> = new Map();
	static var poly:PolyGon;
	var centroid:Point;

	public var points:Array<Point> = [];
	public static function kill(){
		poly=[];
	}
	// move 1% toward the perceived center of all other boids
	public function new(flock:Flock, _poly:postite.geom.PolyGon, ?maxSteer:Degree) {
		if( _poly==null) throw "no zone";

    	if (null == maxSteer)
			maxSteer = 10;
		this.flock = flock;
		//trace(_poly);

		poly =  _poly;
    	centroid = GeomFilters.centroid(poly);
		// for (b in flock.boids){
		//   var p:Point={x:zone.minx+(Math.random()*zone.maxx),y:zone.miny+(Math.random()*zone.maxy)}
		//   points.push(p);
		//   map.set(b,p);
		// }

		this.goal = new SteerTowardGoal(centroid.x, centroid.y);
    	goal.enabled=true;
  }

	public function before() {
		// goal.x = zone.minx+(Math.random()*zone.maxx);

		// goal.y = zone.miny+(Math.random()*zone.maxy);
		return true;
	}

	var done = new Map<IBoid, Bool>();
	var count = 0;
	var go = true;
	var run = true;
	var no = false;
  public function dispose(){
    this.enabled=false;
  }
	public function modify(b:IBoid) {
		if (poly.length==0)return;
    	goal.modify(b);
		if (poly.contains(new Point(b.x, b.y))) {
		//	trace("contains");
			// cast( b,Boid).type=Point("red");
			b.d += Steer.away(b, centroid, maxSteer);
			
			//b.x += 100;
		}

		return;

		if (no || map.get(b) == null)
			return;
		if (count > 10)
			doit();

		if (go)
			b.d += Steer.toward(b, map.get(b), maxSteer);

		// trace( "yo" +b.x);
		if (!done.get(b)) {
			if (Math.round(b.y) == Math.round(map.get(b).y) && Math.round(b.x) == Math.round(map.get(b).x)) {
				done.set(b, true);
				count++;
				// gof(b);
				b.v = 0;

				// b.d += Steer.away(b, cast this, maxSteer);
			}
		} else {
			// b.v=2;
			// b.d+=3;

			// b.d+= Steer.away(b, goal, 1);
			// goal.modify(b);
		}
	}

	function doit() {
		no = true;
		// DoneSignal.getInstance().dispatch();
	}

	function gof(b:boidz.IBoid) {
		// go=false;

		var t = haxe.Timer.delay(function() {
			// trace( "after delay");
			// go=true;
			run = false;
		}, 3000);
	}

	// goal.modify(b);
}

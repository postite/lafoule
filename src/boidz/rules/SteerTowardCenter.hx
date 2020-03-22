package boidz.rules;

import boidz.IFlockRule;
//import thx.unit.angle.Degree;

class SteerTowardCenter implements IFlockRule {
  public var flock : boidz.Foule;
  public var goal : SteerTowardGoal;
  public var enabled : Bool = true;

  // move 1% toward the perceived center of all other boids
  public function new(flock : boidz.Foule, ?maxSteer : Degree) {
    if(null == maxSteer)
      maxSteer = 10;
    this.flock = flock;
    this.goal = new SteerTowardGoal(flock.x, flock.y, maxSteer);
  }

  public function before() {
    goal.x = flock.x;
    goal.y = flock.y;
    return true;
  }

  public function modify(b:IBoid)
    goal.modify(b);
}

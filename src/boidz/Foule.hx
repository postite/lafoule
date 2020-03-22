package boidz;

import boidz.*;
interface Foule {
  public var boids(default, null) : Array<IBoid>;
  public var rules(default, null) : Array<IFlockRule>;
  public var x : Float;
  public var y : Float;
  public var v : Float;
  public var d : Degree;
  public var step : Float;

  public function addRule(rule:IFlockRule):Void;
  public function update():Void;

}


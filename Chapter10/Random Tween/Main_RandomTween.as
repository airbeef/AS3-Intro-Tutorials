﻿package {  import flash.display.MovieClip;  import flash.events.Event;  import fl.transitions.Tween;  import fl.transitions.TweenEvent;  import fl.transitions.easing.*;  public class Main_RandomTween extends MovieClip  {    //Declare variables    private var _tweenX:Tween;    private var _tweenY:Tween;    private var _randomX:uint;    private var _randomY:uint;    public function Main_RandomTween()    {      //Initialize dynamic instance variables in the robot      //object to help calculate the robot's velocity      robot.vx = 0;      robot.vy = 0;      robot.oldX = 0;      robot.oldY = 0;			      //Select a random stage position      _randomX = Math.ceil(Math.random() * 550);      _randomY = Math.ceil(Math.random() * 400);      //Create Tween objects for the x and y axes      _tweenX = new Tween(robot, "x", Regular.easeInOut, robot.x, _randomX, 60, false);      _tweenY = new Tween(robot, "y", Regular.easeInOut, robot.y, _randomY, 60, false);      //Add listeners that are triggered when the animation finishes      _tweenX.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishX);      _tweenY.addEventListener(TweenEvent.MOTION_FINISH, onMotionFinishY);      //Add an ENTER_FRAME listner to help calculate the object's velocity      addEventListener(Event.ENTER_FRAME, onEnterFrame);    }    private function onMotionFinishX(event:Event)    {      var tweenObject:Tween = event.target as Tween;      //Calculate new start and finish positions      tweenObject.begin = robot.x;      tweenObject.finish = Math.ceil(Math.random() * 550);	  //tweenObject.finish = mouseX;      //Start the Tween object playing again      tweenObject.start();    }    private function onMotionFinishY(event:Event)    {      var tweenObject:Tween = event.target as Tween;      tweenObject.begin = robot.y;      tweenObject.finish = Math.ceil(Math.random() * 400);	  //tweenObject.finish = mouseY;      tweenObject.start();    }    private function onEnterFrame(event:Event)    {      robot.vx = robot.x - robot.oldX;      robot.vy = robot.y - robot.oldY;      robot.oldX = robot.x;      robot.oldY = robot.y;      //Display robot's velocity in a dynamic text field      display.text = String("VX: " + robot.vx + "\n" + "VY: " + robot.vy);    }  }}
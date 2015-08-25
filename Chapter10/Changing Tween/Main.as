﻿package {	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import fl.transitions.Tween;	import fl.transitions.TweenEvent;	import fl.transitions.easing.*;	public class Main extends MovieClip	{		//Declare variables		private var _tweenX:Tween;		private var _tweenY:Tween;		public function Main()		{			init();		}		private function init():void		{			//Create Tween objects for the x and y axes			_tweenX = new Tween(robot, "x", Regular.easeInOut, robot.x, mouseX, 60, false);			//_tweenX.looping = true;			_tweenY = new Tween(robot, "y", Regular.easeInOut, robot.y, mouseY, 60, false);			//_tweenY.looping = true;			//Add listeners that are triggered when the animation finishes			//_tweenX.addEventListener(TweenEvent.MOTION_CHANGE, onMotionChangeX);			//_tweenY.addEventListener(TweenEvent.MOTION_CHANGE, onMotionChangeY);						//Add an ENTER_FRAME listner to help calculate the object's velocity			addEventListener(Event.ENTER_FRAME, onEnterFrame);			//addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);		}		private function onMotionChangeX(event:Event)		{			var tweenObject:Tween = event.target as Tween;			//tweenObject.stop();			tweenObject.begin = robot.x;			tweenObject.finish = mouseX;			//tweenObject.start();		}		private function onMotionChangeY(event:Event)		{			var tweenObject:Tween = event.target as Tween;			//tweenObject.stop();			tweenObject.begin = robot.y;			tweenObject.finish = mouseY;			//tweenObject.start();		}		private function onEnterFrame(event:Event)		{			var dx:Number = mouseX - robot.x;			var dy:Number = mouseY - robot.y;			var distance:Number = Math.sqrt(dx * dx + dy * dy);			//_tweenX.duration = Math.abs(distance);			//_tweenY.duration = Math.abs(distance);			_tweenX.continueTo(mouseX, distance*0.1);			_tweenY.continueTo(mouseY, distance*0.1);			/*if(mouseX == robot.x)			{				_tweenX.stop();			}			if(mouseY == robot.y)			{				_tweenY.stop();			}*/		}	}}
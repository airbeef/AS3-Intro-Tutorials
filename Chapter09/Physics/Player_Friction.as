package 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class Player_Friction extends MovieClip
	{
		private var _vx:Number;
		private var _vy:Number;
		private var _accelerationX:Number;
		private var _accelerationY:Number;
		private var _speedLimit:Number;
		private var _friction:Number;

		public function Player_Friction()
		{
			_vx *= _friction;
			_vy *= _friction;
			_accelerationX = 0;
			_accelerationY = 0;
			_speedLimit = 5;
			_friction = 0.96;
			
			//Stop animation on the object
			this.ears.stop();

			//Add stage event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_accelerationX = -0.2;
			}
			if (event.keyCode == Keyboard.RIGHT)
			{
				_accelerationX = 0.2;
			}
			if (event.keyCode == Keyboard.UP)
			{
				_accelerationY = -0.2;
			}
			if (event.keyCode == Keyboard.DOWN)
			{
				_accelerationY = 0.2;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.RIGHT)
			{
				_accelerationX = 0;
			}
			if (event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)
			{
				_accelerationY = 0;
			}
		}
		private function onEnterFrame(event:Event):void
		{
			//Initialize local variables
			var playerHalfWidth:uint = width / 2;
			var playerHalfHeight:uint = height / 2;

			//Apply Acceleration
			_vx += _accelerationX;
			if (_vx > _speedLimit)
			{
				_vx = _speedLimit;
			}
			if (_vx < -_speedLimit)
			{
				_vx = -_speedLimit;
			}
			
			_vy += _accelerationY;
			if (_vy > _speedLimit)
			{
				_vy = _speedLimit;
			}
			if (_vy < -_speedLimit)
			{
				_vy = -_speedLimit;
			}
			
			//Apply Friction
			_vx *= _friction;
			_vy *= _friction;
			
			//Force object to stop at low speeds
			if (Math.abs(_vx) < 0.1)
			{
				_vx = 0;
			}
			if (Math.abs(_vy) < 0.1)
			{
				_vy = 0;
			}
			
			//Move the player
			x+=_vx;
			y+=_vy;
			
			//Stop player at stage edges
			if (x + playerHalfWidth > stage.stageWidth)
			{
				_vx = 0;
				_vy = 0;
				x = stage.stageWidth - playerHalfWidth;
			}
			else if (x - playerHalfWidth < 0)
			{
				_vx = 0;
				_vy = 0;
				x = 0 + playerHalfWidth;
			}
			if (y - playerHalfHeight < 0)
			{
				_vx = 0;
				_vy = 0;
				y = 0 + playerHalfHeight;
			}
			else if (y + playerHalfHeight > stage.stageHeight)
			{
				_vx = 0;
				_vy = 0;
				y = stage.stageHeight - playerHalfHeight;
			}
		}
	}
}
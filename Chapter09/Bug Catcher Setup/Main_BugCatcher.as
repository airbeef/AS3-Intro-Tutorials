package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Main_BugCatcher extends MovieClip
	{
		//Private variables for collection jar boxes and Mouse
			private var _collectionJar:Array;
			private var _mouseFound:Boolean;
			
		public function Main_BugCatcher()
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			frog.addEventListener(Event.ENTER_FRAME, onFrogLook);
			
			//Shifts cats in between layers so it's infront of frog instance, but behind water instance
			setChildIndex(player, numChildren - 1);
			setChildIndex(water, numChildren - 1);
			
			//Loop to name what instances are on screen
			for (var i:int = 0; i< numChildren; i++)
				{
					trace(i + "." + getChildAt(i).name);
				}
			
			//Bug programming
			//fly
			fly.vx = 0;
			fly.vy = 0;
			fly.addEventListener(Event.ENTER_FRAME, onBugMove);
			fly.addEventListener(Event.ENTER_FRAME, onCollisionWithPlayer);
			
			//bee
			bee.vx = 0;
			bee.vy = 0;
			bee.addEventListener(Event.ENTER_FRAME, onBugMove);
			bee.addEventListener(Event.ENTER_FRAME, onCollisionWithPlayer);
			
			//fly
			mosquito.vx = 0;
			mosquito.vy = 0;
			mosquito.addEventListener(Event.ENTER_FRAME, onBugMove);
			mosquito.addEventListener(Event.ENTER_FRAME, onCollisionWithPlayer);
			
			//Mouse
			mouse.addEventListener(Event.ENTER_FRAME, onCollisionWithPlayer);
						
			//Inititializing Arrays, mouse variable and dynamic test
			_collectionJar = new Array();
			_collectionJar = [];
			_mouseFound = false;
			instructions.text = "Catch dem bugs, Foo-";
		}
		
		//handles player/platform collision
			private function onEnterFrame(event:Event):void
			{
				for(var i:int = 0; i<=4; i++)
				{
					Collision.playerAndPlatform(player, this["platform" +i], 0.2, 0);
					trace("platform" + i);
				}
			}
	
				
			private function onFrogLook(event:Event):void
			{
			//Frog's right eye: local to global 
			var frogsRightEye:Point = new Point (frog.rightEye.x, frog.rightEye.y);
			var frogsRightEye_X:Number = frog.localToGlobal(frogsRightEye).x;
			var frogsRightEye_Y:Number = frog.localToGlobal(frogsRightEye).y;
			
			//Frog's left eye: local to global 
			var frogsLeftEye:Point = new Point (frog.leftEye.x, frog.leftEye.y);
			var frogsLeftEye_X:Number = frog.localToGlobal(frogsLeftEye).x;
			var frogsLeftEye_Y:Number = frog.localToGlobal(frogsLeftEye).y;
			
			//Frog Eye Rotation
			frog.rightEye.rotation = 
				Math.atan2(frogsRightEye_Y - player.y, frogsRightEye_X - player.x)*(180/Math.PI);
			frog.leftEye.rotation = 
				Math.atan2(frogsLeftEye_Y - player.y, frogsLeftEye_X - player.x)*(180/Math.PI);
				
			//How many kids on stage?
			//trace(getChildAt(4));
			}
			
			private function onBugMove(event:Event):void
			{
				//Create a variable to store areference to the bug object
				var bug:MovieClip = event.target as MovieClip;
				
				//Add Brownian movtion to the velocities
				bug.vx += (Math.random() * 0.2 - 0.1) * 15;
				bug.vy += (Math.random() * 0.2 - 0.1) * 15;
				
				//Add friction
				bug.vx *= 0.95;
				bug.vy *= 0.95;
				
				//movethebug
				bug.x +=bug.vx;
				bug.y +=bug.vy;
								
				//stage Boundaries
				if (bug.x > stage.stageWidth)
				{
					bug.x = stage.stageWidth;
					//Reverse (bounce) when it hits the stage edges
					bug.vx *= -1;
				}
				
				if (bug.x < 0)
				{
					bug.x = 0;
					bug.vx *= -1;
				}
				
				//keep the bug above water
				if(bug.y > stage.stageHeight - 35)
				{
					bug.y = stage.stageHeight - 35;
					bug.vy *= -1;
				}
				
				if (bug.y < 0)
				{
					bug.y = 0;
					bug.vy *= -1;
				}
				
				//Apply collision with platform
				for (var i:int = 0; i < 5; i++)
				{
					Collision.playerAndPlatform(bug, this["platform" + i], 0, 0);
					//this["platform" + i], 0.2, 0);
				}
								
				//Bug/Frog Avoidance AI
				if ((Math.abs(bug.x - frog.x) < 50))
				{
					if (Math.abs(bug.y- frog.y) < 50)
					{
						bug.x += -bug.vx;
						bug.y += -bug.vy;
						bug.vx *= -1;
						bug.vy *= -1;
						trace(bug.name + ": Frog!");
					}
				}
				
				//Bug Panics when player moves
				if ((Math.abs(bug.x - frog.x)< 60))
				{
					if((Math.abs(bug.y - frog.y)< 60))
					{
						bug.vy += player.vy + ((Math.random() * 0.2 - 0.1) * 30);
						bug.vx += player.vx + ((Math.random() * 0.2 - 0.1) * 30);
						trace(bug.name + ": Cat!");
						
						if ((Math.abs(player.vy) < 1) && (Math.abs(player.vx) < 1))
						{
							// if Player is standing still
							bug.y += -bug.vy;
							bug.x += -bug.vx;
							bug.vy *= -1;
							bug.vx *= -1;
						}
					}
				}
			}
			
					//1.25.11 Collision with Mouse and Bug instances
				private function onCollisionWithPlayer(event:Event):void
				{
					//variable for collection jar
					var collectionItem:MovieClip = event.target as MovieClip;
					
					if (_collectionJar.length < 3)
					{
						if (player.hitTestPoint(collectionItem.x, collectionItem.y, true))
						{
							this["itemBox" + _collectionJar.length].addChild(collectionItem);
							collectionItem.x = 0;
							collectionItem.y = 0;
							_collectionJar.push(collectionItem); //array push
							
							//Check for end of game
							if (_collectionJar.length == 3)
							{
								addEventListener(Event.ENTER_FRAME,onEndGame);
							}
							
							//Remove listeners of collected stuff
							if(collectionItem != mouse)
							{
								collectionItem.removeEventListener(Event.ENTER_FRAME, onBugMove);
							}
							collectionItem.removeEventListener(Event.ENTER_FRAME, onCollisionWithPlayer);
						}
					}
				}
				
			private function onEndGame(event:Event):void
			{
				instructions.text = "Show meh whatcha got!";
				
				if (player.collisionArea.hitTestObject(frog))
					{
					for (var i:int = 0; i< _collectionJar.length; i++)
					{
						if (_collectionJar[i] == mouse)
						{
							_mouseFound = true;
							break;
						}
					}
				if (_mouseFound)
				{
					instructions.text = "Fuck yo mouse!";
				}
				else
				{
					instructions.text = "Dawg...yum.";
				}
				removeEventListener(Event.ENTER_FRAME, onEndGame);
			}
	/*private function onEnterFrame(event:Event):void
		{
			Collision.playerAndPlatform(player, platform0, 0.2, 0);
			Collision.playerAndPlatform(player, platform1, 0.2, 0);
			Collision.playerAndPlatform(player, platform2, 0.2, 0);
			Collision.playerAndPlatform(player, platform3, 0.2, 0);
			Collision.playerAndPlatform(player, platform4, 0.2, 0);
		*/
		}
	}
}
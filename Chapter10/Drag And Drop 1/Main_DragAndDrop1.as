package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	

	public class Main_DragAndDrop1 extends MovieClip
	{
		//Declare variables
		private var _isDragging:Boolean;
		private var _rectangle:Rectangle;

		public function Main_DragAndDrop1()
		{
			
			//Defining Rectangle variables and properties
			_rectangle = new Rectangle();
			_rectangle.width = 200;
			_rectangle.height = 200;
			_rectangle.x = 100;
			_rectangle.y = 100;
			
			//Initialize variables
			_isDragging = false;
			
			//Add event listeners
			redSquare.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			blueSquare.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private function onEnterFrame(event:Event):void
		{
			if (redSquare.hitTestObject(redTarget))
			{
				if (! _isDragging)
				{
					redSquare.x = redTarget.x;
					redSquare.y = redTarget.y;
				}
			}
			if (blueSquare.hitTestObject(blueTarget))
			{
				if (! _isDragging)
				{
					blueSquare.x = blueTarget.x;
					blueSquare.y = blueTarget.y;
				}
			}
		}
		private function onMouseUp(event:Event):void
		{
			var currentDragObject:MovieClip = event.currentTarget as MovieClip;
			currentDragObject.stopDrag();
			_isDragging = false;
			currentDragObject.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			//Find the name of the object over which the drag object is dropped
			if(currentDragObject.dropTarget != null)
			{
				trace(currentDragObject.dropTarget.parent.name);
			}
		}
		private function onMouseDown(event:Event):void
		{
			var currentDragObject:MovieClip = event.currentTarget as MovieClip;
			currentDragObject.startDrag(false, _rectangle);
			setChildIndex(currentDragObject, numChildren-1);
			_isDragging = true;
			currentDragObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	}
}
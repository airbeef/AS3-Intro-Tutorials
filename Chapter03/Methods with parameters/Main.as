﻿package {	import flash.display.MovieClip;	public class Main extends MovieClip	{		public function Main()		{			displayText("This is text from the method call");		}		function displayText(textYouWantToDisplay:String):void		{			trace(textYouWantToDisplay);		}	}}
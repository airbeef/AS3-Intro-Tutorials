﻿package {	import flash.display.MovieClip;	public class Main_ArrayBasic extends MovieClip	{		//declar array		private var _collectionJar:Array;				public function Main_ArrayBasic()		{			//Instantiate array			_collectionJar = new Array();						//Add elements to array			_collectionJar[0] = "fly";			_collectionJar[1] = "mosquito";			_collectionJar[2] = "bee";						//Trace array entire contents			trace("Entire Array: " + _collectionJar);			//Trace individual elements			trace("Element 0: " + _collectionJar[0]);			trace("Element 1: " + _collectionJar[1]);			trace("Element 2: " + _collectionJar[2]);		}	}}
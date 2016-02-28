﻿package  {
	
	import flash.display.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.events.*;	
	
	public class EditorTest extends MovieClip {
		
		private var fileLoader:URLLoader;
		
		private var parser:GMDParser;
		
		public function EditorTest() {
			fileLoader=new URLLoader();
			fileLoader.dataFormat=URLLoaderDataFormat.TEXT;
			fileLoader.addEventListener(Event.COMPLETE,stuffIt);
			fileLoader.load(new URLRequest("sce00_c000_0001_jpn.txt"));
		}
		
		private function stuffIt(e:Event):void {
			parser=new GMDParser();
			var txts:Array=fileLoader.data.split("\r\n");
			for each(var txt:String in txts) {
				//trace(txt);
				var contents:Array=parser.parseSection(txt);
				trace(contents);
			}
		}
	}
	
}
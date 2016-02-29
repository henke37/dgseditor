package  {
	
	import flash.display.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.events.*;
	
	import fl.containers.*;
	
	public class EditorTest extends MovieClip {
		
		private var fileLoader:URLLoader;
		
		private var parser:SectionParser;
		
		public var scroller_mc:ScrollPane;
				
		public function EditorTest() {
			fileLoader=new URLLoader();
			fileLoader.dataFormat=URLLoaderDataFormat.TEXT;
			fileLoader.addEventListener(Event.COMPLETE,stuffIt);
			fileLoader.load(new URLRequest("sce00_c000_0001_jpn.txt"));
		}
		
		private function stuffIt(e:Event):void {
			
			var holder:Sprite=new Sprite();
			
			
			var yPos:Number=0;
			
			var txts:Array=fileLoader.data.split("\r\n");
			for each(var txt:String in txts) {
				//trace(txt);
				parser=new SectionParser(txt);
				var contents:Array=parser.parseSection();
				var rows:Array=rowSplit(contents);
				
				for each(var row:Array in rows) {
					var editor:RowEditor=new RowEditor();
					holder.addChild(editor);
					editor.content=row;
					editor.y=yPos;
					yPos+=editor.height;
				}
				
				yPos+=2;
				var breakLine:SectionBreak=new SectionBreak();
				holder.addChild(breakLine);
				breakLine.y=yPos;
				yPos+=3;
				//trace(contents);
			}
			
			scroller_mc.source=holder;
		}
	}
	
}

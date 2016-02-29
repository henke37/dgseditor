package  {
	
	import flash.display.*;
	import flash.text.*;
	
	public class RowEditor extends Sprite {
		
		public var text_txt:TextField;
		
		public function RowEditor() {
			text_txt.autoSize=TextFieldAutoSize.LEFT;
		}
		
		public function set content(c:Array) {
			text_txt.htmlText=HTMLizer.htmlizeContent(c);
		}
	}
	
}

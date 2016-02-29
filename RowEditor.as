package  {
	
	import flash.display.*;
	import flash.text.TextField;
	
	public class RowEditor extends Sprite {
		
		public var text_txt:TextField;
		
		public function RowEditor() {
			// constructor code
		}
		
		public function set content(c:Array) {
			text_txt.htmlText=HTMLizer.htmlizeContent(c);
		}
	}
	
}

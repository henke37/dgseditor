package  {
	
	public class HTMLizer {
		
		private static const COL_GT:String="#AA0077";
		private static const COL_LT:String="#AA0077";
		private static const COL_NAME:String="#0044FF";
		private static const COL_ARG:String="#00FF44";

		public function HTMLizer() {
			// constructor code
		}
		
		private static function htmlEscape(text:String):String {
			text=text.replace("&","&amp;");
			text=text.replace("<","&lt;");
			text=text.replace(">","&gt;");
			return text;
		}
		
		private static function colorize(text:String,color:String):String {
			
			return "<font color=\""+color+"\">"+htmlEscape(text)+"</font>";
		}
		
		public static function htmlizeTag(tag:Object) {
			var o:String=colorize("<",COL_LT);
			o+=colorize(tag.name,COL_NAME);
			for each(var arg:String in tag.args) {
				o+=" "+colorize(arg,COL_ARG);
			}
			return o+colorize(">",COL_GT);
			
		}
		
		public static function htmlizeContent(content:Array) {
			var o:String="";
			for each(var elm:* in content) {
				if(elm is String) {
					o+=htmlEscape(elm);
				} else {
					o+=htmlizeTag(elm);
				}
			}
			return o;
		}

	}
	
}

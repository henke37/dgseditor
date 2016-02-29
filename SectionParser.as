package  {
	
	public class SectionParser {
		
		private static const ST_OUTSIDE:uint=0;
		private static const ST_LT:uint=1;
		private static const ST_NAME:uint=2;
		private static const ST_SP:uint=3;
		private static const ST_ARG:uint=4;
		private static const ST_GT:uint=5;
		
		
		private var chrPos:int;
		private var parseState:uint=ST_OUTSIDE;			
		
		private var rowStartPos:int=0;			
		private var tagStartPos:int;
		private var argStartPos:int;
		private var endOfLastTag:int=-1;
		
		private var contents:Array=[];
		private var tag:Object;
		
		private var txt:String;

		public function SectionParser(txt:String) {
			this.txt=txt;
		}
		
		public function parseSection():Array {
			
			var chr:String;
			
			var txtLen:int=txt.length;
			
parseLoop: for(chrPos=0;chrPos<txtLen;) {
				chr=txt.charAt(chrPos);
				
				switch(parseState) {
					case ST_OUTSIDE:
						if(chr=="<") {
							parseState=ST_LT;
							continue parseLoop;
						}
					break;
					
					case ST_LT:
						collectTextRun();
						tag={ args: [] };
						parseState=ST_NAME;
						tagStartPos=chrPos;
					break;
					
					case ST_NAME:
						if(chr==" ") {
							collectTagName();
							
							parseState=ST_SP;
							continue parseLoop;
						} else if(chr==">") {
							collectTagName();
							parseState=ST_GT;
							continue parseLoop;
						}
					break;
					
					case ST_SP:
						argStartPos=chrPos+1;
						parseState=ST_ARG;
					break;
					
					case ST_ARG:
						if(chr==" ") {
							collectArg();
							parseState=ST_SP;
							continue parseLoop;
						} else if(chr==">") {
							collectArg();
							parseState=ST_GT;
							continue parseLoop;
						}
					break;
					
					case ST_GT:
						collectTag();
						endOfLastTag=chrPos;
						parseState=ST_OUTSIDE;
					break;
					
					default:
					throw new Error("Bad parse state!");
				}
				
				//not in the for loop header, since we skip incrementing it sometimes
				chrPos++;
			}
			
			collectTextRun();
			
			return contents;
		}
		
		private function collectTextRun() {
			var start:int=endOfLastTag+1;
			var end:int=chrPos;
			if(start==end) return;
			var run:String=txt.substring(start,end);
			contents.push(run);
		}
		
		private function collectArg() {
			var start:int=argStartPos;
			var end:int=chrPos;
			if(start==end) return;
			var run:String=txt.substring(start,end);
			tag.args.push(run);
		}
		
		private function collectTag() {
			contents.push(tag);
			tag=null;
		}
		
		private function collectTagName() {
			tag.name=txt.substring(tagStartPos+1,chrPos);
		}

	}
	
}

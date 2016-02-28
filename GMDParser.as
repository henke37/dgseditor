package  {
	
	public class GMDParser {
		
		private const ST_OUTSIDE:uint=0;
		private const ST_LT:uint=1;
		private const ST_NAME:uint=2;
		private const ST_SP:uint=3;
		private const ST_ARG:uint=4;
		private const ST_GT:uint=5;
		private const ST_SL:uint=6;

		public function GMDParser() {
			// constructor code
		}
		
		public function parseSection(txt:String):Array {
			var chrPos:int;
			var chr:String;
			var txtLen:int=txt.length;
			var parseState:uint=ST_OUTSIDE;			
			
			var rowStartPos:int=0;			
			var tagStartPos:int;
			var argStartPos:int;
			var endOfLastTag:int=-1;
			
			var contents:Array=[];
			var tag:Object;
			
			function collectTextRun() {
				var start:int=endOfLastTag+1;
				var end:int=chrPos;
				if(start==end) return;
				var run:String=txt.substring(start,end);
				contents.push(run);
			}
			
			function collectArg() {
				var start:int=argStartPos;
				var end:int=chrPos;
				if(start==end) return;
				var run:String=txt.substring(start,end);
				tag.args.push(run);
			}
			
			function collectTag() {
				contents.push(tag);
				tag=null;
			}
			
			function collectTagName() {
				tag.name=txt.substring(tagStartPos+1,chrPos);
			}
			
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
						} else if(chr=="/") {
							parseState=ST_SL;
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
					
					case ST_SL:
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

	}
	
}

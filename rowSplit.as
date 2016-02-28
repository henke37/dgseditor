package  {
	
	public function rowSplit(contents:Array):Array {
		var rows:Array=[];
		
		var row:Array=[];
		
		for each(var element:* in contents) {
			if(!(element is String) && element.name=="ROWE") {
				if(row.length) rows.push(row);
				row=[];
			}
			row.push(element);
		}
		if(row.length) rows.push(row);
		
		return rows;
	}
	
}

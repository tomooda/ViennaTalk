building
debuggerStructureIn: browser
	
	browser
		row: #stack;
		row: [ :c | c
			column: #code; 
			column: #vdmSource ] span: 2;
		row: #inspector.
		
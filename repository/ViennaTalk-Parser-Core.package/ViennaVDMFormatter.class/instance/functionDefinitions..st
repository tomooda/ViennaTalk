formatting-definitions
functionDefinitions: aViennaNode
	^ 'functions' , String cr , indent
		, (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';' , String cr)
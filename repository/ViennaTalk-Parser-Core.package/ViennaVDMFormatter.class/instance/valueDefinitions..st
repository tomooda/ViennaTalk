formatting-definitions
valueDefinitions: aViennaNode
	^ 'values' , String cr , indent , (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';')
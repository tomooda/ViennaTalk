formatting-definitions
typeDefinitions: aViennaNode
	^ 'types' , String cr , indent , (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';')
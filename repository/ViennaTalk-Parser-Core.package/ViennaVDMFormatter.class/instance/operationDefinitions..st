formatting-definitions
operationDefinitions: aViennaNode
	^ 'operations' , String cr , indent
		, (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';' , String cr)
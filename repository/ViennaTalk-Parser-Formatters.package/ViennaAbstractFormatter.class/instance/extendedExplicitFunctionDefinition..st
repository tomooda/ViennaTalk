formatting-definitions
extendedExplicitFunctionDefinition: aViennaNode
	| identifier typeVariableList parameterTypes identifierTypePairList body pre post |
	identifier := aViennaNode first.
	typeVariableList := aViennaNode second.
	parameterTypes := aViennaNode third.
	identifierTypePairList := aViennaNode fourth.
	body := aViennaNode fifth.
	pre := aViennaNode sixth.
	post := aViennaNode seventh.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: typeVariableList);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList);
				nextPutAll: ' ==';
				cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: (self format: body)).
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post) ]
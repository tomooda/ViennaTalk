formatting-definitions
implicitFunctionDefinition: aViennaNode
	| identifier typeVariableList parameterTypes identifierTypePairList pre post |
	identifier := aViennaNode first.
	typeVariableList := aViennaNode second.
	parameterTypes := aViennaNode third.
	identifierTypePairList := aViennaNode fourth.
	pre := aViennaNode fifth.
	post := aViennaNode sixth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: typeVariableList);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList).
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post) ]
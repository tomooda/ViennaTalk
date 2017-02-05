formatting-definitions
extendedExplicitOperationDefinition: aViennaNode
	| identifier parameterTypes identifierTypePairList body externals pre post exceptions |
	identifier := aViennaNode first.
	parameterTypes := aViennaNode second.
	identifierTypePairList := aViennaNode third.
	body := aViennaNode fourth.
	externals := aViennaNode fifth.
	pre := aViennaNode sixth.
	post := aViennaNode seventh.
	exceptions := aViennaNode eighth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList);
				nextPutAll: ' ==';
				cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: (self format: body)).
			externals
				ifNotNil: [ stream
						cr;
						nextPutAll: (self format: externals) ].
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post).
			exceptions
				ifNotNil: [ stream
						cr;
						nextPutAll: (self format: exceptions) ] ]
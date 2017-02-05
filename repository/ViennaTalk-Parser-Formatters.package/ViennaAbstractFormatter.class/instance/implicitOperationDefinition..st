formatting-definitions
implicitOperationDefinition: aViennaNode
	| identifier parameterTypes identifierTypePairList implicitOperationBody |
	identifier := aViennaNode first.
	parameterTypes := self format: aViennaNode second.
	identifierTypePairList := self format: aViennaNode third.
	implicitOperationBody := self format: aViennaNode fourth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: identifier;
				nextPutAll: parameterTypes;
				nextPutAll: identifierTypePairList;
				nextPutAll: implicitOperationBody ]
code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| quin |
	quin := super stateDefinition: aViennaNode env: aDictionary.
	^ self
		stringStreamContents: [ :stream | 
			stream
				nextPutAll: quin first;
				nextPutAll: quin second;
				nextPutAll: '.';
				cr;
				nextPutAll: quin third.
			quin fourth
				ifNotNil: [ :inv | 
					stream
						nextPutAll: '.';
						cr;
						nextPutAll: inv ].
			stream
				nextPutAll: '. state := [';
				nextPutAll: quin fifth;
				nextPutAll: ']' ]
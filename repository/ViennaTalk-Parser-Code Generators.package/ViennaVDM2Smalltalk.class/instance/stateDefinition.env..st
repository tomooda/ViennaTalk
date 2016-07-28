code generation-definitions
stateDefinition: aViennaNode env: aDictionary
	| constructor fieldListNode invNode initNode vars vals recordNode initConstructor expressionListNode patternVar |
	constructor := aViennaNode first.
	fieldListNode := aViennaNode second.
	invNode := aViennaNode third.
	initNode := aViennaNode fourth.
	vars := fieldListNode collect: #first.
	initNode ifNil: [ ^ self error: 'initalisation is required in state definition' ].
	recordNode := initNode first second second.
	initConstructor := recordNode first first.
	expressionListNode := recordNode second.
	initConstructor = constructor
		ifFalse: [ ^ self error: 'Constructor must be the same name as state definition: ' , constructor , ', ' , initConstructor ].
	vars size = expressionListNode size
		ifFalse: [ 
			^ self
				error:
					'Number of state variables and number of arguments must agree: ' , vars size printString , ', '
						, expressionListNode size printString ].
	vals := expressionListNode collect: [ :node | self generate: node env: aDictionary ].
	^ {(String
		new: 1024
		streamContents: [ :stream | 
			vars
				with: vals
				do: [ :var :val | 
					stream
						nextPutAll: var;
						nextPutAll: ' := ';
						nextPutAll: val;
						nextPutAll: '.' , String cr ] ]).
	(String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: initConstructor;
				nextPutAll: ' := ViennaCompositeType constructorName: ';
				nextPutAll: initConstructor storeString;
				nextPutAll: ' withAll: {';
				nextPutAll: (' . ' join: (self generate: fieldListNode env: aDictionary));
				nextPutAll: '}' ]).
	(String
		new: 1024
		streamContents: [ :stream | 
			patternVar := initNode first first first.
			stream
				nextPutAll: 'init_';
				nextPutAll: initConstructor;
				nextPutAll: ' := ';
				nextPutAll: (self generate: initNode first env: aDictionary) ]).
	(invNode
		ifNotNil: [ 
			String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: 'inv_';
						nextPutAll: constructor;
						nextPutAll: ' := ';
						nextPutAll: (self generate: invNode first env: aDictionary) ] ]).
	(String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'Dictionary new '.
			vars do: [ :var | stream nextPutAll: 'at: ' , var storeString , ' put: ' , var , '; ' ].
			stream nextPutAll: 'yourself' ])}
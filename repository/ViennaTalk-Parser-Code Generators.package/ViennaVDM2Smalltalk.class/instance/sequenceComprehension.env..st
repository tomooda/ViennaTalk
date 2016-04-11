code generation-expressions
sequenceComprehension: aViennaNode env: aDictionary
	| expr bindNode setNode guard varGenerator seq set |
	expr := self generate: aViennaNode first env: aDictionary.
	bindNode := aViennaNode second.
	setNode := bindNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'seq'
		uniqueIn:
			{expr.
			(guard ifNil: [ '' ])}.
	seq := varGenerator value.
	set := varGenerator value.
	bindNode first label = 'PatternIdentifier'
		ifTrue: [ 
			| var |
			var := bindNode first first.
			^ '('
				,
					(setNode label = 'SetRangeExpression'
						ifTrue: [ '(' , (self intervalExpression: setNode env: aDictionary) , ')' ]
						ifFalse: [ 
							setNode label = 'SequenceIndices'
								ifTrue: [ '(' , (self indicesExpression: setNode env: aDictionary) , ')' ]
								ifFalse: [ (self generate: setNode env: aDictionary) , ' asSortedCollection' ] ])
				,
					(guard
						ifNotNil: [ ' select: [:' , var , ' | ' , guard , '] thenCollect: [:' , var , ' | ' ]
						ifNil: [ ' collect: [:' , var , ' | ' ]) , expr , ']) asOrderedCollection' ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			| body |
			body := seq , ' add: ' , expr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream
				nextPutAll: '([ :' , set , ' | | ' , seq , ' | ' , seq , ' :=OrderedCollection new.';
				nextPutAll:
						(self
								generatorFromFlatBinds:
									{{(bindNode first).
									(ViennaNode label: 'LocalName' with: set)}}
								body: body
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: seq;
				nextPutAll: '] value: ';
				nextPutAll:
						(setNode label = 'SetRangeExpression'
								ifTrue: [ '(' , (self intervalExpression: setNode env: aDictionary) , ')' ]
								ifFalse: [ (self generate: setNode env: aDictionary) , ' asSortedCollection' ]);
				nextPut: $) ]
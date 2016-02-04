code generation-expressions
sequenceComprehension: aViennaNode env: aDictionary
	| patternNode typeOrSetNode expr guard varGenerator seq |
	expr := self generate: aViennaNode first env: aDictionary.
	patternNode := aViennaNode second first.
	typeOrSetNode := aViennaNode second second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'seq'
		uniqueIn:
			{expr.
			(guard ifNil: [ '' ])}.
	patternNode label = 'PatternIdentifier'
		ifTrue: [ 
			| set var |
			set := typeOrSetNode label = 'SetRangeExpression'
				ifTrue: [ 
					'(' , (self generate: typeOrSetNode first env: aDictionary) , ' to: '
						, (self generate: typeOrSetNode second env: aDictionary) , ')' ]
				ifFalse: [ (self generate: typeOrSetNode env: aDictionary) , ' asSortedCollection asOrderedCollection' ].
			var := patternNode first.
			^ '(' , set , (guard ifNotNil: [ ' select: [ :' , var , '|' , guard , '] thenCollect:' ] ifNil: [ ' collect:' ])
				, ' [:' , var , '|' , expr , ']) asOrderedCollection' ].
	seq := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: '[|';
				nextPutAll: seq;
				nextPutAll: '|';
				nextPutAll: seq;
				nextPutAll: ':= OrderedCollection new.';
				nextPutAll:
						(self
								generatorCodePattern: patternNode
								typeOrSet: typeOrSetNode
								needsSort: true
								varGenerator: varGenerator
								env: aDictionary).
			guard
				ifNotNil: [ 
					stream
						nextPutAll: guard;
						nextPutAll: ' ifTrue: [' ].
			stream
				nextPutAll: seq;
				nextPutAll: ' add: ';
				nextPutAll: expr.
			guard ifNotNil: [ stream nextPutAll: ']' ].
			stream
				nextPutAll: ']. ';
				nextPutAll: seq;
				nextPutAll: '] value' ]
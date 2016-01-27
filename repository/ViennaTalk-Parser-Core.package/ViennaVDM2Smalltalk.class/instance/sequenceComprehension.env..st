code generation-expressions
sequenceComprehension: aViennaNode env: aDictionary
	| expr setBinding pat vars matcher set guard varGenerator seq |
	expr := self generate: aViennaNode first env: aDictionary.
	setBinding := self generate: aViennaNode second env: aDictionary.
	guard := self generate: aViennaNode third env: aDictionary.
	pat := setBinding first.
	vars := pat first.
	matcher := pat second.
	set := setBinding second.
	varGenerator := self
		varNameGenerator: 'seq'
		uniqueIn:
			{expr.
			matcher.
			set.
			(guard ifNil: [ '' ])}.
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
								generatorCodeFromVar: vars
								matcher: matcher
								set: set , ' asSortedCollection'
								varGenerator: varGenerator).
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
parsers-expressions-basics
sequenceComprehension
	^ super sequenceComprehension
		==> [ :triple | 
			| expr setBinding pat vars binder set guard varGenerator seq |
			expr := triple first.
			setBinding := triple second.
			pat := setBinding first.
			vars := pat first .
			binder := pat second.
			set := setBinding second.
			guard := triple third.
			varGenerator := self
				varNameGenerator: 'seq'
				uniqueIn:
					{expr.
					binder.
					set.
					(guard ifNil: [ '' ])}.
			seq := varGenerator value.
			String
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
										binder: binder
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
						nextPutAll: '] value' ] ]
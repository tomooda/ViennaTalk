code generation-expressions
distributedSetIntersection: aViennaNode
	| arg |
	arg := self generate: aViennaNode first.
	^ '(' , arg
		,
			' asArray in: [ :sets | sets isEmpty ifTrue: [Set new] ifFalse: [(sets copyFrom: 2 to: sets size) inject: sets first into: [:inter :set | inter intersection: set]]])'
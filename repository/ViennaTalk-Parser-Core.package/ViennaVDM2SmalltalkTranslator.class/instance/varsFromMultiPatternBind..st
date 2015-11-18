utilities
varsFromMultiPatternBind: multiPatternBind
	| vars |
	vars := Array new writeStream.
	multiPatternBind
		do: [ :multiPattern | 
			| patterns |
			patterns := multiPattern first.
			patterns do: [ :varAndBlockString | vars nextPut: varAndBlockString first ] ].
	^ vars
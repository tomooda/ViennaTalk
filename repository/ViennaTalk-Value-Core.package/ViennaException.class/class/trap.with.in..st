controlling
trap: matcherBlock with: handlerBlock in: aBlock
	^ aBlock
		on: self
		do: [ :ex | 
			(matcherBlock value: ex expression)
				ifNotNil: [ :bindings | handlerBlock value: bindings ]
				ifNil: [ ex pass ] ]
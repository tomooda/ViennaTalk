enumerating
basicDo: aBlock
	basetype
		do: [ :v | 
			(invariant value: v)
				ifTrue: [ aBlock value: v ] ]
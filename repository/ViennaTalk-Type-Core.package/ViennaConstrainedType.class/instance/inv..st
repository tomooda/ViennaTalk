arithmetic
inv: aBlock
	^ self class with: basetype with: [ :v | (invariant value: v) and: [ aBlock value: v ] ]
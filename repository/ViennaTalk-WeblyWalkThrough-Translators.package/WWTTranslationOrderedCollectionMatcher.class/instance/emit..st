translating
emit: aDictionary
	| binds sizes |
	binds := Dictionary new.
	self allVariables do: [ :var | binds at: var put: (aDictionary at: var) ].
	sizes := (binds values collect: #size) asSet asArray.
	^ sizes size = 1
		ifTrue: [ 
			((1 to: sizes first)
				collect: [ :index | 
					| localBind |
					localBind := Dictionary new: binds size.
					binds keysAndValuesDo: [ :var :vals | localBind at: var put: (vals at: index) ].
					elementMatcher emit: localBind ]) asOrderedCollection ]
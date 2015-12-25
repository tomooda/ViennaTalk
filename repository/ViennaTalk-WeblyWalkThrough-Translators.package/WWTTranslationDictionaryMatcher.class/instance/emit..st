translating
emit: aDictionary
	| binds sizes |
	binds := Dictionary new.
	self allVariables do: [ :var | binds at: var put: (aDictionary at: var) ].
	sizes := (binds values collect: #size) asSet asArray.
	^ sizes size = 1
		ifTrue: [ 
			| keyVars valueVars |
			keyVars := keyMatcher allVariables.
			valueVars := valueMatcher allVariables.
			((1 to: sizes first)
				collect: [ :index | 
					| keyBinds valueBinds |
					keyBinds := Dictionary new: binds size.
					valueBinds := Dictionary new: binds size.
					keyVars do: [ :var :vals | keyBinds at: var put: ((binds at: var) at: index) ].
					valueVars do: [ :var :vals | valueBinds at: var put: ((binds at: var) at: index) ].
					(keyMatcher emit: keyBinds) -> (valueMatcher emit: valueBinds) ]) asDictionary ]
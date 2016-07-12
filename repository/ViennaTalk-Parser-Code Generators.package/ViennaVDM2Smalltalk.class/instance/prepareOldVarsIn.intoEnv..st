utilities
prepareOldVarsIn: aViennaNode intoEnv: aDictionary
	| env |
	env := aDictionary copy.
	(self freeVariables: aViennaNode env: aDictionary)
		do: [ :var | 
			var last = $~
				ifTrue: [ env at: var put: '(_oldState at: ' , (var copyFrom: 1 to: var size - 1) storeString , ')' ] ].
	^ env
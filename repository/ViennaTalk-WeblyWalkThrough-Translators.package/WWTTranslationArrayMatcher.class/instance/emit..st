translating
emit: aDictionary
	^ elementMatchers
		collect: [ :matcher | 
			| vars localBinds |
			vars := matcher allVariables.
			localBinds := Dictionary new: vars size.
			vars do: [ :var | localBinds at: var put: (aDictionary at: var) ].
			matcher emit: localBinds ]
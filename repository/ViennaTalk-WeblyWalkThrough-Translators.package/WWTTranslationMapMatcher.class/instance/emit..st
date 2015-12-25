translating
emit: aDictionary
	^ (matchers
		collect: [ :assoc | 
			| field matcher vars localBinds |
			field := assoc key.
			matcher := assoc value.
			vars := matcher allVariables.
			localBinds := Dictionary new: vars size.
			vars do: [ :var | localBinds at: var put: (aDictionary at: var) ].
			field -> (matcher emit: localBinds) ]) asDictionary
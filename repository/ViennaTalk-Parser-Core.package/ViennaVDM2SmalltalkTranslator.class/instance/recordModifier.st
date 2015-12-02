parsers-expressions-basics
recordModifier
	^ super recordModifier
		==> [ :pair | 
			| record modifiers |
			record := pair first.
			modifiers := pair second.
			'(' , record , ' copy '
				,
					('; '
						join:
							(modifiers collect: [ :fieldAndValue | ' at: ' , fieldAndValue first storeString , ' put: ' , fieldAndValue second ]))
				, '; yourself)' ]
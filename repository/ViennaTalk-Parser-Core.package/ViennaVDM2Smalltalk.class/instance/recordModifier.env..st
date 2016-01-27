code generation-expressions
recordModifier: aViennaNode env: aDictionary
	| record modifiers |
	record := self generate: aViennaNode first env: aDictionary.
	modifiers := self generate: aViennaNode second env: aDictionary.
	^ '(' , record , ' copy '
		,
			('; '
				join:
					(modifiers collect: [ :fieldAndValue | ' at: ' , fieldAndValue first storeString , ' put: ' , fieldAndValue second ]))
		, '; yourself)'
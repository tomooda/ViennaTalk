code generation-patterns
setEnumPattern: aViennaNode env: aDictionary
	| elementPatterns vars elements |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ]) asSet
		asArray.
	elements := elementPatterns collect: #second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elements) , '})')}
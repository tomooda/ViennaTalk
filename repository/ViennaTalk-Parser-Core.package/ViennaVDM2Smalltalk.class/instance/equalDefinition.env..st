code generation-definitions
equalDefinition: aViennaNode env: aDictionary
	| leftAndRight |
	leftAndRight := self generateAll: aViennaNode env: aDictionary.
	^ {(leftAndRight first first).
	(leftAndRight second)}
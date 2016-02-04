code generation-definitions
equalDefinition: aViennaNode env: aDictionary
	| left right |
	left := self generate: aViennaNode first env: aDictionary.
	(#('TypeBind' 'SetBind') includes: aViennaNode first label)
		ifTrue: [ left := left first ].
	right := self generate: aViennaNode second env: aDictionary.
	^ self binder: left with: right vars: (self boundVariables: aViennaNode) asArray
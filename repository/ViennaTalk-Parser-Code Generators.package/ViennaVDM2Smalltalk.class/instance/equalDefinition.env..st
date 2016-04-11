code generation-definitions
equalDefinition: aViennaNode env: aDictionary
	| leftNode left right |
	leftNode := aViennaNode first.
	(#('TypeBind' 'SetBind') includes: leftNode label)
		ifTrue: [ leftNode := leftNode first ].
	left := self generate: leftNode env: aDictionary.
	right := self generate: aViennaNode second env: aDictionary.
	^ leftNode label = 'PatternIdentifier'
		ifTrue: [ '[' , leftNode first , ' := ' , right , '. true] value' ]
		ifFalse: [ self binder: left with: right vars: (self boundVariables: aViennaNode) asArray ]
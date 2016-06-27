code generation-definitions
equalDefinition: aViennaNode env: aDictionary
	| leftNode right guard |
	leftNode := aViennaNode first.
	guard := nil.
	(#('TypeBind' 'SetBind' 'SeqBind') includes: leftNode label)
		ifTrue: [ 
			guard := self generate: leftNode second env: aDictionary.
			leftNode := leftNode first ].
	right := self generate: aViennaNode second env: aDictionary.
	^ leftNode label = 'PatternIdentifier'
		ifTrue: [ 
			'[' , leftNode first , ' := ' , right , '. '
				,
					(guard
						ifNil: [ '' ]
						ifNotNil: [ '(' , guard , ' includes: ' , leftNode first , ') ifFalse: [ViennaBindingViolation signal].' ])
				, 'true ] value' ]
		ifFalse: [ 
			| left rightVar |
			rightVar := (self varNameGenerator: 'cases' uniqueIn: {right}) value.
			left := self generate: leftNode env: aDictionary.
			guard
				ifNil: [ self binder: left with: right vars: (self boundVariables: aViennaNode) asArray ]
				ifNotNil:[
					'([:' , rightVar , ' | (' , guard , ' includes: ' , rightVar , ') ifFalse: [ViennaBindingViolation signal]. '
						, (self binder: left with: rightVar vars: (self boundVariables: aViennaNode) asArray) , '] value: ' , right , ')' ]]
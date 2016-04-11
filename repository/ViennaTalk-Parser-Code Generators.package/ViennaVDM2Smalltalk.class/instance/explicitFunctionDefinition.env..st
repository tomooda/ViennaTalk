code generation-definitions
explicitFunctionDefinition: aViennaNode env: aDictionary
	| funcName typeNode parametersListNode body varGenerator |
	funcName := aViennaNode first.
	typeNode := aViennaNode third.
	parametersListNode := aViennaNode fifth.
	body := self generate: aViennaNode sixth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
			body}.
	parametersListNode asArray
		reverseDo: [ :parametersNode | 
			| argType binds |
			argType := typeNode first.
			typeNode := typeNode second.
			binds := argType label = 'ProductType'
				ifTrue: [ 
					(1 to: parametersNode size)
						collect: [ :index | 
							{(parametersNode at: index).
							(argType at: index)} ] ]
				ifFalse: [ 
					{{(parametersNode first).
					argType}} ].
			body := self
				closureFromFlatBinds: binds
				body: body
				varGenerator: varGenerator
				env: aDictionary ].
	^ funcName , ' := ' , body
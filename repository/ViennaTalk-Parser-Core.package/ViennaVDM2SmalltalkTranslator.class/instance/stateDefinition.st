parsers-definitions
stateDefinition
	^ super stateDefinition
		==> [ :quatro | 
			| constructor fields init vars |
			constructor := quatro first.
			fields := quatro second.
			init := quatro fourth.
			vars := fields collect: #first.
			init
				ifNil: [ PPFailure message: 'initalisation is required in state definition' ]
				ifNotNil: [ 
					| initConstructor values |
					initConstructor := init first.
					values := init second.
					initConstructor = constructor
						ifTrue: [ 
							vars size = values size
								ifTrue: [ 
									{vars.
									((1 to: vars size)
										inject: ''
										into: [ :code :index | code , (vars at: index) , ' := ' , (values at: index) , '.' ])} ]
								ifFalse: [ 
									PPFailure
										message:
											'Number of state variables and number of arguments must agree: ' , vars size printString , ', '
												, values size printString ] ]
						ifFalse: [ PPFailure message: 'Constructor must be the same name as state definition: ' , constructor , ', ' , initConstructor ] ] ]
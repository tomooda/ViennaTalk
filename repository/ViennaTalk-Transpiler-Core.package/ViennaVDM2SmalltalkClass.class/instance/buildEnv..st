utilities
buildEnv: aViennaNode
	| envs |
	envs := Dictionary new.
	envs at: 'DEFAULT' put: Dictionary new.
	aViennaNode first label = 'DefinitionBlock'
		ifTrue: [ | env |
			env := envs at: 'DEFAULT'.
			aViennaNode
				do: [ :definitionBlock | 
					definitionBlock first label = 'StateDefinition'
						ifFalse: [ (self boundVariables: definitionBlock)
								do: [ :ident | env at: ident put: 'self ' , ident ] ] ] ]
		ifFalse: [ aViennaNode
				do: [ :moduleNode | 
					| moduleName |
					moduleName := moduleNode first.
					envs at: moduleName put: Dictionary new.
					moduleNode third
						do: [ :definitionBlock | 
							definitionBlock first label = 'StateDefinition'
								ifFalse: [ (self boundVariables: definitionBlock)
										do: [ :ident | 
											(envs at: moduleName) at: ident put: 'self ' , ident.
											(envs at: 'DEFAULT')
												at: moduleName , '`' , ident
												put: '(self at: ' , moduleName storeString , ') ' , ident ] ] ] ] ].
	^ envs
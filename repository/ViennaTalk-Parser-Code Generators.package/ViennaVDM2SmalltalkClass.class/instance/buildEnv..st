utilities
buildEnv: aViennaNode
	| env |
	env := Dictionary new.
	aViennaNode first label = 'DefinitionBlock'
		ifTrue: [ aViennaNode
				do: [ :definitionBlock | 
					definitionBlock first label = 'StateDefinition'
						ifFalse: [ (self boundVariables: definitionBlock)
								do: [ :ident | env at: ident put: 'self ' , ident ] ] ] ]
		ifFalse: [ aViennaNode
				do: [ :moduleNode | 
					| moduleName |
					moduleName := moduleNode first.
					moduleNode third
						do: [ :definitionBlock | 
							definitionBlock first label = 'StateDefinition'
								ifFalse: [ (self boundVariables: definitionBlock)
										do: [ :ident | 
											env
												at: moduleName , '`' , ident
												put: '(self at: ' , moduleName storeString , ') ' , ident ] ] ] ] ].
							^env
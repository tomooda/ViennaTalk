code generation-definitions
flatDocument: aViennaNode env: aDictionary
	| env newClass |
	env := aDictionary copy.
	newClass := self createDocumentClassWithInstVars: (self boundVariables: aViennaNode).
	classes at: nil put: newClass.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [ (self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
	self defineMethod: 'initialize super initialize. self init' in: newClass protocol: 'initialize-release'.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ].
	^ newClass
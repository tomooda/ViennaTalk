code generation-definitions
flatDocument: aViennaNode env: aDictionary
	| env instVars stateVars newClass |
	env := aDictionary copy.
	stateVars := #().
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ stateVars := definitionBlock first second collect: #first ] ].
	instVars := (self boundVariables: aViennaNode)
		removeAll: stateVars;
		asArray.
	newClass := self createDocumentClassWithInstVars: instVars stateVars: stateVars.
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
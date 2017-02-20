code generation-definitions
flatDocument: aViennaNode env: aDictionary
	| env instVars stateVars typeNames newClass |
	env := aDictionary copy.
	stateVars := #().
	typeNames := Array new writeStream.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ | stateDefinition |
					stateDefinition := definitionBlock first.
					stateVars := stateDefinition second collect: #first.
					env at: stateDefinition first put: 'self ' , stateDefinition first ].
			definitionBlock first label = 'TypeDefinitions'
				ifTrue: [ typeNames nextPutAll: (self boundVariables: definitionBlock first) ] ].
	typeNames := typeNames contents.
	instVars := (self boundVariables: aViennaNode)
		removeAll: stateVars;
		asArray.
	newClass := self createDocumentClassWithInstVars: instVars stateVars: stateVars.
	classes at: nil put: newClass.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [ (self boundVariables: definitionBlock)
						do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
	self
		defineMethod: 'initialize super initialize. self initTypes. self init'
		in: newClass
		protocol: 'initialize-release'.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'.
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ].
	newClass viennaEnv: env.
	^ newClass
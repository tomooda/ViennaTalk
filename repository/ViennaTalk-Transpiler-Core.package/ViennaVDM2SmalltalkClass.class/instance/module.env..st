code generation-definitions
module: aViennaNode env: aDictionary
	| env moduleName interfaceNode moduleBodyNode importModuleNames importClassNames instVars stateVars typeNames newClass |
	env := aDictionary copy.
	self generate: aViennaNode second env: env.
	moduleName := aViennaNode first.
	interfaceNode := aViennaNode second.
	moduleBodyNode := aViennaNode third.
	importModuleNames := interfaceNode first
		ifNil: [ Array new ]
		ifNotNil: [ :importDefinitionListNode | 
			importDefinitionListNode
				collect: [ :importDefinitionNode | importDefinitionNode first ] ].
	importClassNames := importModuleNames
		collect:
			[ :importModuleName | env at: importModuleName first ifAbsent: [ importModuleName ] ].
	stateVars := #().
	typeNames := Array new writeStream.
	moduleBodyNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ | stateDefinition |
					stateDefinition := definitionBlock first.
					stateVars := stateDefinition second collect: #first.
					env at: stateDefinition first put: 'self ' , stateDefinition first ]
				ifFalse: [ (self boundVariables: definitionBlock)
						do: [ :ident | env at: ident put: 'self ' , ident ] ].
			definitionBlock first label = 'TypeDefinitions'
				ifTrue: [ typeNames nextPutAll: (self boundVariables: definitionBlock first) ] ].
	typeNames := typeNames contents.
	instVars := (self boundVariables: moduleBodyNode)
		removeAll: stateVars;
		asArray.
	newClass := self
		createModuleClassWithInstVars: importClassNames , instVars
		stateVars: stateVars
		forModule: moduleName
		env: env.
	classes at: moduleName put: newClass.
	importModuleNames
		with: importClassNames
		do: [ :importModuleName :importClassName | 
			self
				defineMethod:
					importModuleName , ':' , 'a' , importClassName capitalized , String cr
						, importModuleName , ' := ' , 'a' , importClassName capitalized
				in: newClass
				protocol: 'imports'
				node: (interfaceNode first detect: [ :node | node first = importModuleName ]) ].
	moduleBodyNode
		do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	self
		defineMethod: 'initialize super initialize. self initTypes'
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	(newClass includesSelector: #init)
		ifFalse: [ self
				defineMethod: 'init'
				in: newClass
				protocol: 'state'
				node: nil ]
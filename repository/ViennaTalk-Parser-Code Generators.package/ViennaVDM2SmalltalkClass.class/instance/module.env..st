code generation-definitions
module: aViennaNode env: aDictionary
	| env moduleName interfaceNode moduleBodyNode importModuleNames importClassNames instVars stateVars newClass |
	env := aDictionary copy.
	self generate: aViennaNode second env: env.
	moduleName := aViennaNode first.
	interfaceNode := aViennaNode second.
	moduleBodyNode := aViennaNode third.
	importModuleNames := interfaceNode first
		ifNil: [ Array new ]
		ifNotNil: [ :importDefinitionListNode | importDefinitionListNode collect: [ :importDefinitionNode | importDefinitionNode first ] ].
	importClassNames := importModuleNames
		collect: [ :importModuleName | env at: importModuleName first ifAbsent: [ importModuleName ] ].
	stateVars := #().
	moduleBodyNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ stateVars := definitionBlock first second collect: #first ]
				ifFalse: [ (self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
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
					importModuleName , ':' , 'a' , importClassName capitalized , String cr , importModuleName , ' := ' , 'a'
						, importClassName capitalized
				in: newClass
				protocol: 'imports' ].
	moduleBodyNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ]
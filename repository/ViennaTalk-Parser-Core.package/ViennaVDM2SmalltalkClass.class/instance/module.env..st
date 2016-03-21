code generation-definitions
module: aViennaNode env: aDictionary
	| env moduleName interfaceNode moduleBodyNode importModuleNames importClassNames className instVars newClass |
	env := aDictionary copy.
	self generate: aViennaNode second env: env.
	moduleName := aViennaNode first.
	interfaceNode := aViennaNode second.
	moduleBodyNode := aViennaNode third.
	className := env at: moduleName ifAbsent: [ moduleName ].
	importModuleNames := interfaceNode first
		ifNil: [ Array new ]
		ifNotNil: [ :importDefinitionListNode | importDefinitionListNode collect: [ :importDefinitionNode | importDefinitionNode first ] ].
	importClassNames := importModuleNames
		collect: [ :importModuleName | env at: importModuleName first ifAbsent: [ importModuleName ] ].
	moduleBodyNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [(self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ', ident ] ] ].
	instVars := (self boundVariables: moduleBodyNode) asArray.
	newClass := Object subclass: className instanceVariableNames: (' ' join: importClassNames , instVars).
	importModuleNames
		with: importClassNames
		do: [ :importModuleName :importClassName | 
			self
				defineMethod:
					importModuleName , ':' , 'a' , importClassName capitalized , String cr , importModuleName , ' := ' , 'a'
						, importClassName capitalized
				in: newClass
				protocol: 'imports' ].
	moduleBodyNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env in: newClass ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ]
code generation-definitions
flatDocument: aViennaNode env: aDictionary
	| env className instVars newClass |
	env := aDictionary copy.
	className := self requestClassName: ''.
	className ifNil: [ ^ nil ].
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [ (self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
	instVars := self boundVariables: aViennaNode.
	newClass := Object subclass: className instanceVariableNames: (' ' join: instVars).
	self defineMethod: 'initialize super initialize. self init' in: newClass protocol: 'initialize-release'.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env in: newClass ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ].
	^ newClass
code generation-definitions
flatDocument: aViennaNode env: aDictionary
	| className instVars newClass |
	className := self requestClassName: ''.
	className ifNil: [ ^ nil ].
	instVars := self boundVariables: aViennaNode.
	newClass := Object subclass: className instanceVariableNames: (' ' join: instVars).
	self defineMethod: 'initialize super initialize. self init' in: newClass protocol: 'initialize-release'.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: aDictionary in: newClass ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ].
	^ newClass
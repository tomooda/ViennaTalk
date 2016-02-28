code generation-definitions
document: aViennaNode env: aDictionary
	| vars lazyDefs eagerDefs |
	aViennaNode first label = 'DefinitionBlock'
		ifFalse: [ ^ self error: 'This is not a flat spec.' ].
	vars := self boundVariables: aViennaNode.
	lazyDefs := OrderedCollection new.
	eagerDefs := OrderedCollection new.
	self
		definitions: aViennaNode
		do: [ :node | 
			((#('AccessOperationDefinition' 'AccessFunctionDefinition') includes: node label)
				ifTrue: [ lazyDefs ]
				ifFalse: [ eagerDefs ]) add: node ].
	^ '| ' , (' ' join: vars) , ' |' , String cr
		,
			('.' , String cr
				join: (lazyDefs , (self reorderDefinitions: eagerDefs) collect: [ :node | self generate: node env: aDictionary ]))
Class {
	#name : #ViennaVDM2SmalltalkScript,
	#superclass : #ViennaVDM2Smalltalk,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #utilities }
ViennaVDM2SmalltalkScript class >> translate: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast
]

{ #category : #utilities }
ViennaVDM2SmalltalkScript class >> translateExplicitFunction: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new explicitFunctionDefinition end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast
]

{ #category : #utilities }
ViennaVDM2SmalltalkScript class >> translateExplicitOperation: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new explicitOperationDefinition end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast
]

{ #category : #utilities }
ViennaVDM2SmalltalkScript class >> translateExpression: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast
]

{ #category : #utilities }
ViennaVDM2SmalltalkScript class >> translateStatement: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new statement end parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self new generate: ast
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> definitionBlock: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> flatDocument: aViennaNode env: aDictionary [
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
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> functionDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> modularDocument: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> operationDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> stateDefinition: aViennaNode env: aDictionary [
	| triple |
	triple := super stateDefinition: aViennaNode env: aDictionary.
	^ triple first , triple second , '.' , String cr , triple third
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> typeDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr
		join: ((self reorderDefinitions: aViennaNode) collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkScript >> valueDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr
		join: ((self reorderDefinitions: aViennaNode) collect: [ :node | self generate: node env: aDictionary ])
]

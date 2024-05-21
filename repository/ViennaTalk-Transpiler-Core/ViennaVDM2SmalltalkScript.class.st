Class {
	#name : 'ViennaVDM2SmalltalkScript',
	#superclass : 'ViennaVDM2Smalltalk',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript class >> translate: aString ifError: aBlock [
	^ self new translate: aString ifError: aBlock
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript class >> translateExplicitFunction: aString ifError: aBlock [
	^ self new translateExplicitFunction: aString ifError: aBlock
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript class >> translateExplicitOperation: aString ifError: aBlock [
	^ self new translateExplicitOperation: aString ifError: aBlock
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript class >> translateExpression: aString ifError: aBlock [
	^ self new translateExpression: aString ifError: aBlock
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript class >> translateStatement: aString ifError: aBlock [
	^ self new translateStatement: aString ifError: aBlock
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> flatDocument: aViennaNode env: aDictionary [

	     | vars lazyDefs eagerDefs |
	     aViennaNode isViennaFlatDocumentNode ifFalse: [
		     ^ self error: 'This is not a flat spec.' ].
	     vars := aViennaNode uniqueBoundIdentifiers.
	     aViennaNode hasStateDefinition ifTrue: [
		     vars := vars , { 'state'. '_state'. 'init' } ].
	     lazyDefs := OrderedCollection new.
	     eagerDefs := OrderedCollection new.
	     self definitions: aViennaNode do: [ :node |
		     ((node isViennaAccessFunctionDefinitionNode or: [
			       node isViennaAccessOperationDefinitionNode ])
			      ifTrue: [ lazyDefs ]
			      ifFalse: [ eagerDefs ]) add: node ].
	     ^ '| ' , (' ' join: vars) , ' |' , String cr
	       , ('.' , String cr join:
			        (lazyDefs , (self reorderDefinitions: eagerDefs) collect: [
				         :node | self generate: node env: aDictionary ]))
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> functionDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkScript >> functionImport: aViennaNode env: aDictionary [

]

{ #category : 'code generation' }
ViennaVDM2SmalltalkScript >> generate: aViennaNode [
	^ (super generate: aViennaNode) asString; yourself
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> getStateCode [
	^ 'state value'
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkScript >> importDefinition: aViennaNode env: aDictionary [

	
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> modularDocument: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> module: aViennaNode env: aDictionary [

	
]

{ #category : 'code generation-traces' }
ViennaVDM2SmalltalkScript >> namedTrace: aViennaNode env: aDictionary [

	             ^ self stringStreamContents: [ :stream |
		               stream
			               nextPutAll: aViennaNode identifier;
			               nextPutAll: ' := [|_generator | _generator := ';
			               nextPutAll:
				               (self
					                generate: aViennaNode traceDefinitionList
					                env: aDictionary);
			               nextPutAll:
				               '. [init value. _generator next: Dictionary new] whileTrue]' ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> operationDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkScript >> operationImport: aViennaNode env: aDictionary [

	
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> stateDefinition: aViennaNode env: aDictionary [

	             | hexa |
	             hexa := super
		                     stateDefinition: aViennaNode
		                     env: aDictionary.
	             ^ self stringStreamContents: [ :stream |
		               stream nextPutAll: 'init := ['.
		               stream
			               nextPutAll: hexa first;
			               nextPutAll: '].';
			               cr;
			               nextPutAll: 'init value.';
			               cr;
			               nextPutAll: hexa second;
			               nextPutAll: '.';
			               cr;
			               nextPutAll: hexa third.
		               hexa fourth ifNotNil: [ :inv |
			               stream
				               nextPutAll: '.';
				               cr;
				               nextPutAll: inv ].
		               stream
			               nextPutAll: '. state := [';
			               nextPutAll: hexa fifth;
			               nextPutAll: '].';
			               cr;
			               nextPutAll: '_state := [:_state |';
			               nextPutAll: hexa sixth;
			               nextPutAll: ']' ]
]

{ #category : 'code generation-traces' }
ViennaVDM2SmalltalkScript >> traceConcurrentExpression: aViennaNode env: aDictionary [

	| codes |
	codes := aViennaNode collect: [ :trace |
		         self generate: trace env: aDictionary ].
	^ self stringStreamContents: [ :stream |
		  stream nextPutAll: '[ | __state | __state := state value. '.
		  (1 to: aViennaNode size) permutationsDo: [ :indices |
			  indices do: [ :index |
				  stream
					  nextPutAll: (codes at: index);
					  nextPutAll: '. ' ].
			  stream nextPutAll: ' _state value: __state' ].
		  stream nextPutAll: '] value' ]
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translate: aString [
	^ self translate: aString ifError: [  ]
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translate: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translateExplicitFunction: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new explicitFunctionDefinition end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translateExplicitOperation: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new explicitOperationDefinition end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translateExpression: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new expression end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkScript >> translateStatement: aString ifError: aBlock [
	| ast |
	ast := ViennaVDMParser new statement end parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ aBlock cull: ast ].
	^ self generate: ast
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> typeDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr
		join: ((self reorderDefinitions: aViennaNode) collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkScript >> typeImport: aViennaNode env: aDictionary [

	
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkScript >> valueDefinitions: aViennaNode env: aDictionary [
	^ '.' , String cr
		join: ((self reorderDefinitions: aViennaNode) collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkScript >> valueImport: aViennaNode env: aDictionary [

	
]

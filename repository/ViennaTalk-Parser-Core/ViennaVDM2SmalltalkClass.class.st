Class {
	#name : #ViennaVDM2SmalltalkClass,
	#superclass : #ViennaVDM2Smalltalk,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineLazyMethodNamed: selector initializer: initializer in: aClass protocol: protocol [
	^ self
		defineMethod: selector , String cr , '^ ' , selector , ' ifNil: [' , initializer , ']'
		in: aClass
		protocol: protocol
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineMethod: aString in: aClass protocol: protocol [
	aClass compile: (RBParser parseMethod: aString) formattedCode classified: protocol
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> definitionBlock: aViennaNode env: aDictionary in: aClass [
	aViennaNode
		do: [ :node | 
			self
				perform: (node label uncapitalized , ':env:in:') asSymbol
				with: node
				with: aDictionary
				with: aClass ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> flatDocument: aViennaNode env: aDictionary [
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
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> functionDefinitions: aViennaNode env: aDictionary in: aClass [
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary)
						in: aClass
						protocol: 'functions'.
					aDictionary at: identifier put: 'self ' , identifier ] ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> functionImport: aViennaNode env: aDictionary module: aString [
	aViennaNode fourth
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]
]

{ #category : #'code generation' }
ViennaVDM2SmalltalkClass >> generate: aViennaNode env: aDictionary module: aString [
	| selector |
	selector := aViennaNode label uncapitalized , ':env:module:'.
	^ self
		perform: selector asSymbol
		with: aViennaNode
		with: aDictionary
		with: aString
]

{ #category : #'code generation-expressions' }
ViennaVDM2SmalltalkClass >> globalName: aViennaNode env: aDictionary [
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ aViennaNode first , String space , aViennaNode second ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importDefinition: aViennaNode env: aDictionary [
	| moduleName importModuleSignatureNode |
	moduleName := aViennaNode first.
	importModuleSignatureNode := aViennaNode second.
	importModuleSignatureNode do: [ :node | self generate: node env: aDictionary module: moduleName ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importDefinitionList: aViennaNode env: aDictionary [
	aViennaNode do: [ :node | self generate: node env: aDictionary ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importFunctionsSignature: aViennaNode env: aDictionary module: aString [
	aViennaNode do: [ :node | self generate: node env: aDictionary module: aString ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importOperationsSignature: aViennaNode env: aDictionary module: aString [
	aViennaNode do: [ :node | self generate: node env: aDictionary module: aString ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importTypesSignature: aViennaNode env: aDictionary module: aString [
	aViennaNode do: [ :node | self generate: node env: aDictionary module: aString ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> importValuesSignature: aViennaNode env: aDictionary module: aString [
	aViennaNode do: [ :node | self generate: node env: aDictionary module: aString ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> interface: aViennaNode env: aDictionary [
	self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> modularDocument: aViennaNode env: aDictionary [
	| documentClassName moduleNames classNames documentClass |
	documentClassName := self requestClassName: ''.
	documentClassName ifNil: [ ^ nil ].
	moduleNames := aViennaNode collect: #first.
	classNames := moduleNames
		collect: [ :moduleName | 
			(self requestClassName: moduleName)
				ifNil: [ ^ nil ]
				ifNotNil: [ :name | 
					aDictionary at: moduleName put: name.
					name ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	documentClass := Object
		subclass: documentClassName
		instanceVariableNames: (' ' join: (moduleNames collect: #uncapitalized)).
	self
		defineMethod:
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: 'initialize';
						cr;
						nextPutAll: 'super initialize.';
						cr.
					moduleNames
						with: classNames
						do: [ :moduleName :className | 
							stream
								nextPutAll: moduleName uncapitalized;
								nextPutAll: ' := ';
								nextPutAll: className;
								nextPutAll: ' new.';
								cr ].
					aViennaNode
						do: [ :moduleNode | 
							| moduleName |
							moduleName := moduleNode first.
							moduleNode second first
								ifNotNil: [ :importDefinitionListNode | 
									importDefinitionListNode
										do: [ :importDefinitionNode | 
											| importedModuleName |
											importedModuleName := importDefinitionNode first.
											stream
												nextPutAll: moduleName uncapitalized;
												nextPutAll: String space;
												nextPutAll: importedModuleName;
												nextPutAll: ': ';
												nextPutAll: importedModuleName uncapitalized;
												nextPutAll: '.';
												cr ] ] ].
					moduleNames
						do: [ :moduleName | 
							stream
								nextPutAll: moduleName uncapitalized;
								nextPutAll: ' init.';
								cr ] ])
		in: documentClass
		protocol: 'initialize-release'.
	moduleNames
		do: [ :moduleName | self defineMethod: moduleName , ' ^' , moduleName uncapitalized in: documentClass protocol: 'accessing' ].
	^ documentClass
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> module: aViennaNode env: aDictionary [
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
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> operationDefinitions: aViennaNode env: aDictionary in: aClass [
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary)
						in: aClass
						protocol: 'operations'.
					aDictionary at: identifier put: 'self ' , identifier ] ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> operationImport: aViennaNode env: aDictionary module: aString [
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> requestClassName: defaultClassName [
	| className |
	className := defaultClassName.
	[ 
	className := UIManager default
		request: 'Enter a class name to generate.'
		initialAnswer: className
		title: 'ViennaTalk code generator'.
	className ifNil: [ ^ nil ].
	[ self validateClassName: className ]
		whileFalse: [ 
			className := UIManager default
				request:
					className , ' is not a valid class name. Please give another class name.' , String cr
						, 'Every character should be in alpha-numeric characters, and the name should start with a uppercase initial'
				initialAnswer: className
				title: 'ViennaTalk code generator'.
			className ifNil: [ ^ nil ] ].
	(Smalltalk includesKey: className asSymbol) not
		or: [ UIManager default confirm: className , ' already exists. Do you want to overwrite it?' ] ] whileFalse.
	^ className
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> stateDefinition: aViennaNode env: aDictionary in: aClass [
	| stateConstructor triple |
	stateConstructor := aViennaNode first.
	triple := self stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , triple first in: aClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: triple second
		in: aClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: triple third
		in: aClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> typeDefinitions: aViennaNode env: aDictionary in: aClass [
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary)
						in: aClass
						protocol: 'types'.
					aDictionary at: identifier put: 'self ' , identifier ] ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> typeImport: aViennaNode env: aDictionary module: aString [
	aViennaNode second
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> validateClassName: aString [
	aString ifEmpty: [ ^ false ].
	aString first canBeGlobalVarInitial
		ifFalse: [ ^ false ].
	(aString allSatisfy: [ :char | char isAlphaNumeric or: [ char = $_ ] ])
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> valueDefinitions: aViennaNode env: aDictionary in: aClass [
	aViennaNode
		do: [ :node | 
			(self boundVariables: node)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: (self generate: node env: aDictionary) , '. ' , identifier
						in: aClass
						protocol: 'values'.
					aDictionary at: identifier put: 'self ' , identifier ] ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> valueImport: aViennaNode env: aDictionary module: aString [
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: aString , String space , aViennaNode first first ]
]

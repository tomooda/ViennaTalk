Class {
	#name : #ViennaVDM2SmalltalkClass,
	#superclass : #ViennaVDM2Smalltalk,
	#instVars : [
		'classes'
	],
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
ViennaVDM2SmalltalkClass >> explicitFunctionDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super explicitFunctionDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> explicitOperationDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super explicitOperationDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'operations'
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> flatDocument: aViennaNode env: aDictionary [
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
	classes at: nil put: newClass.
	self defineMethod: 'initialize super initialize. self init' in: newClass protocol: 'initialize-release'.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' ].
	^ newClass
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> functionImport: aViennaNode env: aDictionary [
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: FunctionImport must appear under ImportDefinition' ].
	aViennaNode fourth
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2SmalltalkClass >> globalName: aViennaNode env: aDictionary [
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ aViennaNode first , String space , aViennaNode second ]
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> importDefinition: aViennaNode env: aDictionary [
	| moduleName importModuleSignatureNode |
	moduleName := aViennaNode first.
	importModuleSignatureNode := aViennaNode second.
	importModuleSignatureNode do: [ :node | self generate: node env: aDictionary ]
]

{ #category : #'initialize-release' }
ViennaVDM2SmalltalkClass >> initialize [
	super initialize.
	classes := Dictionary new
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
	moduleBodyNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [(self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ', ident ] ] ].
	instVars := (self boundVariables: moduleBodyNode) asArray.
	newClass := Object subclass: className instanceVariableNames: (' ' join: importClassNames , instVars).
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
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> operationImport: aViennaNode env: aDictionary [
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: OperationImport must appear under ImportDefinition' ].
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> recordTypeDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super recordTypeDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'
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
ViennaVDM2SmalltalkClass >> stateDefinition: aViennaNode env: aDictionary [
	| theClass stateConstructor triple |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	triple := super stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , triple first in: theClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: triple second
		in: theClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: triple third
		in: theClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> typeDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super typeDefinition: aViennaNode env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> typeImport: aViennaNode env: aDictionary [
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: TypeImport must appear under ImportDefinition' ].
	aViennaNode second
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]
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
ViennaVDM2SmalltalkClass >> valueDefinitions: aViennaNode env: aDictionary [
	| theClass initializer |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	aViennaNode
		do: [ :node | 
			initializer := self generate: node env: aDictionary.
			(self boundVariables: aViennaNode)
				do: [ :identifier | 
					self
						defineLazyMethodNamed: identifier
						initializer: initializer , '. ' , identifier
						in: theClass
						protocol: 'values' ] ]
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> valueImport: aViennaNode env: aDictionary [
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: ValueImport must appear under ImportDefinition' ].
	aViennaNode third
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first ]
]

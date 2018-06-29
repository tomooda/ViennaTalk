Class {
	#name : #ViennaVDM2SmalltalkClass,
	#superclass : #ViennaVDM2Smalltalk,
	#instVars : [
		'classes'
	],
	#category : 'ViennaTalk-Parser-Code Generators'
}

{ #category : #'code generation-statements' }
ViennaVDM2SmalltalkClass >> callStatement: aViennaNode env: aDictionary [
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ args
		ifEmpty: [ callee , ': nil' ]
		ifNotEmpty: [ callee , ': ' , args first , ('' join: ((2 to: args size) collect: [ :i | ' _: ' , (args at: i) ])) ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> closureFromMethodSource: aString binds: binds [
	| header |
	header := ((aString readStream upTo: Character cr) trim readStream upTo: $:) , ':'.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPut: $[.
			1 to: binds size do: [ :i | 
				stream nextPutAll: ' :arg'.
				i printOn: stream ].
			stream space.
			binds ifNotEmpty: [ stream nextPutAll: '| ' ].
			stream nextPutAll: 'self '.
			binds
				ifEmpty: [ 
					stream
						nextPutAll: header;
						nextPutAll: ' nil' ]
				ifNotEmpty: [ 
					stream
						nextPutAll: header;
						nextPutAll: ' arg1'.
					2 to: binds size do: [ :i | 
						stream nextPutAll: ' _: arg'.
						i printOn: stream ] ].
			stream nextPutAll: ']' ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> createDocumentClassWithInstVars: anArrayOfString [
	^ self createDocumentClassWithInstVars: anArrayOfString stateVars: #()
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> createDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 [
	| documentClassName |
	documentClassName := self requestClassName: '' for: 'Document'.
	documentClassName ifNil: [ ^ nil ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: documentClassName asSymbol;
				superclass: Object;
				slots:
						(anArrayOfString1 asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
								, (anArrayOfString2 asArray collect: [ :instVarName | ViennaStateSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> createModuleClassWithInstVars: anArrayOfString forModule: aString env: aDictionary [
	^ self
		createModuleClassWithInstVars: anArrayOfString
		stateVars: #()
		forModule: aString
		env: aDictionary
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> createModuleClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 forModule: aString env: aDictionary [
	| className |
	className := aDictionary at: aString ifAbsent: [ aString ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: className asSymbol;
				superclass: Object;
				slots:
						(anArrayOfString1 asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
								, (anArrayOfString2 asArray collect: [ :instVarName | ViennaStateSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]
]

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
	| method opname typeNode paramsNode body varGenerator argTypeNode binds theClass |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	argTypeNode := typeNode first.
	binds := argTypeNode label = 'UnitType'
		ifTrue: [ {} ]
		ifFalse: [ 
			argTypeNode label = 'ProductType'
				ifTrue: [ 
					(1 to: argTypeNode size)
						collect: [ :index | 
							{(paramsNode at: index).
							(argTypeNode at: index)} ] ]
				ifFalse: [ 
					{{(paramsNode first).
					argTypeNode}} ] ].
	method := self
		methodFromOperation: opname
		fromFlatBinds: binds
		body: body
		varGenerator: varGenerator
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self defineMethod: method in: theClass protocol: 'operations'.
	self
		defineLazyMethodNamed: opname
		initializer: opname , ' := ' , (self closureFromMethodSource: method binds: binds)
		in: theClass
		protocol: 'operations'
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> flatDocument: aViennaNode env: aDictionary [
	| env instVars stateVars newClass |
	env := aDictionary copy.
	stateVars := #().
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ stateVars := definitionBlock first second collect: #first ] ].
	instVars := (self boundVariables: aViennaNode)
		removeAll: stateVars;
		asArray.
	newClass := self createDocumentClassWithInstVars: instVars stateVars: stateVars.
	classes at: nil put: newClass.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [ (self boundVariables: definitionBlock) do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
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
		ifAbsent: [ (aDictionary at: aViennaNode first ifAbsent: [ aViennaNode first ]) , String space , aViennaNode second ]
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

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> methodFromOperation: opName fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary [
	^ String
		new: 1024
		streamContents: [ :stream | 
			| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars |
			tmpVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			stream nextPutAll: opName.
			anArrayOfPatternNodeAndTypeSetNode isEmpty
				ifTrue: [ stream nextPutAll: ': ' , varGenerator value ].
			isFirstArg := true.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					bindType = #identifier
						ifTrue: [ 
							isFirstArg
								ifFalse: [ stream nextPutAll: ' _' ].
							stream
								nextPutAll: ':';
								nextPutAll: patternNode first ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							matchPatternNodes add: patternNode.
							isFirstArg
								ifFalse: [ stream nextPutAll: ' _' ].
							stream
								nextPutAll: ':';
								nextPutAll: tmpVar ].
					isFirstArg := false ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			matchVars notEmpty
				ifTrue: [ 
					stream
						cr;
						nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream
						nextPutAll: '| ';
						nextPutAll:
								(self binder: (self generate: tuplePattern env: aDictionary) with: '{' , (' . ' join: tmpVars) , '}' vars: matchVars);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream
				cr;
				nextPutAll: aString ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> modularDocument: aViennaNode env: aDictionary [
	| moduleNames classNames documentClass |
	moduleNames := aViennaNode collect: #first.
	documentClass := self createDocumentClassWithInstVars: (moduleNames collect: #uncapitalized).
	classNames := moduleNames
		collect: [ :moduleName | 
			(self requestClassName: moduleName for: moduleName, ' module')
				ifNil: [ ^ nil ]
				ifNotNil: [ :name | 
					aDictionary at: moduleName put: name.
					name ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
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
ViennaVDM2SmalltalkClass >> requestClassName: defaultClassName for: aString [
	| className |
	className := defaultClassName.
	[ 
	className := UIManager default
		request: 'Enter a class name to generate for ', aString, '.'
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

{ #category : #'code generation-statements' }
ViennaVDM2SmalltalkClass >> returnStatement: aViennaNode env: aDictionary [
	^ '^ ' , (self generate: aViennaNode first env: aDictionary)
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> stateDefinition: aViennaNode env: aDictionary [
	| theClass stateConstructor quatro |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	quatro := super stateDefinition: aViennaNode env: aDictionary.
	self defineMethod: 'init' , String cr , quatro first in: theClass protocol: 'state'.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: quatro second
		in: theClass
		protocol: 'state'.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: quatro third
		in: theClass
		protocol: 'state'.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr , '    ^ self ' , stateConstructor , ' applyTo: {'
				, (' . ' join: (aViennaNode second collect: #first)) , '}'
		in: theClass
		protocol: 'state'.
	quatro fourth
		ifNotNil: [ :inv | 
			self
				defineMethod: 'inv' , String cr , '    (' , inv , ' value: self state) ifFalse: [self stateInvariantViolation]'
				in: theClass
				protocol: 'state' ]
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
			(self boundVariables: node)
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

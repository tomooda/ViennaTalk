Class {
	#name : #ViennaVDM2SmalltalkClass,
	#superclass : #ViennaVDM2Smalltalk,
	#instVars : [
		'classes'
	],
	#category : 'ViennaTalk-Transpiler-Core'
}

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> buildEnv: aViennaNode [
	| envs |
	envs := Dictionary new.
	envs at: 'DEFAULT' put: Dictionary new.
	aViennaNode first label = 'DefinitionBlock'
		ifTrue: [ | env |
			env := envs at: 'DEFAULT'.
			aViennaNode
				do: [ :definitionBlock | 
					definitionBlock first label = 'StateDefinition'
						ifFalse: [ (self boundVariables: definitionBlock)
								do: [ :ident | env at: ident put: 'self ' , ident ] ] ] ]
		ifFalse: [ aViennaNode
				do: [ :moduleNode | 
					| moduleName |
					moduleName := moduleNode first.
					envs at: moduleName put: Dictionary new.
					moduleNode third
						do: [ :definitionBlock | 
							definitionBlock first label = 'StateDefinition'
								ifFalse: [ (self boundVariables: definitionBlock)
										do: [ :ident | 
											(envs at: moduleName) at: ident put: 'self ' , ident.
											(envs at: 'DEFAULT')
												at: moduleName , '`' , ident
												put: '(self at: ' , moduleName storeString , ') ' , ident ] ] ] ] ].
	^ envs
]

{ #category : #'code generation-statements' }
ViennaVDM2SmalltalkClass >> callStatement: aViennaNode env: aDictionary [
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ args
		ifEmpty: [ callee , ' value' ]
		ifNotEmpty: [ '(', callee , ' value: ', (' value: ' join: args), ')' ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> closureFromMethodSource: aString binds: binds [
	| header |
	header := ((aString readStream upTo: Character cr) trim readStream
		upTo: $:) , ':'.
	^ self
		stringStreamContents: [ :stream | 
			stream nextPut: $[.
			1 to: binds size do: [ :i | 
				stream nextPutAll: ' :arg'.
				i printOn: stream ].
			stream space.
			binds ifNotEmpty: [ stream nextPutAll: '| ' ].
			stream nextPutAll: 'self '.
			binds
				ifEmpty: [ stream
						nextPutAll: header;
						nextPutAll: ' nil' ]
				ifNotEmpty: [ stream
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
	^ (PharoClassInstaller
		make: [ :builder | 
	builder
		name: documentClassName asSymbol;
		superclass: ViennaTranspiledObject;
		slots:
			(anArrayOfString1 asArray
				collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
				,
					(anArrayOfString2 asArray
						collect: [ :instVarName | 
							(runtimeAssertionCheck = true
								ifTrue: [ ViennaStateSlot ]
								ifFalse: [ InstanceVariableSlot ]) named: instVarName asSymbol ]);
		category: 'Auto Generated from VDM' ])
		specification: source;
		yourself
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
	^ (PharoClassInstaller
		make: [ :builder | 
	builder
		name: className asSymbol;
		superclass: ViennaTranspiledObject;
		slots:
			(anArrayOfString1 asArray
				collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
				,
					(anArrayOfString2 asArray
						collect: [ :instVarName | 
							(runtimeAssertionCheck = true
								ifTrue: [ ViennaStateSlot ]
								ifFalse: [ InstanceVariableSlot ]) named: instVarName asSymbol ]);
		category: 'Auto Generated from VDM' ])
		viennaEnv: aDictionary;
		specification: source;
		yourself
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineInitTypeMethodForTypeNames: typeNames in: aClass protocol: protocol node: aViennaNode [
	self
		defineMethod:
			'initTypes '
				,
					('. '
						join:
							(typeNames
								collect: [ :typeName | typeName , ' := self ' , typeName , ' removeTypeHolders' ]))
		in: aClass
		protocol: protocol
		node: aViennaNode
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineLazyMethodNamed: selector initializer: initializer in: aClass protocol: protocol node: aViennaNode [
	^ self
		defineMethod:
			selector , String cr , '^ ' , selector , ' ifNil: [' , initializer , '.' , selector , ']'
		in: aClass
		protocol: protocol
		node: aViennaNode
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineMethod: sourceString in: aClass protocol: protocol node: aViennaNode [
	| sourceAST formattedSource formattedAST formatMap map selector |
	selector := aClass
		compile:
			(formattedSource := (sourceAST := RBParser parseMethod: sourceString asString)
				formattedCode)
		classified: protocol.
	formattedAST := (aClass compiledMethodAt: selector) methodNode.
	formatMap := IdentityDictionary new.
	formatMap at: sourceAST put: formattedAST.
	sourceAST allChildren
		with: formattedAST allChildren
		do: [ :sourceNode :formattedNode | formatMap at: sourceNode put: formattedNode ].
	map := IdentityDictionary new.
	formatMap
		keysAndValuesDo: [ :sourceNode :formattedNode | 
			| start end s e n |
			start := sourceNode start.
			end := sourceNode stop.
			s := 0.
			e := Float fmax.
			n := nil.
			sourceString asViennaTracingString sources
				do: [ :assoc | 
					| sourceRange vdmNode |
					sourceRange := assoc key.
					vdmNode := assoc value.
					(sourceRange first <= start and: [ sourceRange last >= end ])
						ifTrue: [ | first last |
							first := sourceRange first.
							last := sourceRange last.
							(s <= first and: [ e >= last ])
								ifTrue: [ s := first.
									e := last.
									n := vdmNode ] ] ].
			map at: formattedNode put: n ].
	aClass specificationAt: selector put: aViennaNode.
	aClass debuggerNodeMapAt: selector put: map
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineMethodFromExplicitOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode [
	^ self
		defineMethodFromOperation: opName
		in: theClass
		protocol: protocolString
		fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
		body: bodyString
		pre: preString
		post: postString
		retVar: 'RESULT'
		retType: typeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode
		bodyNode: aViennaNode fifth
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> defineMethodFromOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retVar: retVarName retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode bodyNode: aViennaNode2 [
	| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars argVars formalArgs |
	tmpVars := OrderedCollection new.
	matchPatternNodes := OrderedCollection new.
	argVars := OrderedCollection new.
	formalArgs := OrderedCollection new.
	self
		defineMethod:
			(self
				stringStreamContents: [ :stream | 
					stream nextPutAll: opName.
					anArrayOfPatternNodeAndTypeSetNode isEmpty
						ifTrue: [ stream nextPutAll: ': ' , varGenerator value ].
					isFirstArg := true.
					self
						fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
						patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
							bindType = #identifier
								ifTrue: [ argVars add: patternNode first.
									isFirstArg
										ifFalse: [ stream nextPutAll: ' _' ].
									formalArgs add: patternNode first -> setNode.
									stream
										nextPutAll: ':';
										nextPutAll: patternNode first ].
							bindType = #compound
								ifTrue: [ | tmpVar |
									argVars addAll: (self boundVariables: patternNode).
									tmpVar := varGenerator value.
									tmpVars add: tmpVar.
									formalArgs add: tmpVar -> setNode.
									matchPatternNodes add: patternNode.
									isFirstArg
										ifFalse: [ stream nextPutAll: ' _' ].
									stream
										nextPutAll: ':';
										nextPutAll: tmpVar ].
							isFirstArg := false ].
					tuplePattern := ViennaNode
						label: 'TuplePattern'
						with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
					matchVars := (self boundVariables: tuplePattern) asArray.
					stream cr.
					matchVars
						ifEmpty: [ stream nextPutAll: '| _oldState ' , retVarName , ' |' ]
						ifNotEmpty: [ stream nextPutAll: ' | _oldState ' , retVarName , ' '.
							matchVars
								do: [ :var | 
									stream
										nextPutAll: var;
										nextPut: Character space ].
							stream
								nextPutAll: '| ';
								nextPutAll:
									(self
										binder: (self generate: tuplePattern env: aDictionary)
										with: '{' , (' . ' join: tmpVars) , '}'
										vars: matchVars);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					runtimeTypeCheck = true
						ifTrue: [ formalArgs
								with: anArrayOfPatternNodeAndTypeSetNode
								do: [ :assoc :triple | 
									stream
										nextPutAll:
											('((' , (self generate: assoc value env: aDictionary) , ') includes: ' , assoc key
												, ') ifFalse: [ViennaRuntimeTypeError signal].'
												asViennaTracingString: triple second) ] ].
					preString
						ifNotNil: [ stream
								nextPutAll:
									('(' , preString , ') ifFalse: [ViennaPreconditionViolation signal].'
										asViennaTracingString:
											(preString asViennaTracingString sources
												ifNotEmpty: [ :sources | sources last value ]
												ifEmpty: [ aViennaNode ])) ].
					stream
						nextPutAll: '_oldState := self state. ';
						nextPutAll:
							(retVarName , ' := self _' , opName
								, ((' _: ' join: argVars) ifNotEmpty: [ :str | '_: ' , str ] ifEmpty: [ '' ])
								, '.' asViennaTracingString: aViennaNode).
					(runtimeTypeCheck = true and: [ typeNode label ~= 'UnitType' ])
						ifTrue: [ stream
								nextPutAll:
									('(' , (self generate: typeNode env: aDictionary) , ' includes: ' , retVarName
										, ') ifFalse: [ViennaRuntimeTypeError signal].' asViennaTracingString: typeNode) ].
					postString
						ifNotNil: [ stream
								nextPutAll:
									('(' , postString , ') ifFalse: [ViennaPostconditionViolation signal].'
										asViennaTracingString:
											(postString asViennaTracingString sources
												ifNotEmpty: [ :sources | sources last value ]
												ifEmpty: [ aViennaNode ])) ].
					stream nextPutAll: '^ ' , retVarName ])
		in: theClass
		protocol: protocolString
		node: aViennaNode.
	^ self
		defineMethod:
			((self
				stringStreamContents: [ :stream | 
					stream
						nextPut: $_;
						nextPutAll: opName.
					argVars
						do: [ :var | 
							stream
								nextPutAll: '_: ';
								nextPutAll: var;
								nextPutAll: ' ' ].
					stream
						cr;
						nextPutAll: bodyString ]) asViennaTracingString: aViennaNode2)
		in: theClass
		protocol: protocolString
		node: aViennaNode2
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> explicitFunctionDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super
		explicitFunctionDefinition: aViennaNode
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode seventh
		ifNotNil: [ self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode seventh ].
	aViennaNode eighth
		ifNotNil: [ self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode eighth ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> explicitOperationDefinition: aViennaNode env: aDictionary [
	| opname typeNode paramsNode body preNode postNode varGenerator argTypeNode retTypeNode binds theClass |
	opname := aViennaNode first.
	typeNode := aViennaNode second.
	paramsNode := aViennaNode fourth.
	body := self generate: aViennaNode fifth env: aDictionary.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	argTypeNode := typeNode first.
	retTypeNode := typeNode second.
	binds := argTypeNode label = 'UnitType'
		ifTrue: [ {} ]
		ifFalse: [ argTypeNode label = 'ProductType'
				ifTrue: [ (1 to: argTypeNode size)
						collect: [ :index | 
							{(paramsNode at: index).
							(argTypeNode at: index)} ] ]
				ifFalse: [ {{paramsNode first.
					argTypeNode}} ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromExplicitOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre:
			(preNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ (self generate: preNode env: aDictionary) asViennaTracingString: preNode ]
						ifFalse: [ nil ] ])
		post:
			(postNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ (self generate: postNode env: aDictionary) asViennaTracingString: postNode ]
						ifFalse: [ nil ] ])
		retType: retTypeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := '
				,
					(self
						stringStreamContents: [ :stream | 
							stream nextPut: $[.
							1 to: binds size do: [ :i | 
								stream
									nextPutAll: ' :arg';
									nextPutAll: i printString ].
							binds ifNotEmpty: [ stream nextPut: $| ].
							stream
								nextPutAll: 'self ';
								nextPutAll: opname.
							binds
								ifEmpty: [ stream nextPutAll: ': nil' ]
								ifNotEmpty: [ stream nextPutAll: ': arg1 '.
									2 to: binds size do: [ :i | 
										stream
											nextPutAll: '_: arg';
											nextPutAll: i printString;
											space ] ].
							stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'pre_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'pre_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}}
										body: (self generate: preNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: preNode ].
	postNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'post_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'post_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}.
													{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
													nil}}
												,
													(retTypeNode label = 'UnitType'
														ifTrue: [ {} ]
														ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: 'RESULT').
															retTypeNode}} ])
										body: (self generate: postNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: postNode ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> extendedExplicitFunctionDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super
		extendedExplicitFunctionDefinition: aViennaNode
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode sixth
		ifNotNil: [ self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode sixth ].
	aViennaNode seventh
		ifNotNil: [ self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode seventh ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> extendedExplicitOperationDefinition: aViennaNode env: aDictionary [
	| opname patternTypePairListNode retVar retTypeNode bodyNode body preNode postNode varGenerator binds theClass |
	opname := aViennaNode first.
	patternTypePairListNode := aViennaNode second first
		ifNil: [ Array new ].
	retVar := aViennaNode third
		ifNil: [ 'RESULT' ]
		ifNotNil: [ :node | node first ].
	retTypeNode := aViennaNode third
		ifNil: [ ViennaNode label: 'UnitType' ]
		ifNotNil: [ :node | node second ].
	bodyNode := aViennaNode fourth.
	body := self generate: bodyNode.
	preNode := aViennaNode sixth.
	postNode := aViennaNode seventh.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	binds := Array
		new: 16
		streamContents: [ :stream | 
			1 to: patternTypePairListNode size by: 2 do: [ :index | 
				| patternListNode typeNode |
				patternListNode := patternTypePairListNode at: index.
				typeNode := patternTypePairListNode at: index + 1.
				patternListNode
					do: [ :patternNode | 
						stream
							nextPut:
								{patternNode.
								typeNode} ] ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre:
			(preNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: preNode env: aDictionary ]
						ifFalse: [ nil ] ])
		post:
			(postNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: postNode env: aDictionary ]
						ifFalse: [ nil ] ])
		retVar: retVar
		retType: retTypeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode
		bodyNode: bodyNode.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := '
				,
					(self
						stringStreamContents: [ :stream | 
							stream nextPut: $[.
							1 to: binds size do: [ :i | 
								stream
									nextPutAll: ' :arg';
									nextPutAll: i printString ].
							binds ifNotEmpty: [ stream nextPut: $| ].
							stream
								nextPutAll: 'self ';
								nextPutAll: opname.
							binds
								ifEmpty: [ stream nextPutAll: ': nil' ]
								ifNotEmpty: [ stream nextPutAll: ': arg1 '.
									2 to: binds size do: [ :i | 
										stream
											nextPutAll: '_: arg';
											nextPutAll: i printString;
											space ] ].
							stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'pre_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'pre_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}}
										body: (self generate: preNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: preNode ].
	postNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'post_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'post_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}.
													{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
													nil}}
												,
													(retTypeNode label = 'UnitType'
														ifTrue: [ {} ]
														ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: retVar).
															retTypeNode}} ])
										body: (self generate: postNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: postNode ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> flatDocument: aViennaNode env: aDictionary [
	| env instVars stateVars typeNames newClass |
	env := aDictionary copy.
	stateVars := #().
	typeNames := Array new writeStream.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ | stateDefinition |
					stateDefinition := definitionBlock first.
					stateVars := stateDefinition second collect: #first.
					env at: stateDefinition first put: 'self ' , stateDefinition first ].
			definitionBlock first label = 'TypeDefinitions'
				ifTrue: [ typeNames nextPutAll: (self boundVariables: definitionBlock first) ] ].
	typeNames := typeNames contents.
	instVars := (self boundVariables: aViennaNode)
		removeAll: stateVars;
		asArray.
	newClass := self createDocumentClassWithInstVars: instVars stateVars: stateVars.
	classes at: nil put: newClass.
	aViennaNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifFalse: [ (self boundVariables: definitionBlock)
						do: [ :ident | env at: ident put: 'self ' , ident ] ] ].
	self
		defineMethod: 'initialize super initialize. self initTypes. self init'
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	aViennaNode do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	(newClass includesSelector: #init)
		ifFalse: [ self defineMethod: 'init' in: newClass protocol: 'state' node: nil ].
	newClass viennaEnv: env.
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

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> getStateCode [
	^ 'self state'
]

{ #category : #'code generation-expressions' }
ViennaVDM2SmalltalkClass >> globalName: aViennaNode env: aDictionary [
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ (aDictionary at: aViennaNode first ifAbsent: [ aViennaNode first ]) , String space , aViennaNode second ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> implicitFunctionDefinition: aViennaNode env: aDictionary [
	| identifier initializer theClass |
	identifier := aViennaNode first.
	initializer := super
		implicitFunctionDefinition: aViennaNode
		env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode fifth
		ifNotNil: [ self
				defineLazyMethodNamed: 'pre_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode fifth ].
	aViennaNode sixth
		ifNotNil: [ self
				defineLazyMethodNamed: 'post_' , identifier
				initializer: initializer
				in: theClass
				protocol: 'functions'
				node: aViennaNode sixth ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> implicitOperationDefinition: aViennaNode env: aDictionary [
	| opname patternTypePairListNode retVar retTypeNode bodyNode body preNode postNode varGenerator binds theClass |
	opname := aViennaNode first.
	patternTypePairListNode := aViennaNode second first.
	retVar := aViennaNode third first.
	retTypeNode := aViennaNode third second.
	bodyNode := aViennaNode.
	body := 'ViennaImplicitEvaluationError signal: '
		, (opname , ' is implicitly defined.') storeString.
	preNode := aViennaNode fourth second.
	postNode := aViennaNode fourth third.
	varGenerator := self
		varNameGenerator: 'op'
		uniqueIn:
			{opname.
			body}.
	binds := Array
		new: 16
		streamContents: [ :stream | 
			1 to: patternTypePairListNode size by: 2 do: [ :index | 
				| patternListNode typeNode |
				patternListNode := patternTypePairListNode at: index.
				typeNode := patternTypePairListNode at: index + 1.
				patternListNode
					do: [ :patternNode | 
						stream
							nextPut:
								{patternNode.
								typeNode} ] ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre:
			(preNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: preNode env: aDictionary ]
						ifFalse: [ nil ] ])
		post:
			(postNode
				ifNotNil: [ runtimeAssertionCheck = true
						ifTrue: [ self generate: postNode env: aDictionary ]
						ifFalse: [ nil ] ])
		retVar: retVar
		retType: retTypeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode
		bodyNode: bodyNode.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := '
				,
					(self
						stringStreamContents: [ :stream | 
							stream nextPut: $[.
							1 to: binds size do: [ :i | 
								stream
									nextPutAll: ' :arg';
									nextPutAll: i printString ].
							binds ifNotEmpty: [ stream nextPut: $| ].
							stream
								nextPutAll: 'self ';
								nextPutAll: opname.
							binds
								ifEmpty: [ stream nextPutAll: ': nil' ]
								ifNotEmpty: [ stream nextPutAll: ': arg1 '.
									2 to: binds size do: [ :i | 
										stream
											nextPutAll: '_: arg';
											nextPutAll: i printString;
											space ] ].
							stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'pre_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'pre_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}}
										body: (self generate: preNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: preNode ].
	postNode
		ifNotNil: [ | env |
			env := aDictionary copy.
			aViennaNode
				stateVariablesDo: [ :var | env at: var put: '(_State at: ' , var storeString , ')' ].
			self
				defineLazyMethodNamed: 'post_' , opname
				initializer:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'post_';
								nextPutAll: opname;
								nextPutAll: ' := ';
								nextPutAll:
									(self
										closureFromFlatBinds:
											binds
												,
													{{(ViennaNode label: 'PatternIdentifier' with: '_State').
													nil}.
													{(ViennaNode label: 'PatternIdentifier' with: '_oldState').
													nil}}
												,
													(retTypeNode label = 'UnitType'
														ifTrue: [ {} ]
														ifFalse: [ {{(ViennaNode label: 'PatternIdentifier' with: retVar).
															retTypeNode}} ])
										body: (self generate: postNode env: env)
										varGenerator: varGenerator
										env: env) ])
				in: theClass
				protocol: 'operations'
				node: postNode ]
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
	| moduleNames classNames documentClass |
	moduleNames := aViennaNode collect: #first.
	documentClass := self
		createDocumentClassWithInstVars: (moduleNames collect: #uncapitalized).
	classNames := moduleNames
		collect: [ :moduleName | 
			(self requestClassName: moduleName for: moduleName , ' module')
				ifNil: [ ^ nil ]
				ifNotNil: [ :name | 
					aDictionary at: moduleName put: name.
					name ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	self
		defineMethod:
			(self
				stringStreamContents: [ :stream | 
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
		protocol: 'initialize-release'
		node: nil.
	moduleNames
		do: [ :moduleName | 
			self
				defineMethod: moduleName , ' ^' , moduleName uncapitalized
				in: documentClass
				protocol: 'accessing'
				node: nil ].
	documentClass viennaEnv: aDictionary.
	^ documentClass
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> module: aViennaNode env: aDictionary [
	| env moduleName interfaceNode moduleBodyNode importModuleNames importClassNames instVars stateVars typeNames newClass |
	env := aDictionary copy.
	self generate: aViennaNode second env: env.
	moduleName := aViennaNode first.
	interfaceNode := aViennaNode second.
	moduleBodyNode := aViennaNode third.
	importModuleNames := interfaceNode first
		ifNil: [ Array new ]
		ifNotNil: [ :importDefinitionListNode | 
			importDefinitionListNode
				collect: [ :importDefinitionNode | importDefinitionNode first ] ].
	importClassNames := importModuleNames
		collect:
			[ :importModuleName | env at: importModuleName first ifAbsent: [ importModuleName ] ].
	stateVars := #().
	typeNames := Array new writeStream.
	moduleBodyNode
		do: [ :definitionBlock | 
			definitionBlock first label = 'StateDefinition'
				ifTrue: [ | stateDefinition |
					stateDefinition := definitionBlock first.
					stateVars := stateDefinition second collect: #first.
					env at: stateDefinition first put: 'self ' , stateDefinition first ]
				ifFalse: [ (self boundVariables: definitionBlock)
						do: [ :ident | env at: ident put: 'self ' , ident ] ].
			definitionBlock first label = 'TypeDefinitions'
				ifTrue: [ typeNames nextPutAll: (self boundVariables: definitionBlock first) ] ].
	typeNames := typeNames contents.
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
					importModuleName , ':' , 'a' , importClassName capitalized , String cr
						, importModuleName , ' := ' , 'a' , importClassName capitalized
				in: newClass
				protocol: 'imports'
				node: (interfaceNode first detect: [ :node | node first = importModuleName ]) ].
	moduleBodyNode
		do: [ :definitionBlock | self definitionBlock: definitionBlock env: env ].
	self
		defineMethod: 'initialize super initialize. self initTypes'
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	(newClass includesSelector: #init)
		ifFalse: [ self
				defineMethod: 'init'
				in: newClass
				protocol: 'state'
				node: nil ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> noCheckAssignment: aVarName be: aValString [
	^ 'self instVarNamed: ' , aVarName storeString , ' put: ' , aValString
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
	| identifier fieldList type initializer theClass |
	identifier := aViennaNode first.
	fieldList := self generate: aViennaNode second env: aDictionary.
	type := 'ViennaCompositeType constructorName: '
		, identifier storeString , ' withAll: {' , (' . ' join: fieldList)
		, '}'.
	(self generate: aViennaNode third env: aDictionary)
		ifNotNil: [ :inv | type := '(' , type , ') inv: ' , inv ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier
		, ' type: (' , type , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'
		node: aViennaNode
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
	| theClass stateConstructor quin |
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	stateConstructor := aViennaNode first.
	quin := super stateDefinition: aViennaNode env: aDictionary.
	self
		defineMethod: 'init' , String cr , quin first
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: quin second
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: quin third
		in: theClass
		protocol: 'state'
		node: aViennaNode fourth.
	aDictionary at: 'init_' , stateConstructor put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr , '    ^ self ' , stateConstructor , ' applyTo: {'
				, (' . ' join: (aViennaNode second collect: #first)) , '}'
		in: theClass
		protocol: 'state'
		node: nil.
	(quin fourth notNil or: [ runtimeTypeCheck = true ])
		ifTrue: [ self
				defineMethod:
					(self
						stringStreamContents: [ :stream | 
							stream
								nextPutAll: 'inv';
								cr.
							quin fourth
								ifNotNil: [ stream
										nextPutAll: '    ((' , quin fourth , ') value: self state) ifFalse: [self stateInvariantViolation].';
										cr ].
							runtimeTypeCheck = true
								ifTrue: [ aViennaNode second
										do: [ :triple | 
											stream
												nextPutAll: '((';
												nextPutAll: (self generate: triple third env: aDictionary);
												nextPutAll: ') includes: (';
												nextPutAll: triple first;
												nextPutAll: ')) ifFalse: [ViennaRuntimeTypeError signal].' ] ] ])
				in: theClass
				protocol: 'state'
				node: nil ].
	self
		defineMethod: 'state' , String cr , '    ^' , quin fifth
		in: theClass
		protocol: 'state'
		node: nil
]

{ #category : #utilities }
ViennaVDM2SmalltalkClass >> tracingString [
	^ ViennaTracingString new
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkClass >> typeDefinition: aViennaNode env: aDictionary [
	| identifier type inv initializer theClass |
	identifier := aViennaNode first.
	type := self generate: aViennaNode second env: aDictionary.
	inv := (self generate: aViennaNode third env: aDictionary)
		ifNil: [ '' ]
		ifNotNil: [ :str | ' inv: ' , str ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier , ' type: (' , type
		, inv , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types' node: aViennaNode
]

{ #category : #'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> typeImport: aViennaNode env: aDictionary [
	| moduleName |
	moduleName := (aViennaNode parentLabelled: 'ImportDefinition' ifAbsent: [ nil ])
		ifNotNil: [ :importDefinition | importDefinition first ]
		ifNil: [ ^ self error: 'Malformed AST: TypeImport must appear under ImportDefinition' ].
	aViennaNode second
		ifNotNil: [ :renameNode | aDictionary at: renameNode first put: moduleName , String space , aViennaNode first first first ]
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
						protocol: 'values'
						node: node ] ]
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

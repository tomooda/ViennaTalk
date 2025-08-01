Class {
	#name : 'ViennaVDM2SmalltalkClass',
	#superclass : 'ViennaVDM2Smalltalk',
	#instVars : [
		'classes'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> buildEnv: aViennaNode [

	| envs |
	envs := Dictionary new.
	envs at: 'DEFAULT' put: Dictionary new.
	aViennaNode isViennaFlatDocumentNode
		ifTrue: [
			| env |
			env := envs at: 'DEFAULT'.
			aViennaNode do: [ :section |
				section isViennaStateDefinitionNode ifFalse: [
					section uniqueBoundIdentifiersDo: [ :ident |
						env at: ident put: 'self ' , ident ] ] ] ]
		ifFalse: [
			aViennaNode do: [ :moduleNode |
				| moduleName |
				moduleName := moduleNode identifier.
				envs at: moduleName put: Dictionary new.
				moduleNode moduleBody do: [ :section |
					section isViennaStateDefinitionNode ifFalse: [
						section uniqueBoundIdentifiersDo: [ :ident |
							(envs at: moduleName) at: ident put: 'self ' , ident.
							(envs at: 'DEFAULT')
								at: moduleName , '`' , ident
								put: '(self at: ' , moduleName storeString , ') ' , ident ] ] ] ] ].
	^ envs
]

{ #category : 'code generation-statements' }
ViennaVDM2SmalltalkClass >> callStatement: aViennaNode env: aDictionary [

	             | callee args |
	             callee := self
		                       generate: aViennaNode name
		                       env: aDictionary.
	             args := self
		                     generate: aViennaNode expressionList
		                     env: aDictionary.
	             ^ args
		               ifEmpty: [ callee , ' value' ]
		               ifNotEmpty: [
		               '(' , callee , ' value: ' , (' value: ' join: args)
		               , ')' ]
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> checkInvariant [

	^ 'self inv.'
]

{ #category : 'utilities' }
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

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> createDocumentClassWithInstVars: anArrayOfString [
	^ self createDocumentClassWithInstVars: anArrayOfString stateVars: #()
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> createDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 [

	| documentClassName |
	documentClassName := self requestClassName: '' for: 'Document'.
	documentClassName ifNil: [ ^ nil ].
	^ (ShiftClassInstaller make: [ :builder |
				   builder
					   name: documentClassName asSymbol;
					   superclass: ViennaTranspiledObject;
					   slots: (anArrayOfString1 asArray collect: [ :instVarName |
								    InstanceVariableSlot named: instVarName asSymbol ])
						   , (anArrayOfString2 asArray collect: [ :instVarName |
										    runtimeAssertionCheck = true
											    ifTrue: [
													    (ViennaFullStateVariableSlot named:
															     instVarName asSymbol)
														    checksInvariant: runtimeAssertionCheck;
														    yourself ]
											    ifFalse: [
											    ViennaStateVariableSlot named: instVarName asSymbol ] ]);
					   package: 'Auto Generated from VDM' ])
		  specification: source;
		  yourself
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> createModuleClass: aString withInstVars: anArrayOfString env: aDictionary [

	^ self
		  createModuleClass: aString
		  withInstVars: anArrayOfString
		  stateVars: #(  )
		  env: aDictionary
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> createModuleClass: aString withInstVars: anArrayOfString1 stateVars: anArrayOfString2 env: aDictionary [

	^ (ShiftClassInstaller make: [ :builder |
				   builder
					   name: aString asSymbol;
					   superclass: ViennaTranspiledObject;
					   slots: (anArrayOfString1 asArray collect: [ :instVarName |
								    InstanceVariableSlot named: instVarName asSymbol ])
						   , (anArrayOfString2 asArray collect: [ :instVarName |
										    runtimeAssertionCheck = true
											    ifTrue: [
													    (ViennaFullStateVariableSlot named:
															     instVarName asSymbol)
														    checksInvariant: runtimeAssertionCheck;
														    yourself ]
											    ifFalse: [
											    ViennaStateVariableSlot named: instVarName asSymbol ] ]);
					   package: 'Auto Generated from VDM' ])
		  viennaEnv: aDictionary;
		  specification: source;
		  yourself
]

{ #category : 'utilities' }
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

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> defineLazyMethodNamed: selector initializer: initializer in: aClass protocol: protocol node: aViennaNode [
	^ self
		defineMethod:
			selector , String cr , '^ ' , selector , ' ifNil: [' , initializer , '.' , selector , ']'
		in: aClass
		protocol: protocol
		node: aViennaNode
]

{ #category : 'utilities' }
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

{ #category : 'utilities' }
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
		  bodyNode: aViennaNode statement
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> defineMethodFromOperation: opName in: theClass protocol: protocolString fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: bodyString pre: preString post: postString retVar: retVarName retType: typeNode varGenerator: varGenerator env: aDictionary node: aViennaNode bodyNode: aViennaNode2 [

	| tmpVars matchPatternNodes isFirstArg tuplePattern matchVars argVars formalArgs |
	tmpVars := OrderedCollection new.
	matchPatternNodes := OrderedCollection new.
	argVars := OrderedCollection new.
	formalArgs := OrderedCollection new.
	self
		defineMethod: (self stringStreamContents: [ :stream |
				 stream nextPutAll: opName.
				 anArrayOfPatternNodeAndTypeSetNode isEmpty ifTrue: [
					 stream nextPutAll: ': ' , varGenerator value ].
				 isFirstArg := true.
				 self
					 fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
					 patternNodeAndSetOrTypeNodeAndBindTypesDo: [
						 :patternNode
						 :setNode
						 :bindType |
						 bindType = #identifier ifTrue: [
							 argVars add: patternNode first.
							 isFirstArg ifFalse: [ stream nextPutAll: ' _' ].
							 formalArgs add: patternNode first -> setNode.
							 stream
								 nextPutAll: ':';
								 nextPutAll: patternNode first ].
						 bindType = #compound ifTrue: [
							 | tmpVar |
							 argVars addAll: patternNode uniqueBoundIdentifiers.
							 tmpVar := varGenerator value.
							 tmpVars add: tmpVar.
							 formalArgs add: tmpVar -> setNode.
							 matchPatternNodes add: patternNode.
							 isFirstArg ifFalse: [ stream nextPutAll: ' _' ].
							 stream
								 nextPutAll: ':';
								 nextPutAll: tmpVar ].
						 isFirstArg := false ].
				 tuplePattern := ViennaTuplePatternNode patternList:
					                 (ViennaPatternListNode keepParentsWithAll:
						                  matchPatternNodes).
				 matchVars := tuplePattern uniqueBoundIdentifiers.
				 stream cr.
				 matchVars
					 ifEmpty: [
					 stream nextPutAll: '| _oldState ' , retVarName , ' |' ]
					 ifNotEmpty: [
						 stream nextPutAll: ' | _oldState ' , retVarName , ' '.
						 matchVars do: [ :var |
							 stream
								 nextPutAll: var;
								 nextPut: Character space ].
						 stream
							 nextPutAll: '| ';
							 nextPutAll: (self
									  binder: (self generate: tuplePattern env: aDictionary)
									  with: '{' , (' . ' join: tmpVars) , '}'
									  vars: matchVars);
							 nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
				 runtimeTypeCheck = true ifTrue: [
					 formalArgs
						 with: anArrayOfPatternNodeAndTypeSetNode
						 do: [ :assoc :triple |
							 stream nextPutAll:
								 ('((' , (self generate: assoc value env: aDictionary)
								  , ') includes: ' , assoc key
								  , ') ifFalse: [ViennaRuntimeTypeError signal].'
									  asViennaTracingString: triple second) ] ].
				 preString ifNotNil: [
					 (preString isArray
						  ifTrue: [ preString ]
						  ifFalse: [ { preString } ]) do: [ :pre |
						 stream nextPutAll:
							 ('(' , pre
							  , ') ifFalse: [ViennaPreconditionViolation signal].'
								  asViennaTracingString: (pre asViennaTracingString sources
										   ifNotEmpty: [ :sources | sources last value ]
										   ifEmpty: [ aViennaNode ])) ] ].
				 stream
					 nextPutAll: '_oldState := self state. ';
					 nextPutAll:
						 (retVarName , ' := self _' , opName , ((' _: ' join: argVars)
								   ifNotEmpty: [ :str | '_: ' , str ]
								   ifEmpty: [ '' ]) , '.' asViennaTracingString: aViennaNode).
				 (runtimeTypeCheck = true and: [
					  typeNode isViennaUnitTypeNode not ]) ifTrue: [
					 stream nextPutAll:
						 ('(' , (self generate: typeNode env: aDictionary)
						  , ' includes: ' , retVarName
						  , ') ifFalse: [ViennaRuntimeTypeError signal].'
							  asViennaTracingString: typeNode) ].
				 postString ifNotNil: [
					 (postString isArray
						  ifTrue: [ postString ]
						  ifFalse: [ { postString } ]) do: [ :post |
						 stream nextPutAll:
							 ('(' , post
							  , ') ifFalse: [ViennaPostconditionViolation signal].'
								  asViennaTracingString: (post asViennaTracingString sources
										   ifNotEmpty: [ :sources | sources last value ]
										   ifEmpty: [ aViennaNode ])) ] ].
				 stream nextPutAll: '^ ' , retVarName ])
		in: theClass
		protocol: protocolString
		node: aViennaNode.
	^ self
		  defineMethod: ((self stringStreamContents: [ :stream |
				    stream
					    nextPut: $_;
					    nextPutAll: opName.
				    argVars do: [ :var |
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

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> explicitFunctionDefinition: aViennaNode env: aDictionary [

	| identifier initializer theClass |
	identifier := aViennaNode identifier.
	initializer := super
		               explicitFunctionDefinition: aViennaNode
		               env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode pre ifNotNil: [
		self
			defineLazyMethodNamed: 'pre_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode pre ].
	aViennaNode post ifNotNil: [
		self
			defineLazyMethodNamed: 'post_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode post ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> explicitOperationDefinition: aViennaNode env: aDictionary [

	| opname typeNode paramsNode body preNode postNode varGenerator argTypeNode retTypeNode binds theClass |
	opname := aViennaNode identifier.
	typeNode := aViennaNode type.
	paramsNode := aViennaNode parameters.
	body := self generate: aViennaNode statement env: aDictionary.
	preNode := aViennaNode pre.
	postNode := aViennaNode post.
	varGenerator := self varNameGenerator: 'op' uniqueIn: {
			                opname.
			                body }.
	argTypeNode := typeNode first.
	retTypeNode := typeNode second.
	binds := argTypeNode isViennaUnitTypeNode
		         ifTrue: [ {  } ]
		         ifFalse: [
			         argTypeNode isViennaProductTypeNode
				         ifTrue: [
					         (1 to: argTypeNode size) collect: [ :index |
						         {
							         (paramsNode at: index).
							         (argTypeNode at: index) } ] ]
				         ifFalse: [
					         { {
						         paramsNode first.
						         argTypeNode } } ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineMethodFromExplicitOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre: (preNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 preNode asArrayOfConjuncts collect: [ :pre |
							 (self generate: pre env: aDictionary) asViennaTracingString:
								 pre ] ]
					 ifFalse: [ nil ] ])
		post: (postNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 postNode asArrayOfConjuncts collect: [ :post |
							 (self generate: post env: aDictionary) asViennaTracingString:
								 post ] ]
					 ifFalse: [ nil ] ])
		retType: retTypeNode
		varGenerator: varGenerator
		env: aDictionary
		node: aViennaNode.
	self
		defineLazyMethodNamed: opname
		initializer:
			opname , ' := ' , (self stringStreamContents: [ :stream |
				 stream nextPut: $[.
				 1 to: binds size do: [ :i |
					 stream
						 nextPutAll: ' :arg';
						 nextPutAll: i printString ].
				 binds ifNotEmpty: [ stream nextPut: $| ].
				 stream
					 nextPutAll: 'self ';
					 nextPutAll: opname.
				 binds ifEmpty: [ stream nextPutAll: ': nil' ] ifNotEmpty: [
					 stream nextPutAll: ': arg1 '.
					 2 to: binds size do: [ :i |
						 stream
							 nextPutAll: '_: arg';
							 nextPutAll: i printString;
							 space ] ].
				 stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'pre_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'pre_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , { {
											  (ViennaPatternIdentifierNode identifier: '_State').
											  nil } }
								  body: (self generate: preNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: preNode ].
	postNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'post_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'post_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , {
											  {
												  (ViennaPatternIdentifierNode identifier: '_State').
												  nil }.
											  {
												  (ViennaPatternIdentifierNode identifier: '_oldState').
												  nil } } , (retTypeNode isViennaUnitTypeNode
											   ifTrue: [ {  } ]
											   ifFalse: [
												   { {
													   (ViennaPatternIdentifierNode identifier: 'RESULT').
													   retTypeNode } } ])
								  body: (self generate: postNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: postNode ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> extendedExplicitFunctionDefinition: aViennaNode env: aDictionary [

	| identifier initializer theClass |
	identifier := aViennaNode identifier.
	initializer := super
		               extendedExplicitFunctionDefinition: aViennaNode
		               env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode pre ifNotNil: [
		self
			defineLazyMethodNamed: 'pre_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode pre ].
	aViennaNode post ifNotNil: [
		self
			defineLazyMethodNamed: 'post_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode post ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> extendedExplicitOperationDefinition: aViennaNode env: aDictionary [

	| opname patternTypePairListNode retVar retTypeNode bodyNode body preNode postNode varGenerator binds theClass |
	opname := aViennaNode identifier.
	patternTypePairListNode := aViennaNode patternTypePairList ifNil: [
		                           Array new ].
	retVar := aViennaNode identifierTypePairList
		          ifNil: [ 'RESULT' ]
		          ifNotNil: [ :node | node first identifier ].
	retTypeNode := aViennaNode identifierTypePairList
		               ifNil: [ ViennaUnitTypeNode new ]
		               ifNotNil: [ :node | node second ].
	bodyNode := aViennaNode statement.
	body := self generate: bodyNode.
	preNode := aViennaNode pre.
	postNode := aViennaNode post.
	varGenerator := self varNameGenerator: 'op' uniqueIn: {
			                opname.
			                body }.
	binds := Array new: 16 streamContents: [ :stream |
		         1 to: patternTypePairListNode size by: 2 do: [ :index |
			         | patternListNode typeNode |
			         patternListNode := patternTypePairListNode at: index.
			         typeNode := patternTypePairListNode at: index + 1.
			         patternListNode do: [ :patternNode |
				         stream nextPut: {
						         patternNode.
						         typeNode } ] ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre: (preNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 preNode asArrayOfConjuncts collect: [ :pre |
							 self generate: pre env: aDictionary ] ]
					 ifFalse: [ nil ] ])
		post: (postNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 postNode asArrayOfConjuncts collect: [ :post |
							 self generate: post env: aDictionary ] ]
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
			opname , ' := ' , (self stringStreamContents: [ :stream |
				 stream nextPut: $[.
				 1 to: binds size do: [ :i |
					 stream
						 nextPutAll: ' :arg';
						 nextPutAll: i printString ].
				 binds ifNotEmpty: [ stream nextPut: $| ].
				 stream
					 nextPutAll: 'self ';
					 nextPutAll: opname.
				 binds ifEmpty: [ stream nextPutAll: ': nil' ] ifNotEmpty: [
					 stream nextPutAll: ': arg1 '.
					 2 to: binds size do: [ :i |
						 stream
							 nextPutAll: '_: arg';
							 nextPutAll: i printString;
							 space ] ].
				 stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'pre_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'pre_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , { {
											  (ViennaPatternIdentifierNode identifier: '_State').
											  nil } }
								  body: (self generate: preNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: preNode ].
	postNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'post_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'post_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , {
											  {
												  (ViennaPatternIdentifierNode identifier: '_State').
												  nil }.
											  {
												  (ViennaPatternIdentifierNode identifier: '_oldState').
												  nil } } , (retTypeNode isViennaUnitTypeNode
											   ifTrue: [ {  } ]
											   ifFalse: [
												   { {
													   (ViennaPatternIdentifierNode identifier: retVar).
													   retTypeNode } } ])
								  body: (self generate: postNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: postNode ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> flatDocument: aViennaNode env: aDictionary [

	| env instVars stateVars typeNames newClass |
	env := aDictionary copy.
	stateVars := #(  ).
	typeNames := Array new writeStream.
	aViennaNode do: [ :section |
		section isViennaStateDefinitionNode ifTrue: [
			| stateDefinition |
			stateDefinition := section.
			stateVars := stateDefinition fieldList collect: #identifier.
			env
				at: stateDefinition first
				put: 'self ' , stateDefinition identifier ].
		section isViennaTypeDefinitionsNode ifTrue: [
			section do: [ :typeDef | typeNames nextPut: typeDef identifier ] ] ].
	typeNames := typeNames contents.
	instVars := aViennaNode uniqueBoundIdentifiers copyWithoutAll:
		            stateVars.
	newClass := self
		            createDocumentClassWithInstVars: instVars
		            stateVars: stateVars.
	classes at: nil put: newClass.
	aViennaNode do: [ :section |
		section isViennaStateDefinitionNode ifFalse: [
			section uniqueBoundIdentifiersDo: [ :ident |
				env at: ident put: 'self ' , ident ] ] ].
	self
		defineMethod:
		'initialize super initialize. self initTypes. self init'
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	aViennaNode do: [ :section | self generate: section env: env ].
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	(newClass includesSelector: #init) ifFalse: [
		self
			defineMethod: 'init'
			in: newClass
			protocol: 'state'
			node: nil ].
	newClass viennaEnv: env.
	^ newClass
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> functionImport: aViennaNode env: aDictionary [

	| moduleName |
	moduleName := (aViennaNode
		               detectParent: #isViennaImportDefinitionNode
		               ifNone: [ nil ])
		              ifNotNil: [ :importDefinition |
		              importDefinition moduleIdentifier ]
		              ifNil: [
			              ^ self error:
				                'Malformed AST: FunctionImport must appear under ImportDefinition' ].
	aViennaNode fourth ifNotNil: [ :renameNode |
		aDictionary
			at: renameNode first
			put: moduleName , String space , aViennaNode first first ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> getStateCode [
	^ 'self state'
]

{ #category : 'code generation-expressions' }
ViennaVDM2SmalltalkClass >> globalName: aViennaNode env: aDictionary [
	^ aDictionary
		at: aViennaNode first , '`' , aViennaNode second
		ifAbsent: [ (aDictionary at: aViennaNode first ifAbsent: [ aViennaNode first ]) , String space , aViennaNode second ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> implicitFunctionDefinition: aViennaNode env: aDictionary [

	| identifier initializer theClass |
	identifier := aViennaNode identifier.
	initializer := super
		               implicitFunctionDefinition: aViennaNode
		               env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'functions'
		node: aViennaNode.
	aViennaNode pre ifNotNil: [
		self
			defineLazyMethodNamed: 'pre_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode pre ].
	aViennaNode post ifNotNil: [
		self
			defineLazyMethodNamed: 'post_' , identifier
			initializer: initializer
			in: theClass
			protocol: 'functions'
			node: aViennaNode post ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> implicitOperationDefinition: aViennaNode env: aDictionary [

	| opname patternTypePairListNode retVar retTypeNode bodyNode body preNode postNode varGenerator binds theClass |
	opname := aViennaNode identifier.
	patternTypePairListNode := aViennaNode patternTypePairList.
	retVar := aViennaNode identifierTypePairList first identifier.
	retTypeNode := aViennaNode identifierTypePairList second.
	bodyNode := aViennaNode.
	body := 'ViennaImplicitEvaluationError signal: '
	        , (opname , ' is implicitly defined.') storeString.
	preNode := aViennaNode pre.
	postNode := aViennaNode post.
	varGenerator := self varNameGenerator: 'op' uniqueIn: {
			                opname.
			                body }.
	binds := Array new: 16 streamContents: [ :stream |
		         1 to: patternTypePairListNode size by: 2 do: [ :index |
			         | patternListNode typeNode |
			         patternListNode := patternTypePairListNode at: index.
			         typeNode := patternTypePairListNode at: index + 1.
			         patternListNode do: [ :patternNode |
				         stream nextPut: {
						         patternNode.
						         typeNode } ] ] ].
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineMethodFromOperation: opname
		in: theClass
		protocol: 'operations'
		fromFlatBinds: binds
		body: body
		pre: (preNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 preNode asArrayOfConjuncts collect: [ :pre |
							 self generate: pre env: aDictionary ] ]
					 ifFalse: [ nil ] ])
		post: (postNode ifNotNil: [
				 runtimeAssertionCheck = true
					 ifTrue: [
						 postNode asArrayOfConjuncts collect: [ :post |
							 self generate: post env: aDictionary ] ]
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
			opname , ' := ' , (self stringStreamContents: [ :stream |
				 stream nextPut: $[.
				 1 to: binds size do: [ :i |
					 stream
						 nextPutAll: ' :arg';
						 nextPutAll: i printString ].
				 binds ifNotEmpty: [ stream nextPut: $| ].
				 stream
					 nextPutAll: 'self ';
					 nextPutAll: opname.
				 binds ifEmpty: [ stream nextPutAll: ': nil' ] ifNotEmpty: [
					 stream nextPutAll: ': arg1 '.
					 2 to: binds size do: [ :i |
						 stream
							 nextPutAll: '_: arg';
							 nextPutAll: i printString;
							 space ] ].
				 stream nextPut: $] ])
		in: theClass
		protocol: 'operations'
		node: aViennaNode.
	preNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'pre_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'pre_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , { {
											  (ViennaPatternIdentifierNode identifier: '_State').
											  nil } }
								  body: (self generate: preNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: preNode ].
	postNode ifNotNil: [
		| env |
		env := aDictionary copy.
		aViennaNode stateVariablesDo: [ :var |
			env at: var put: '(_State at: ' , var storeString , ')' ].
		self
			defineLazyMethodNamed: 'post_' , opname
			initializer: (self stringStreamContents: [ :stream |
					 stream
						 nextPutAll: 'post_';
						 nextPutAll: opname;
						 nextPutAll: ' := ';
						 nextPutAll: (self
								  closureFromFlatBinds: binds , {
											  {
												  (ViennaPatternIdentifierNode identifier: '_State').
												  nil }.
											  {
												  (ViennaPatternIdentifierNode identifier: '_oldState').
												  nil } } , (retTypeNode isViennaUnitTypeNode
											   ifTrue: [ {  } ]
											   ifFalse: [
												   { {
													   (ViennaPatternIdentifierNode identifier: retVar).
													   retTypeNode } } ])
								  body: (self generate: postNode env: env)
								  varGenerator: varGenerator
								  env: env) ])
			in: theClass
			protocol: 'operations'
			node: postNode ]
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> importDefinition: aViennaNode env: aDictionary [
	| moduleName importModuleSignatureNode |
	moduleName := aViennaNode first.
	importModuleSignatureNode := aViennaNode second.
	importModuleSignatureNode do: [ :node | self generate: node env: aDictionary ]
]

{ #category : 'initialize-release' }
ViennaVDM2SmalltalkClass >> initialize [
	super initialize.
	classes := Dictionary new
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> modularDocument: aViennaNode env: aDictionary [

	| moduleNames classNames documentClass |
	moduleNames := aViennaNode collect: #identifier.
	documentClass := self createDocumentClassWithInstVars:
		                 (moduleNames collect: #uncapitalized).
	classNames := moduleNames collect: [ :moduleName |
		              (self
			               requestClassName: moduleName
			               for: moduleName , ' module')
			              ifNil: [ ^ nil ]
			              ifNotNil: [ :name |
				              aDictionary at: moduleName put: name.
				              name ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	self
		defineMethod: (self stringStreamContents: [ :stream |
				 stream
					 nextPutAll: 'initialize';
					 cr;
					 nextPutAll: 'super initialize.';
					 cr.
				 moduleNames with: classNames do: [ :moduleName :className |
					 stream
						 nextPutAll: moduleName uncapitalized;
						 nextPutAll: ' := ';
						 nextPutAll: className;
						 nextPutAll: ' new _document: self; yourself.';
						 cr ].
				 aViennaNode do: [ :moduleNode |
					 | moduleName |
					 moduleName := moduleNode identifier.
					 moduleNode interface importDefinitionList ifNotNil: [
						 :importDefinitionListNode |
						 importDefinitionListNode do: [ :importDefinitionNode |
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
				 moduleNames do: [ :moduleName |
					 stream
						 nextPutAll: moduleName uncapitalized;
						 nextPutAll: ' initTypes.';
						 cr ].
				 moduleNames do: [ :moduleName |
					 stream
						 nextPutAll: moduleName uncapitalized;
						 nextPutAll: ' init.';
						 cr ] ])
		in: documentClass
		protocol: 'initialize-release'
		node: nil.
	moduleNames do: [ :moduleName |
		self
			defineMethod: moduleName , ' ^' , moduleName uncapitalized
			in: documentClass
			protocol: 'accessing'
			node: nil ].
	self
		defineMethod:
			'state ^ {' , ('.' join: (moduleNames collect: [ :name |
					  name storeString , '->' , name uncapitalized , ' state' ]))
			, '} asDictionary'
		in: documentClass
		protocol: 'accessing'
		node: nil.
	self
		defineMethod:
			'state: _state ' , ('. ' join: (moduleNames collect: [ :name |
					  '_state at: ' , name storeString , ' ifPresent: [:s | '
					  , name uncapitalized , ' state: s]' ]))
		in: documentClass
		protocol: 'accessing'
		node: nil.
	documentClass viennaEnv: aDictionary.
	^ documentClass
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> module: aViennaNode env: aDictionary [

	| env moduleName interfaceNode moduleBodyNode importModuleNames importClassNames instVars stateVars typeNames newClass |
	env := aDictionary copy.
	moduleName := aViennaNode identifier.
	interfaceNode := aViennaNode interface.
	moduleBodyNode := aViennaNode moduleBody.
	self generate: interfaceNode env: env.
	importModuleNames := interfaceNode first
		                     ifNil: [ Array new ]
		                     ifNotNil: [ :importDefinitionListNode |
			                     importDefinitionListNode collect: [
				                     :importDefinitionNode |
				                     importDefinitionNode first ] ].
	importClassNames := importModuleNames collect: [ :importModuleName |
		                    env
			                    at: importModuleName
			                    ifAbsent: [ importModuleName ] ].
	stateVars := #(  ).
	typeNames := Array new writeStream.
	moduleBodyNode do: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [
				| stateDefinition |
				stateDefinition := section.
				stateVars := stateDefinition fieldList collect: #identifier.
				env
					at: stateDefinition identifier
					put: 'self ' , stateDefinition identifier ]
			ifFalse: [
				section uniqueBoundIdentifiersDo: [ :ident |
					env at: ident put: 'self ' , ident ] ].
		section isViennaTypeDefinitionsNode ifTrue: [
			section do: [ :typeDef | typeNames nextPut: typeDef identifier ] ] ].
	typeNames := typeNames contents.
	instVars := moduleBodyNode uniqueBoundIdentifiers copyWithoutAll:
		            stateVars.
	newClass := self
		            createModuleClass:
		            (defaultEnv at: moduleName ifAbsent: [ moduleName ])
		            withInstVars: importClassNames , instVars
		            stateVars: stateVars
		            env: env.
	classes at: moduleName put: newClass.
	importModuleNames
		with: importClassNames
		do: [ :importModuleName :importClassName |
			self
				defineMethod:
					importModuleName , ':' , 'a' , importModuleName capitalized
					, String cr , importClassName , ' := ' , 'a'
					, importModuleName capitalized
				in: newClass
				protocol: 'imports'
				node:
				(interfaceNode first detect: [ :node |
					 node first = importModuleName ]) ].
	moduleBodyNode do: [ :section | self generate: section env: env ].
	self
		defineInitTypeMethodForTypeNames: typeNames
		in: newClass
		protocol: 'initialize-release'
		node: nil.
	(newClass includesSelector: #init) ifFalse: [
		self
			defineMethod: 'init'
			in: newClass
			protocol: 'state'
			node: nil ]
]

{ #category : 'code generation-traces' }
ViennaVDM2SmalltalkClass >> namedTrace: aViennaNode env: aDictionary [

	| name trace theClass |
	name := aViennaNode identifier.
	trace := self
		         generate: aViennaNode traceDefinitionList
		         env: aDictionary.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineMethod:
			name , ': _interimBlock onError: _handlerBlock' , String cr
			, '|_generator | _generator := ' , trace
			,
			'. [[self init. _generator next: (Dictionary new)] whileTrue: _interimBlock. _interimBlock value] on: ViennaTraceException do: [:_ex | _handlerBlock cull: _ex]'
		in: theClass
		protocol: 'traces'
		node: aViennaNode.
	self
		defineMethod:
			name , ': _interimBlock' , String cr
			, '|_generator | _generator := ' , trace
			,
			'. [self init. _generator next: Dictionary new] whileTrue: _interimBlock. _interimBlock value'
		in: theClass
		protocol: 'traces'
		node: aViennaNode.
	self
		defineMethod: name , String cr , 'self ' , name , ': []'
		in: theClass
		protocol: 'traces'
		node: aViennaNode
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> noCheckAssignment: aVarName be: aValString [

	^ 'self class slotNamed: ' , aVarName storeString
	  , ' ifFound: [ :slot | slot basicWrite: (' , aValString
	  , ') to: self]'
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> operationImport: aViennaNode env: aDictionary [

	| moduleName |
	moduleName := (aViennaNode
		               detectParent: #isViennaImportDefinitionNode
		               ifNone: [ nil ])
		              ifNotNil: [ :importDefinition |
		              importDefinition moduleIdentifier ]
		              ifNil: [
			              ^ self error:
				                'Malformed AST: OperationImport must appear under ImportDefinition' ].
	aViennaNode third ifNotNil: [ :renameNode |
		aDictionary
			at: renameNode first
			put: moduleName , String space , aViennaNode first first ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> recordTypeDefinition: aViennaNode env: aDictionary [

	| identifier fieldList type initializer theClass |
	identifier := aViennaNode identifier.
	fieldList := self generate: aViennaNode fieldList env: aDictionary.
	type := 'ViennaCompositeType constructorName: '
	        , identifier storeString , ' withAll: {'
	        , (' . ' join: fieldList) , '}'.
	(self generate: aViennaNode inv env: aDictionary) ifNotNil: [ :inv |
		type := '(' , type , ') inv: ' , inv ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier
	               , ' type: (' , type , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'
		node: aViennaNode
]

{ #category : 'utilities' }
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

{ #category : 'code generation-statements' }
ViennaVDM2SmalltalkClass >> returnStatement: aViennaNode env: aDictionary [
	^ '^ '
		,
			(aViennaNode first
				ifNil: [ ' self' ]
				ifNotNil: [ :arg | self generate: arg env: aDictionary ])
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> stateDefinition: aViennaNode env: aDictionary [

	| theClass stateConstructor hexa |
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	stateConstructor := aViennaNode identifier.
	hexa := super stateDefinition: aViennaNode env: aDictionary.
	self
		defineMethod: 'init' , String cr , hexa first
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	self
		defineLazyMethodNamed: stateConstructor
		initializer: hexa second
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	aDictionary at: stateConstructor put: 'self ' , stateConstructor.
	self
		defineLazyMethodNamed: 'init_' , stateConstructor
		initializer: hexa third
		in: theClass
		protocol: 'state'
		node: aViennaNode init.
	aDictionary
		at: 'inv_' , stateConstructor
		put: 'self inv_' , stateConstructor.
	hexa fourth ifNotNil: [
			self
				defineLazyMethodNamed: 'inv_' , stateConstructor
				initializer: hexa fourth
				in: theClass
				protocol: 'state'
				node: aViennaNode inv ].
	aDictionary
		at: 'init_' , stateConstructor
		put: 'self init_' , stateConstructor.
	self
		defineMethod:
			'state' , String cr
			, ('^ self ' , stateConstructor , ' applyTo: {'
				 , (' . ' join: (aViennaNode fieldList collect: #identifier))
				 , '}' asViennaTracingString: aViennaNode init)
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	(hexa fourth notNil or: [ runtimeTypeCheck = true ]) ifTrue: [
			self
				defineMethod: (self stringStreamContents: [ :stream |
							 stream
								 nextPutAll: 'inv';
								 cr.
							 hexa fourth ifNotNil: [
									 | patternNode varGenerator |
									 patternNode := aViennaNode inv invariantInitialFunction
										                pattern.
									 varGenerator := self varNameGenerator: 'func' uniqueIn: {  }.
									 stream
										 nextPutAll: (self
												  closureFromFlatBinds:
													  (Array with: (Array with: patternNode with: nil))
												  body: ('. ' join:
															   (aViennaNode inv expression asArrayOfConjuncts
																    collect: [ :inv |
																		    '(' , (self generate: inv env: aDictionary)
																		    ,
																			    ') ifFalse: [ViennaStateInvariantViolation signal]'
																			    asViennaTracingString: inv ]))
												  varGenerator: varGenerator
												  env: aDictionary);
										 nextPutAll: ' value: self state.';
										 cr ].
							 runtimeTypeCheck = true ifTrue: [
									 aViennaNode fieldList do: [ :field |
											 stream nextPutAll:
												 ('((' , (self generate: field type env: aDictionary)
												  , ') includes: (' , field identifier
												  , ')) ifFalse: [ViennaRuntimeTypeError signal].'
													  asViennaTracingString: field type) ] ] ])
				in: theClass
				protocol: 'state'
				node: aViennaNode ].
	self
		defineMethod: 'state' , String cr , '    ^' , hexa fifth
		in: theClass
		protocol: 'state'
		node: aViennaNode.
	self
		defineMethod: 'state: _state' , String cr , hexa sixth
		in: theClass
		protocol: 'state'
		node: aViennaNode
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> tracingString [
	^ ViennaTracingString new
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> typeImport: aViennaNode env: aDictionary [

	| moduleName |
	moduleName := (aViennaNode
		               detectParent: #isViennaImportDefinitionNode
		               ifNone: [ nil ])
		              ifNotNil: [ :importDefinition |
		              importDefinition first ]
		              ifNil: [
			              ^ self error:
				                'Malformed AST: TypeImport must appear under ImportDefinition' ].
	aViennaNode second ifNotNil: [ :renameNode |
		aDictionary
			at: renameNode first
			put: moduleName , String space , aViennaNode first first first ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> typeSynonym: aViennaNode env: aDictionary [

	| identifier type inv initializer theClass |
	identifier := aViennaNode identifier.
	type := self generate: aViennaNode type env: aDictionary.
	inv := (self generate: aViennaNode inv env: aDictionary)
		       ifNil: [ '' ]
		       ifNotNil: [ :str | ' inv: ' , str ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier
	               , ' type: (' , type , inv , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'
		node: aViennaNode
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkClass >> validateClassName: aString [

	aString ifEmpty: [ ^ false ].
	aString first isUppercase ifFalse: [ ^ false ].
	(aString allSatisfy: [ :char | char isAlphaNumeric or: [ char = $_ ] ])
		ifFalse: [ ^ false ].
	^ true
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkClass >> valueDefinitions: aViennaNode env: aDictionary [

	| theClass initializer |
	theClass := classes at: (aViennaNode module ifNotNil: #identifier).
	aViennaNode do: [ :node |
		initializer := self generate: node env: aDictionary.
		node uniqueBoundIdentifiersDo: [ :identifier |
			self
				defineLazyMethodNamed: identifier
				initializer: initializer , '. ' , identifier
				in: theClass
				protocol: 'values'
				node: node ] ]
]

{ #category : 'code generation-interfaces' }
ViennaVDM2SmalltalkClass >> valueImport: aViennaNode env: aDictionary [

	| moduleName |
	moduleName := (aViennaNode
		               detectParent: #isViennaImportDefinitionNode
		               ifNone: [ nil ])
		              ifNotNil: [ :importDefinition |
		              importDefinition first ]
		              ifNil: [
			              ^ self error:
				                'Malformed AST: ValueImport must appear under ImportDefinition' ].
	aViennaNode third ifNotNil: [ :renameNode |
		aDictionary
			at: renameNode first
			put: moduleName , String space , aViennaNode first first ]
]

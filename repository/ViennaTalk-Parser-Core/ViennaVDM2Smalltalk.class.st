Class {
	#name : #ViennaVDM2Smalltalk,
	#superclass : #Object,
	#traits : 'TViennaVDMFreeVariableCollector',
	#classTraits : 'TViennaVDMFreeVariableCollector classTrait',
	#instVars : [
		'decoder'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #utilities }
ViennaVDM2Smalltalk class >> translate: aString ifError: aBlock [
	self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk class >> translateExplicitFunction: aString ifError: aBlock [
	self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk class >> translateExplicitOperation: aString ifError: aBlock [
	self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk class >> translateExpression: aString ifError: aBlock [
	self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk class >> translateStatement: aString ifError: aBlock [
	self subclassResponsibility
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> accessFunctionDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode second env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> accessOperationDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode second env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> accessTypeDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode second env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> accessValueDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode second env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> actExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> activeExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> and: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' and: [' , arg2 , '])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> apply: aViennaNode env: aDictionary [
	| func args |
	func := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticAbs: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' abs'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticDivide: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' asFloat / ' , arg2 , ' asFloat)'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticIntegerDivision: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' asInteger // ' , arg2 , ' asInteger)'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMinus: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' - ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMod: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' \\ ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMultiplication: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' * ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticPlus: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' + ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticRem: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' rem: ' , arg2 , ')'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> assignStatement: aViennaNode env: aDictionary [
	| desig expr |
	desig := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	^ desig isString
		ifTrue: [ desig , ' := ' , expr ]
		ifFalse: [ 
			| ident path |
			ident := desig first.
			path := desig second.
			ident , ' := ' , ident , ' copyAtPath: {' , (' . ' join: path) , '} put: ' , expr ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> assignmentDefinition: aViennaNode env: aDictionary [
	^ aViennaNode third ifNotNil: [ aViennaNode first , ' := ' , (self generate: aViennaNode third env: aDictionary) ]
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> basicType: aViennaNode env: aDictionary [
	^ 'ViennaType ' , aViennaNode first
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> bindList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> binder: aBlockString with: aString vars: anArrayOfString [
	^ String
		new: 256
		streamContents: [ :stream | 
			stream
				nextPutAll: '((';
				nextPutAll: aBlockString;
				nextPutAll: ' value: ';
				nextPutAll: aString;
				nextPutAll: ') ifEmpty: [false] ifNotEmpty: [:binds | ';
				nextPutAll:
						('.'
								join:
									(anArrayOfString select: #notNil thenCollect: [ :varName | varName , ' := binds first at: ' , varName storeString ]));
				nextPutAll: '. true])' ]
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> blockStatement: aViennaNode env: aDictionary [
	| statements vars |
	statements := OrderedCollection new: aViennaNode size.
	vars := self boundVariables: aViennaNode.
	aViennaNode do: [ :node | (self generate: node env: aDictionary) ifNotNil: [ :statement | statements add: statement ] ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			vars
				ifNotEmpty: [ 
					stream nextPutAll: '[| '.
					vars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream nextPutAll: '| ' ].
			stream nextPutAll: ('.' join: statements).
			vars ifNotEmpty: [ stream nextPutAll: '] value.' ] ]
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> callStatement: aViennaNode env: aDictionary [
	| callee args |
	callee := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ callee , ' valueWithArguments: {' , (' . ' join: args) , '}'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> casesExpression: aViennaNode env: aDictionary [
	| valueExpr patternListAndExpressions defaultExpression varGenerator valueVar foundVar resultVar |
	valueExpr := self generate: aViennaNode first env: aDictionary.
	patternListAndExpressions := self generate: aViennaNode second env: aDictionary.
	defaultExpression := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'cases'
		uniqueIn:
			(Array with: valueExpr with: (defaultExpression ifNil: [ '' ])) , (patternListAndExpressions collect: #second).
	valueVar := varGenerator value.
	foundVar := varGenerator value.
	resultVar := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: '(';
				nextPutAll: valueExpr;
				nextPutAll: ' in: [:';
				nextPutAll: valueVar;
				nextPutAll: '||';
				nextPutAll: foundVar;
				nextPutAll: ' ';
				nextPutAll: resultVar;
				nextPutAll: '| ';
				nextPutAll: foundVar;
				nextPutAll: ' := false.'.
			patternListAndExpressions
				with: aViennaNode second asArray
				do: [ :patternListAndExpression :alternativeNode | 
					| patList expr |
					patList := patternListAndExpression first.
					expr := patternListAndExpression second.
					patList
						with: alternativeNode first asArray
						do: [ :pat :patternNode | 
							| vars binder |
							vars := (self boundVariables: patternNode) asArray.
							binder := self binder: pat with: valueVar vars: vars.
							stream
								nextPutAll: foundVar;
								nextPutAll: ' ifFalse: [|';
								nextPutAll: (' ' join: vars);
								nextPutAll: '| ';
								nextPutAll: binder;
								nextPutAll: ' ifTrue: [';
								nextPutAll: foundVar;
								nextPutAll: ' := true.';
								nextPutAll: resultVar;
								nextPutAll: ' := ';
								nextPutAll: expr;
								nextPutAll: ']].' ] ].
			stream
				nextPutAll: foundVar;
				nextPutAll: ' ifFalse: [';
				nextPutAll: resultVar;
				nextPutAll: ' := ';
				nextPutAll: (defaultExpression ifNil: [ 'ViennaNoMatch signal' ]);
				nextPutAll: '].';
				nextPutAll: resultVar;
				nextPutAll: '])' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> casesExpressionAlternative: aViennaNode env: aDictionary [
	| patlist expr |
	patlist := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	^ {patlist.
	expr}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> casesExpressionAlternatives: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> casesStatement: aViennaNode env: aDictionary [
	| valueExpr patternListAndStatements defaultStatement varGenerator valueVar foundVar resultVar |
	valueExpr := self generate: aViennaNode first env: aDictionary.
	patternListAndStatements := self generate: aViennaNode second env: aDictionary.
	defaultStatement := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'cases'
		uniqueIn: (Array with: valueExpr with: (defaultStatement ifNil: [ '' ])) , (patternListAndStatements collect: #second).
	valueVar := varGenerator value.
	foundVar := varGenerator value.
	resultVar := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: '(';
				nextPutAll: valueExpr;
				nextPutAll: ' in: [:';
				nextPutAll: valueVar;
				nextPutAll: '||';
				nextPutAll: foundVar;
				nextPutAll: ' ';
				nextPutAll: resultVar;
				nextPutAll: '| ';
				nextPutAll: foundVar;
				nextPutAll: ' := false.'.
			patternListAndStatements
				with: aViennaNode second asArray
				do: [ :patternListAndStatement :alternativeNode | 
					| patList expr |
					patList := patternListAndStatement first.
					expr := patternListAndStatement second.
					patList
						with: alternativeNode first asArray
						do: [ :pat :patternNode | 
							| vars binder |
							vars := (self boundVariables: patternNode) asArray.
							binder := self binder: pat with: valueVar vars: vars.
							stream
								nextPutAll: foundVar;
								nextPutAll: ' ifFalse: [|';
								nextPutAll: (' ' join: vars);
								nextPutAll: '| ';
								nextPutAll: binder;
								nextPutAll: ' ifTrue: [';
								nextPutAll: foundVar;
								nextPutAll: ' := true.';
								nextPutAll: resultVar;
								nextPutAll: ' := ';
								nextPutAll: expr;
								nextPutAll: ']].' ] ].
			stream
				nextPutAll: foundVar;
				nextPutAll: ' ifFalse: [';
				nextPutAll: resultVar;
				nextPutAll: ' := ';
				nextPutAll: (defaultStatement ifNil: [ 'ViennaNoMatch signal' ]);
				nextPutAll: '].';
				nextPutAll: resultVar;
				nextPutAll: '])' ]
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> casesStatementAlternative: aViennaNode env: aDictionary [
	| patlist statement |
	patlist := self generate: aViennaNode first env: aDictionary.
	statement := self generate: aViennaNode second env: aDictionary.
	^ {patlist.
	statement}
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> casesStatementAlternatives: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> closureFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary [
	^ String
		new: 1024
		streamContents: [ :stream | 
			| tmpVars matchPatternNodes tuplePattern matchVars |
			tmpVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			stream nextPutAll: '['.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					bindType = #identifier
						ifTrue: [ 
							stream
								nextPutAll: ' :';
								nextPutAll: patternNode first ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							matchPatternNodes add: patternNode.
							stream
								nextPutAll: ' :';
								nextPutAll: tmpVar ] ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			anArrayOfPatternNodeAndTypeSetNode ifNotEmpty: [stream nextPutAll: ' | '].
			matchVars notEmpty
				ifTrue: [ 
					stream nextPutAll: ' | '.
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
				nextPutAll: aString;
				nextPutAll: ']' ]
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> collectDefinitions: aViennaNode [
	^ Array new: 32 streamContents: [ :stream | self definitions: aViennaNode do: [ :node | stream nextPut: node ] ]
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> compositeType: aViennaNode env: aDictionary [
	| constructorName fields |
	constructorName := self generate: aViennaNode first env: aDictionary.
	fields := aViennaNode second
		collect: [ :field | 
			'{' , field first storeString , ' . ' , field second storeString , ' . ' , (self generate: field third env: aDictionary)
				, '}' ].
	^ '(ViennaType compose: ' , constructorName storeString , ' of: {' , (' . ' join: fields) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> composition: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' comp: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> conditionalExpression: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> conditionalStatement: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> dclStatement: aViennaNode env: aDictionary [
	^ '. ' join: (self generateAll: aViennaNode env: aDictionary)
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> defExpression: aViennaNode env: aDictionary [
	| definitionList defs expr vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	defs := self generate: definitionList env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: aViennaNode first) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: defs) , ' ifFalse: [ViennaNoMatch signal].' , expr , '] value'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> defStatement: aViennaNode env: aDictionary [
	| defs statement vars |
	defs := self generate: aViennaNode first env: aDictionary.
	statement := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: aViennaNode first) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: defs) , ' ifFalse: [ViennaNoMatch signal].' , statement , '] value'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> definitionBlock: aViennaNode env: aDictionary [
	^ '.' , String cr join: (aViennaNode collect: [ :node | self generate: node env: aDictionary ])
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> definitions: aViennaNode do: aBlock [
	(#('AccessFunctionDefinition' 'AccessOperationDefinition' 'AccessValueDefinition' 'AccessTypeDefinition' 'StateDefinition')
		includes: aViennaNode label)
		ifTrue: [ ^ aBlock value: aViennaNode ].
	aViennaNode do: [ :node | self definitions: node do: aBlock ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedMapMerge: aViennaNode env: aDictionary [
	^ '(' , (self generate: aViennaNode first env: aDictionary)
		, ' in: [:s | | d | d := Dictionary new. s do: [:d1 | d addAll: d1]. d])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedSequenceConcatenation: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' concatenation asOrderedCollection'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedSetIntersection: aViennaNode env: aDictionary [
	| arg |
	arg := self generate: aViennaNode first env: aDictionary.
	^ '(' , arg
		,
			' asArray in: [ :sets | sets isEmpty ifTrue: [Set new] ifFalse: [(sets copyFrom: 2 to: sets size) inject: sets first into: [:inter :set | inter intersection: set]]])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedSetUnion: aViennaNode env: aDictionary [
	| arg |
	arg := self generate: aViennaNode first env: aDictionary.
	^ '(' , arg , ' inject: Set new into: [:union :set | union addAll: set; yourself])'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> document: aViennaNode env: aDictionary [
	^ aViennaNode first label = 'DefinitionBlock'
		ifTrue: [ self flatDocument: aViennaNode env: aDictionary ]
		ifFalse: [ self modularDocument: aViennaNode env: aDictionary ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> equal: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> equalDefinition: aViennaNode env: aDictionary [
	| leftNode left right |
	leftNode := aViennaNode first.
	(#('TypeBind' 'SetBind') includes: leftNode label)
		ifTrue: [ leftNode := leftNode first ].
	left := self generate: leftNode env: aDictionary.
	right := self generate: aViennaNode second env: aDictionary.
	^ leftNode label = 'PatternIdentifier'
		ifTrue: [ '[' , leftNode first , ' := ' , right , '. true] value' ]
		ifFalse: [ self binder: left with: right vars: (self boundVariables: aViennaNode) asArray ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> equalDefinitionList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> exists1Expression: aViennaNode env: aDictionary [
	| bindNode expr varGenerator |
	bindNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'exists1' uniqueIn: (Array with: expr).
	^ '('
		,
			(self
				generatorFromFlatBinds:
					{{(bindNode first).
					(bindNode second)}}
				selector: #onlyOneSatisfy:
				whenMatchFailed: 'false'
				body: expr
				varGenerator: varGenerator
				env: aDictionary) , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> existsExpression: aViennaNode env: aDictionary [
	| bindListNode expr varGenerator pair flatBinds setsAndVars |
	bindListNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'exists' uniqueIn: (Array with: expr).
	pair := self flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | ';
				nextPutAll:
						(self
								generatorFromFlatBinds: flatBinds
								selector: #anySatisfy:
								whenMatchFailed: 'false'
								body: expr
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> explicitFunctionDefinition: aViennaNode env: aDictionary [
	| funcName typeNode parametersListNode body varGenerator |
	funcName := aViennaNode first.
	typeNode := aViennaNode third.
	parametersListNode := aViennaNode fifth.
	body := self generate: aViennaNode sixth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'func'
		uniqueIn:
			{funcName.
			body}.
	parametersListNode asArray
		reverseDo: [ :parametersNode | 
			| argType binds |
			argType := typeNode first.
			typeNode := typeNode second.
			binds := argType label = 'ProductType'
				ifTrue: [ 
					(1 to: parametersNode size)
						collect: [ :index | 
							{(parametersNode at: index).
							(argType at: index)} ] ]
				ifFalse: [ 
					{{(parametersNode first).
					argType}} ].
			body := self
				closureFromFlatBinds: binds
				body: body
				varGenerator: varGenerator
				env: aDictionary ].
	^ funcName , ' := ' , body
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> explicitOperationDefinition: aViennaNode env: aDictionary [
	| opname typeNode paramsNode body varGenerator argTypeNode binds |
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
	^ opname , ' := ' , (self
		closureFromFlatBinds: binds
		body: body
		varGenerator: varGenerator
		env: aDictionary)
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> expressionList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> fieldList: aViennaNode env: aDictionary [
	^ aViennaNode
		collect: [ :field | 
			'{' , field first storeString , ' . ' , field second storeString , ' . ' , (self generate: field third env: aDictionary)
				, '}' ]
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> fieldPattern: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> fieldPatternList: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> fieldReference: aViennaNode env: aDictionary [
	| stateDesig field ident path |
	stateDesig := self generate: aViennaNode first env: aDictionary.
	field := self generate: aViennaNode second env: aDictionary.
	stateDesig isString
		ifTrue: [ 
			ident := stateDesig.
			path := Array new ]
		ifFalse: [ 
			ident := stateDesig first.
			path := stateDesig second ].
	^ {ident.
	(path copyWith: field storeString)}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> fieldSelect: aViennaNode env: aDictionary [
	| record field |
	record := self generate: aViennaNode first env: aDictionary.
	field := self generate: aViennaNode second env: aDictionary.
	^ '(' , record , ' at: ''' , field , ''')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> finExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> finitePowerSet: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' power'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> flatDocument: aViennaNode env: aDictionary [
	^ self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary [
	| setsAndVars |
	setsAndVars := OrderedCollection new: bindListNode size.
	^ {(Array
		new: 16
		streamContents: [ :stream | 
			bindListNode
				do: [ :multipleBindNode | 
					| typeOrSetNode varName localNameNode |
					typeOrSetNode := multipleBindNode second.
					varName := varGenerator value.
					localNameNode := ViennaNode label: 'LocalName' with: varName.
					setsAndVars
						add:
							{(typeOrSetNode label = 'SetRangeExpression'
								ifTrue: [ '(' , (self intervalExpression: typeOrSetNode env: aDictionary) , ')' ]
								ifFalse: [ 
									typeOrSetNode label = 'SequenceIndices'
										ifTrue: [ '(' , (self indicesExpression: typeOrSetNode env: aDictionary) , ')' ]
										ifFalse: [ self generate: typeOrSetNode env: aDictionary ] ]).
							varName}.
					multipleBindNode first
						do: [ :patternNode | 
							stream
								nextPut:
									{patternNode.
									localNameNode} ] ] ]).
	setsAndVars}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> floor: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' floor'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> forallExpression: aViennaNode env: aDictionary [
	| bindListNode expr varGenerator pair flatBinds setsAndVars |
	bindListNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'forall' uniqueIn: (Array with: expr).
	pair := self flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | ';
				nextPutAll:
						(self
								generatorFromFlatBinds: flatBinds
								selector: #allSatisfy:
								whenMatchFailed: 'true'
								body: expr
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> fromFlatBinds: patternsAndSets patternNodeAndSetOrTypeNodeAndBindTypesDo: aBlock [
	| boundVariables |
	boundVariables := patternsAndSets collect: [ :pair | self boundVariables: pair first ].
	1 to: patternsAndSets size do: [ :index | 
		| bindNode patternNode |
		bindNode := patternsAndSets at: index.
		patternNode := bindNode first.
		aBlock
			value: bindNode first
			value: bindNode second
			value:
				((patternNode label = 'PatternIdentifier'
					and: [ 
						(1 to: patternsAndSets size)
							allSatisfy: [ :i | i = index or: [ ((boundVariables at: i) includes: patternNode first) not ] ] ])
					ifTrue: [ #identifier ]
					ifFalse: [ #compound ]) ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> functionDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> functionDefinitions: aViennaNode env: aDictionary [
	self subclassResponsibility
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> functionTypeArgs: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> functionTypeInstantiation: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation' }
ViennaVDM2Smalltalk >> generate: aViennaNode [
	^ self generate: aViennaNode env: Dictionary new
]

{ #category : #'code generation' }
ViennaVDM2Smalltalk >> generate: aViennaNode env: aDictionary [
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	aViennaNode ifNil: [ ^ nil ].
	^ self perform: (aViennaNode label uncapitalized , ':env:') asSymbol with: aViennaNode with: aDictionary
]

{ #category : #'code generation' }
ViennaVDM2Smalltalk >> generateAll: aViennaNode env: aDictionary [
	^ aViennaNode collect: [ :node | self generate: node env: aDictionary ]
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode body: aString varGenerator: varGenerator env: aDictionary [
	^ self
		generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
		selector: #do:
		whenMatchFailed: nil
		body: aString
		varGenerator: varGenerator
		env: aDictionary
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> generatorFromFlatBinds: anArrayOfPatternNodeAndTypeSetNode selector: aSymbol whenMatchFailed: failString body: aString varGenerator: varGenerator env: aDictionary [
	^ String
		new: 1024
		streamContents: [ :stream | 
			| numParens tmpVars matchPatternNodes tuplePattern matchVars |
			numParens := 0.
			tmpVars := OrderedCollection new.
			matchPatternNodes := OrderedCollection new.
			self
				fromFlatBinds: anArrayOfPatternNodeAndTypeSetNode
				patternNodeAndSetOrTypeNodeAndBindTypesDo: [ :patternNode :setNode :bindType | 
					stream
						nextPutAll:
								(setNode label = 'SetRangeExpression'
										ifTrue: [ 
											(aSymbol = #do:
												ifTrue: [ '' ]
												ifFalse: [ '(' ]) , (self intervalExpression: setNode env: aDictionary)
												,
													(aSymbol = #do:
														ifTrue: [ '' ]
														ifFalse: [ ')' ]) ]
										ifFalse: [ 
											setNode label = 'SequenceIndices'
												ifTrue: [ 
													(aSymbol = #do:
														ifTrue: [ '' ]
														ifFalse: [ '(' ]) , (self indicesExpression: setNode env: aDictionary)
														,
															(aSymbol = #do:
																ifTrue: [ '' ]
																ifFalse: [ ')' ]) ]
												ifFalse: [ self generate: setNode env: aDictionary ] ]);
						nextPut: Character space;
						nextPutAll: aSymbol;
						nextPutAll: ' [ :'.
					bindType = #identifier
						ifTrue: [ stream nextPutAll: patternNode first ].
					bindType = #compound
						ifTrue: [ 
							| tmpVar |
							tmpVar := varGenerator value.
							tmpVars add: tmpVar.
							matchPatternNodes add: patternNode.
							stream nextPutAll: tmpVar ].
					stream nextPutAll: ' | '.
					numParens := numParens + 1 ].
			tuplePattern := ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: matchPatternNodes).
			matchVars := (self boundVariables: tuplePattern) asArray.
			matchVars notEmpty
				ifTrue: [ 
					stream nextPutAll: ' | '.
					matchVars
						do: [ :var | 
							stream
								nextPutAll: var;
								nextPut: Character space ].
					stream
						nextPutAll: '| ';
						nextPutAll:
								(self binder: (self generate: tuplePattern env: aDictionary) with: '{' , (' . ' join: tmpVars) , '}' vars: matchVars).
					failString
						ifNotNil: [ 
							stream
								nextPutAll: ' ifFalse: [';
								nextPutAll: failString;
								nextPutAll: ']' ].
					stream nextPutAll: ' ifTrue: [ '.
					numParens := numParens + 1 ].
			stream nextPutAll: aString.
			numParens timesRepeat: [ stream nextPut: $] ] ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> greaterThan: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' > ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> greaterThanOrEqual: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' >= ' , arg2 , ')'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> identityStatement: aViennaNode env: aDictionary [
	^ String new
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> ifExpression: aViennaNode env: aDictionary [
	| conditionals default |
	conditionals := self generateAll: aViennaNode first env: aDictionary.
	default := self generate: aViennaNode second env: aDictionary.
	^ '('
		,
			(conditionals
				inject: default
				into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ]) , ')'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> ifStatement: aViennaNode env: aDictionary [
	| conditionals default |
	conditionals := self generateAll: aViennaNode first env: aDictionary.
	default := self generate: aViennaNode second env: aDictionary.
	^ '('
		,
			(conditionals
				inject: (default ifNil: [ String new ])
				into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ]) , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> imply: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' not or: [' , arg2 , '])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> inSet: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg2 , ' includes: ' , arg1 , ')'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> indexForLoop: aViennaNode env: aDictionary [
	| ident start end step body |
	ident := self generate: aViennaNode first env: aDictionary.
	start := self generate: aViennaNode second env: aDictionary.
	end := self generate: aViennaNode third env: aDictionary.
	step := self generate: aViennaNode fourth env: aDictionary.
	body := self generate: aViennaNode fifth env: aDictionary.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPut: Character space;
				nextPutAll: start;
				nextPutAll: ' to: ';
				nextPutAll: end.
			step
				ifNotNil: [ 
					stream
						nextPutAll: ' by: ';
						nextPutAll: step ].
			stream
				nextPutAll: ' do: [:';
				nextPutAll: ident;
				nextPutAll: '|';
				nextPutAll: body;
				nextPutAll: ']' ]
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> indicesExpression: aViennaNode env: aDictionary [
	| seqNode |
	seqNode := self generate: aViennaNode first env: aDictionary.
	^ '1 to: ' , seqNode , ' size'
]

{ #category : #'initialize-release' }
ViennaVDM2Smalltalk >> initialize [
	super initialize.
	decoder := ViennaVDMValueDecoder new
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> inmapType: aViennaNode env: aDictionary [
	| domaintype rangetype |
	domaintype := self generate: aViennaNode first env: aDictionary.
	rangetype := self generate: aViennaNode second env: aDictionary.
	^ '(' , domaintype , ' inmapTo: ' , rangetype , ')'
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> intervalExpression: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ arg1 , ' to: ' , arg2
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> invariant: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> invariantInitialFunction: aViennaNode env: aDictionary [
	| patternNode expression varGenerator |
	patternNode := aViennaNode first.
	expression := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'inv' uniqueIn: {expression}.
	^ self
		closureFromFlatBinds: (Array with: (Array with: patternNode with: nil))
		body: expression
		varGenerator: varGenerator
		env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> iotaExpression: aViennaNode env: aDictionary [
	| bindNode expr varGenerator |
	bindNode := aViennaNode first.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'iota' uniqueIn: (Array with: expr).
	^ '('
		,
			(self
				generatorFromFlatBinds:
					{{(bindNode first).
					(bindNode second)}}
				selector: #detect:
				whenMatchFailed: 'false'
				body: expr
				varGenerator: varGenerator
				env: aDictionary) , ' ifNone: [ViennaNoMatch signal])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isBasicExpression: aViennaNode env: aDictionary [
	| name expression |
	name := self generate: aViennaNode first env: aDictionary.
	expression := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaType ' , name , ' includes: ' , expression , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isNameExpression: aViennaNode env: aDictionary [
	| name expression |
	name := self generate: aViennaNode first env: aDictionary.
	expression := self generate: aViennaNode second env: aDictionary.
	^ '(' , name , ' includes: ' , expression , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isNotYetSpecified: aViennaNode env: aDictionary [
	^ 'self notYetImplemented'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isSubclassResponsibility: aViennaNode env: aDictionary [
	^ 'self subclassResponsibility'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isofbaseclassExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> isofclassExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> iterate: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' ** ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> lambdaExpression: aViennaNode env: aDictionary [
	| body varGenerator |
	body := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
	^ self
		closureFromFlatBinds: aViennaNode first asArray
		body: body
		varGenerator: varGenerator
		env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> lessThan: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' < ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> lessThanOrEqual: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' <= ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> letBeExpression: aViennaNode env: aDictionary [
	| multibind guard expr varGenerator |
	multibind := self generate: aViennaNode first env: aDictionary.
	guard := self generate: aViennaNode second env: aDictionary.
	expr := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: expr).
	^ String
		new: 1024
		streamContents: [ :stream | 
			| patterns set vars |
			patterns := multibind first.
			set := multibind second.
			vars := (self boundVariables: aViennaNode first) asArray.
			stream
				nextPutAll: '[|';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|('.
			patterns
				with: aViennaNode first first asArray
				do: [ :pat :patternNode | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: set;
						nextPutAll: ' anySatisfy: [:';
						nextPutAll: loopVar;
						nextPutAll: '|';
						nextPutAll: (self binder: pat with: loopVar vars: (self boundVariables: patternNode) asArray);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream nextPutAll: guard.
			multibind first do: [ :pat | stream nextPut: $] ].
			stream
				nextPutAll: ') ifFalse: [NotFound signal].';
				nextPutAll: expr;
				nextPutAll: '] value' ]
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> letBeStatement: aViennaNode env: aDictionary [
	| multibind guard statement varGenerator |
	multibind := self generate: aViennaNode first env: aDictionary.
	guard := self generate: aViennaNode second env: aDictionary.
	statement := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: statement).
	^ String
		new: 1024
		streamContents: [ :stream | 
			| patterns set vars |
			patterns := multibind first.
			set := multibind second.
			vars := (self boundVariables: aViennaNode first) asArray.
			stream
				nextPutAll: '[|';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|('.
			patterns
				with: aViennaNode first first asArray
				do: [ :pat :patternNode | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: set;
						nextPutAll: ' anySatisfy: [:';
						nextPutAll: loopVar;
						nextPutAll: '|';
						nextPutAll: (self binder: pat with: loopVar vars: (self boundVariables: patternNode) asArray);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream nextPutAll: guard.
			multibind first do: [ :pat | stream nextPut: $] ].
			stream
				nextPutAll: ') ifFalse: [NotFound signal].';
				nextPutAll: statement;
				nextPutAll: '] value' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> letExpression: aViennaNode env: aDictionary [
	| definitionList localDefinitions body vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	localDefinitions := self generate: definitionList env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: definitionList) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: localDefinitions) , '.' , body , '] value'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> letStatement: aViennaNode env: aDictionary [
	| definitionList localDefinitions body vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	localDefinitions := self generate: definitionList env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	vars := (self boundVariables: definitionList) asArray.
	^ '[|' , (' ' join: vars) , '|' , ('.' join: localDefinitions) , '.' , body , '] value'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> localDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> localDefinitionList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> localName: aViennaNode env: aDictionary [
	| name |
	name := aViennaNode first.
	^ aDictionary at: name ifAbsent: [ name ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> logicalEquivalence: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapComprehension: aViennaNode env: aDictionary [
	| keyExpr valueExpr bindListNode guard varGenerator map pair flatBinds setsAndVars |
	keyExpr := self generate: aViennaNode first env: aDictionary.
	valueExpr := self generate: aViennaNode second env: aDictionary.
	bindListNode := aViennaNode third.
	guard := self generate: aViennaNode fourth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'map'
		uniqueIn:
			{keyExpr.
			valueExpr} , {(guard ifNil: [ '' ])}.
	map := varGenerator value.
	pair := self flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ String
		new: 1024
		streamContents: [ :stream | 
			| body |
			body := map , ' at: ' , keyExpr , ' put: ' , valueExpr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | | ' , map , ' | ' , map , ' :=Dictionary new.';
				nextPutAll:
						(self
								generatorFromFlatBinds: flatBinds
								body: body
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: map;
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapDomain: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' keys asSet'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapDomainRestrictedBy: aViennaNode env: aDictionary [
	| set map |
	set := self generate: aViennaNode first env: aDictionary.
	map := self generate: aViennaNode second env: aDictionary.
	^ '([:set :map | map copy keysAndValuesRemove: [:k :v | set includes: k]; yourself] value: ' , set , ' value: ' , map
		, ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapDomainRestrictedTo: aViennaNode env: aDictionary [
	| set map |
	set := self generate: aViennaNode first env: aDictionary.
	map := self generate: aViennaNode second env: aDictionary.
	^ '([:set :map | map copy keysAndValuesRemove: [:k :v | (set includes: k) not]; yourself] value: ' , set , ' value: '
		, map , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapEnumeration: aViennaNode env: aDictionary [
	| pairs |
	pairs := self generateAll: aViennaNode env: aDictionary.
	^ '{' , (' . ' join: (pairs collect: [ :pair | pair first , ' -> ' , pair second ])) , '} asDictionary'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> mapEnumerationPattern: aViennaNode env: aDictionary [
	| patternPairs |
	patternPairs := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchMapEnumeration: {'
		, (' . ' join: (patternPairs collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapInverse: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' inversed'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapMerge: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> mapMunionPattern: aViennaNode env: aDictionary [
	| pat1 pat2 |
	pat1 := self generate: aViennaNode first env: aDictionary.
	pat2 := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil match: ' , pat1 , ' munion: ' , pat2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapOrSequenceModify: aViennaNode env: aDictionary [
	| arg1 arg2 varGenerator |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'override' uniqueIn: (Array with: arg1 with: arg2).
	^ '[:mapOrSeq :map | map keysAndValuesDo: [:k :v | mapOrSeq at: k put: v]. mapOrSeq] value: ' , arg1 , ' copy value: '
		, arg2
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> mapOrSequenceReference: aViennaNode env: aDictionary [
	| stateDesig expr ident path |
	stateDesig := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	stateDesig isString
		ifTrue: [ 
			ident := stateDesig.
			path := Array new ]
		ifFalse: [ 
			ident := stateDesig first.
			path := stateDesig second ].
	^ {ident.
	(path copyWith: expr)}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapRange: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' values asSet'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapRangeRestrictedBy: aViennaNode env: aDictionary [
	| map set |
	map := self generate: aViennaNode first env: aDictionary.
	set := self generate: aViennaNode second env: aDictionary.
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | set includes: v]; yourself] value: ' , map , ' value: ' , set
		, ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapRangeRestrictedTo: aViennaNode env: aDictionary [
	| map set |
	map := self generate: aViennaNode first env: aDictionary.
	set := self generate: aViennaNode second env: aDictionary.
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | (set includes: v) not]; yourself] value: ' , map , ' value: '
		, set , ')'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> mapType: aViennaNode env: aDictionary [
	| domaintype rangetype |
	domaintype := self generate: aViennaNode first env: aDictionary.
	rangetype := self generate: aViennaNode second env: aDictionary.
	^ '(' , domaintype , ' mapTo: ' , rangetype , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> maplet: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapletList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> mapletPattern: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> matchValue: aViennaNode env: aDictionary [
	| literal |
	literal := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaRuntimeUtil matchValue: ' , literal , ')'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> modularDocument: aViennaNode env: aDictionary [
	^ self subclassResponsibility
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> multipleAssignStatement: aViennaNode env: aDictionary [
	| assigns |
	assigns := aViennaNode
		collect: [ :assign | 
			{(self generate: assign first env: aDictionary).
			(self generate: assign second env: aDictionary)} ].
	^ assigns size < 2
		ifTrue: [ PPFailure message: 'atom statement should have more than one statements' ]
		ifFalse: [ 
			| varGenerator tmps |
			varGenerator := self varNameGenerator: 'atom' uniqueIn: (assigns collect: #second).
			tmps := assigns collect: [ :assign | varGenerator value ].
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[| '.
					tmps
						do: [ :tmp | 
							stream
								nextPutAll: tmp;
								nextPutAll: ' ' ].
					stream nextPutAll: '| '.
					tmps
						with: assigns
						do: [ :tmp :assign | 
							stream
								nextPutAll: tmp;
								nextPutAll: ' := ';
								nextPutAll: assign second;
								nextPutAll: ' . ' ].
					tmps
						with: assigns
						do: [ :tmp :assign | 
							| desig |
							desig := assign first.
							desig isString
								ifTrue: [ 
									stream
										nextPutAll: desig;
										nextPutAll: ' := ';
										nextPutAll: tmp;
										nextPutAll: '. ' ]
								ifFalse: [ 
									| ident path |
									ident := desig first.
									path := desig second.
									stream
										nextPutAll: ident;
										nextPutAll: ' := ';
										nextPutAll: ident;
										nextPutAll: ' copyAtPath: {';
										nextPutAll: (' . ' join: path);
										nextPutAll: '} put: ';
										nextPutAll: tmp;
										nextPutAll: '. ' ] ].
					stream nextPutAll: '] value' ] ]
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> multipleSetBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> multipleTypeBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> nondeterministicStatement: aViennaNode env: aDictionary [
	^ 'ViennaRuntimeUtil shuffleDo: {' , ('.' join: ((self generateAll: aViennaNode env: aDictionary) collect: [ :s | '[' , s , ']' ]))
		, '}'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> not: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' not'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> notEqual: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' ~= ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> notInSet: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg2 , ' includes: ' , arg1 , ') not'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> objectPattern: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> oldName: aViennaNode env: aDictionary [
	| name |
	name := aViennaNode first , '~'.
	^ aDictionary at: name ifAbsent: [ name ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> operationBody: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> operationDefinition: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> operationDefinitions: aViennaNode env: aDictionary [
	^ self subclassResponsibility
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> optionalType: aViennaNode env: aDictionary [
	| baseType |
	baseType := self generate: aViennaNode first env: aDictionary.
	^ baseType , ' optional'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> or: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' or: [' , arg2 , '])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> othersExpression: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> othersStatement: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> parameters: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> parametersList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> partialFunctionType: aViennaNode env: aDictionary [
	| argType returnType |
	argType := self generate: aViennaNode first env: aDictionary.
	returnType := self generate: aViennaNode second env: aDictionary.
	^ '(' , argType , ' -> ' , returnType , ')'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> patternIdentifier: aViennaNode env: aDictionary [
	| identifierOrNil |
	identifierOrNil := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> patternList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> preconditionExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> productType: aViennaNode env: aDictionary [
	^ '(' , ('*' join: (self generateAll: aViennaNode env: aDictionary)) , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> properSubset: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '([:set1 :set2 | set1 size < set2 size and: [ set2 includesAll: set1 ]] value: ' , arg1 , ' value: ' , arg2 , ')'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> quoteType: aViennaNode env: aDictionary [
	| quote |
	quote := aViennaNode first.
	^ '(ViennaType quote: #' , (quote copyFrom: 2 to: quote size - 1) storeString , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> recordConstructor: aViennaNode env: aDictionary [
	| constructorName args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	args := '{', (' . ' join: (self generate: aViennaNode second env: aDictionary)), '}'.
	^ '(' , constructorName , ' applyTo: ' , args , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> recordModifier: aViennaNode env: aDictionary [
	| record modifiers |
	record := self generate: aViennaNode first env: aDictionary.
	modifiers := self generate: aViennaNode second env: aDictionary.
	^ '(' , record , ' copy '
		,
			('; '
				join:
					(modifiers collect: [ :fieldAndValue | ' at: ' , fieldAndValue first storeString , ' put: ' , fieldAndValue second ]))
		, '; yourself)'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> recordPattern: aViennaNode env: aDictionary [
	| constructorName argPatterns |
	constructorName := aViennaNode first.
	constructorName label = 'LocalName'
		ifTrue: [ constructorName := constructorName first ]
		ifFalse: [ constructorName := constructorName first , '`' , constructorName second ].
	argPatterns := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: argPatterns) , '})'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> recordTypeDefinition: aViennaNode env: aDictionary [
	| identifier fieldList type |
	identifier := aViennaNode first.
	fieldList := self generate: aViennaNode second env: aDictionary.
	type := 'ViennaCompositeType constructorName: ' , identifier storeString , ' withAll: {' , (' . ' join: fieldList)
		, '}'.
	(self generate: aViennaNode third env: aDictionary) ifNotNil: [ :inv | type := '(' , type , ') inv: ' , inv ].
	^ identifier , ' := ' , type
]

{ #category : #private }
ViennaVDM2Smalltalk >> reorderDefinitions: aCollectionOfViennaNode [
	| originalDefs env boundVars freeVars newDefs |
	originalDefs := Array withAll: aCollectionOfViennaNode.
	env := Dictionary new.
	boundVars := (originalDefs collect: [ :def | def -> (self boundVariables: def) asArray ]) asDictionary.
	freeVars := (originalDefs collect: [ :def | def -> (self freeVariables: def env: env) asArray ]) asDictionary.
	newDefs := OrderedCollection new: originalDefs size.
	[ originalDefs notEmpty ]
		whileTrue: [ 
			| allBoundVars index |
			allBoundVars := Set new: 1024.
			originalDefs do: [ :def | allBoundVars addAll: (boundVars at: def) ].
			index := (1 to: originalDefs size)
				detect: [ :i | ((freeVars at: (originalDefs at: i)) contains: [ :var | allBoundVars includes: var ]) not ]
				ifNone: [ ^ self error: 'Cyclic definition' ].
			newDefs add: (originalDefs at: index).
			originalDefs := originalDefs copyWithoutIndex: index ].
	^ newDefs asArray
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> reqExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> resultExpression: aViennaNode env: aDictionary [
	^ aDictionary at: 'RESULT' ifAbsent: [ 'RESULT' ]
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> returnStatement: aViennaNode env: aDictionary [
	^ 'thisContext viennaReturn: ' , (self generate: aViennaNode first)
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> samebaseclassExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sameclassExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> selfExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> seq1Type: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' seq1'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> seqConcPattern: aViennaNode env: aDictionary [
	| pat1 pat2 |
	pat1 := self generate: aViennaNode first env: aDictionary.
	pat2 := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil match: ' , pat1 , ' conc: ' , pat2
		, ((self seqPatternSize: aViennaNode first) ifNotNil: [ :size | ' left: ' , size printString ] ifNil: [ '' ])
		, ((self seqPatternSize: aViennaNode second) ifNotNil: [ :size | ' right: ' , size printString ] ifNil: [ '' ]) , ')'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> seqEnumPattern: aViennaNode env: aDictionary [
	| elementPatterns |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchSequenceEnumeration: {' , (' . ' join: elementPatterns) , '})'
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> seqPatternSize: aViennaNode [
	aViennaNode label = 'SeqEnumPattern'
		ifTrue: [ ^ aViennaNode size ].
	aViennaNode label = 'SeqConcPattern'
		ifTrue: [ 
			| left right |
			left := self seqPatternSize: aViennaNode first.
			right := self seqPatternSize: aViennaNode second.
			left ifNotNil: [ right ifNotNil: [ ^ left + right ] ].
			^ nil ].
	^ nil
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> seqType: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' seq'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceComprehension: aViennaNode env: aDictionary [
	| expr bindNode setNode guard varGenerator seq set |
	expr := self generate: aViennaNode first env: aDictionary.
	bindNode := aViennaNode second.
	setNode := bindNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'seq'
		uniqueIn:
			{expr.
			(guard ifNil: [ '' ])}.
	seq := varGenerator value.
	set := varGenerator value.
	bindNode first label = 'PatternIdentifier'
		ifTrue: [ 
			| var |
			var := bindNode first first.
			^ '('
				,
					(setNode label = 'SetRangeExpression'
						ifTrue: [ '(' , (self intervalExpression: setNode env: aDictionary) , ')' ]
						ifFalse: [ 
							setNode label = 'SequenceIndices'
								ifTrue: [ '(' , (self indicesExpression: setNode env: aDictionary) , ')' ]
								ifFalse: [ (self generate: setNode env: aDictionary) , ' asSortedCollection' ] ])
				,
					(guard
						ifNotNil: [ ' select: [:' , var , ' | ' , guard , '] thenCollect: [:' , var , ' | ' ]
						ifNil: [ ' collect: [:' , var , ' | ' ]) , expr , ']) asOrderedCollection' ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			| body |
			body := seq , ' add: ' , expr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream
				nextPutAll: '([ :' , set , ' | | ' , seq , ' | ' , seq , ' :=OrderedCollection new.';
				nextPutAll:
						(self
								generatorFromFlatBinds:
									{{(bindNode first).
									(ViennaNode label: 'LocalName' with: set)}}
								body: body
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: seq;
				nextPutAll: '] value: ';
				nextPutAll:
						(setNode label = 'SetRangeExpression'
								ifTrue: [ '(' , (self intervalExpression: setNode env: aDictionary) , ')' ]
								ifFalse: [ (self generate: setNode env: aDictionary) , ' asSortedCollection' ]);
				nextPut: $) ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceConcatenate: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' , ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceElements: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' asSet'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceEnumeration: aViennaNode env: aDictionary [
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} asOrderedCollection'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> sequenceForLoop: aViennaNode env: aDictionary [
	| pat seqExpr body vars varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	seqExpr := self generate: aViennaNode second env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	aViennaNode first label = 'PatternIdentifier'
		ifTrue: [ ^ seqExpr , ' do: [:' , aViennaNode first first , ' | ' , body , ']' ].
	vars := (self boundVariables: aViennaNode first) asArray.
	varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: seqExpr with: body) , vars.
	^ String
		new: 1024
		streamContents: [ :stream | 
			| loopVar |
			loopVar := varGenerator value.
			stream
				nextPutAll: seqExpr;
				nextPutAll: ' do: [:';
				nextPutAll: loopVar;
				nextPutAll: '||';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|';
				nextPutAll: (self binder: pat with: loopVar vars: vars);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceHead: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' first'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceIndices: aViennaNode env: aDictionary [
	^ '(1 to: ' , (self generate: aViennaNode first env: aDictionary) , ' size) asSet'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceLength: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' size'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceReverse: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' reversed'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceTail: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' tail'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> setBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setCardinality: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' size'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setComprehension: aViennaNode env: aDictionary [
	| expr bindListNode guard varGenerator set pair setsAndVars flatBinds |
	expr := self generate: aViennaNode first env: aDictionary.
	bindListNode := aViennaNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'set' uniqueIn: (Array with: expr) , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	pair := self flattenBindList: bindListNode varGenerator: varGenerator env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ String
		new: 1024
		streamContents: [ :stream | 
			| body |
			body := set , ' add: ' , expr.
			guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			stream nextPutAll: '(['.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' :';
						nextPutAll: setAndVar second ].
			stream
				nextPutAll: ' | | ' , set , ' | ' , set , ' :=Set new.';
				nextPutAll:
						(self
								generatorFromFlatBinds: flatBinds
								body: body
								varGenerator: varGenerator
								env: aDictionary);
				nextPutAll: '. ';
				nextPutAll: set;
				nextPutAll: ']'.
			setsAndVars
				do: [ :setAndVar | 
					stream
						nextPutAll: ' value: ';
						nextPutAll: setAndVar first ].
			stream nextPut: $) ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setDifference: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' copyWithoutAll: ' , arg2 , ')'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> setEnumPattern: aViennaNode env: aDictionary [
	| elementPatterns |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	^ '(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elementPatterns) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setEnumeration: aViennaNode env: aDictionary [
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} asSet'
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> setForLoop: aViennaNode env: aDictionary [
	| pat setExpr body vars varGenerator |
	pat := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	(aViennaNode first label = 'PatternIdentifier' and: [ aViennaNode second label = 'FinitePowerSet' ])
		ifTrue: [ 
			^ (self generate: aViennaNode second first env: aDictionary) , ' powerDo: [:' , aViennaNode first first , ' | ' , body
				, ']' ].
	setExpr := aViennaNode second label = 'SetRangeExpression'
		ifTrue: [ self intervalExpression: aViennaNode second env: aDictionary ]
		ifFalse: [ self generate: aViennaNode second env: aDictionary ].
	aViennaNode first label = 'PatternIdentifier'
		ifTrue: [ ^ setExpr , ' do: [:' , aViennaNode first first , ' | ' , body , ']' ].
	vars := (self boundVariables: aViennaNode first) asArray.
	varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: setExpr with: body) , vars.
	^ String
		new: 1024
		streamContents: [ :stream | 
			| loopVar |
			loopVar := varGenerator value.
			stream
				nextPutAll: setExpr;
				nextPutAll: ' do: [:';
				nextPutAll: loopVar;
				nextPutAll: '||';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|';
				nextPutAll: (self binder: pat with: loopVar vars: vars);
				nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
			stream nextPutAll: body.
			stream nextPutAll: ']' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setIntersection: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' intersection: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setRangeExpression: aViennaNode env: aDictionary [
	^ '(', (self intervalExpression: aViennaNode env: aDictionary) , ') asSet'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> setType: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' set'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setUnion: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' copy addAll: ' , arg2 , '; yourself)'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> setUnionPattern: aViennaNode env: aDictionary [
	| pat1 pat2 |
	pat1 := self generate: aViennaNode first env: aDictionary.
	pat2 := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaRuntimeUtil match: ' , pat1 , ' union: ' , pat2 , ')'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> stateDefinition: aViennaNode env: aDictionary [
	| constructor fieldListNode initNode vars vals recordNode initConstructor expressionListNode patternVar |
	constructor := aViennaNode first.
	fieldListNode := aViennaNode second.
	initNode := aViennaNode fourth.
	vars := fieldListNode collect: #first.
	initNode ifNil: [ ^ self error: 'initalisation is required in state definition' ].
	recordNode := initNode first second second.
	initConstructor := recordNode first first.
	expressionListNode := recordNode second.
	initConstructor = constructor
		ifFalse: [ ^ self error: 'Constructor must be the same name as state definition: ' , constructor , ', ' , initConstructor ].
	vars size = expressionListNode size
		ifFalse: [ 
			^ self
				error:
					'Number of state variables and number of arguments must agree: ' , vars size printString , ', '
						, expressionListNode size printString ].
	vals := expressionListNode collect: [ :node | self generate: node env: aDictionary ].
	^ {(String
		new: 1024
		streamContents: [ :stream | 
			vars
				with: vals
				do: [ :var :val | 
					stream
						nextPutAll: var;
						nextPutAll: ' := ';
						nextPutAll: val;
						nextPutAll: '.' , String cr ] ]).
	(String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: initConstructor;
				nextPutAll: ' := ViennaCompositeType constructorName: ';
				nextPutAll: initConstructor storeString;
				nextPutAll: ' withAll: {';
				nextPutAll: (' . ' join: (self generate: fieldListNode env: aDictionary));
				nextPutAll: '}' ]).
	(String
		new: 1024
		streamContents: [ :stream | 
			patternVar := initNode first first first.
			stream
				nextPutAll: 'init_';
				nextPutAll: initConstructor;
				nextPutAll: ' := ';
				nextPutAll: (self generate: initNode first) ])}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> subsequence: aViennaNode env: aDictionary [
	| seq arg1 arg2 |
	seq := self generate: aViennaNode first env: aDictionary.
	arg1 := self generate: aViennaNode second env: aDictionary.
	arg2 := self generate: aViennaNode third env: aDictionary.
	^ '(' , seq , ' copyFrom: ' , arg1 , ' to: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> subset: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg2 , ' includesAll: ' , arg1 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> symbolicLiteral: aViennaNode env: aDictionary [
	^ (decoder symbolicLiteral parse: aViennaNode first trim) storeString
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> threadidExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> timeExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> tokenConstructor: aViennaNode env: aDictionary [
	^ '(ViennaToken with: ' , (self generate: aViennaNode first env: aDictionary) , ')'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> totalFunctionType: aViennaNode env: aDictionary [
	| argType returnType |
	argType := self generate: aViennaNode first env: aDictionary.
	returnType := self generate: aViennaNode second env: aDictionary.
	^ '(' , argType , ' +> ' , returnType , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> tupleConstructor: aViennaNode env: aDictionary [
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} '
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> tuplePattern: aViennaNode env: aDictionary [
	| argPatterns |
	argPatterns := self generate: aViennaNode first env: aDictionary.
	^ '(ViennaRuntimeUtil matchTuple: {' , (' . ' join: argPatterns) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> tupleSelect: aViennaNode env: aDictionary [
	| tuple index |
	tuple := self generate: aViennaNode first env: aDictionary.
	index := self generate: aViennaNode second env: aDictionary.
	^ '(' , tuple , ' at: ' , index , ')'
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> typeBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> typeBindList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> typeDefinition: aViennaNode env: aDictionary [
	| identifier type inv |
	identifier := aViennaNode first.
	type := self generate: aViennaNode second env: aDictionary.
	inv := (self generate: aViennaNode third env: aDictionary) ifNil: [ '' ] ifNotNil: [ :str | ' inv: ' , str ].
	^ identifier , ' := ' , type , inv
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> typeDefinitions: aViennaNode env: aDictionary [
	self subclassResponsibility
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> typeJudgement: aViennaNode env: aDictionary [
	| expr type |
	expr := self generate: aViennaNode first env: aDictionary.
	type := self generate: aViennaNode second env: aDictionary.
	^ '(' , type , ' includes: ' , expr , ')'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> typeName: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> typeVariable: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> typeVariableIdentifier: aViennaNode env: aDictionary [
	| name |
	name := aViennaNode first.
	^ aDictionary at: name ifAbsent: [ name ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> unaryMinus: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' negated'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> unaryPlus: aViennaNode env: aDictionary [
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> undefinedExpression: aViennaNode env: aDictionary [
	^ 'ViennaUndefinedEvaluationError signal'
]

{ #category : #'code generation-types' }
ViennaVDM2Smalltalk >> unionType: aViennaNode env: aDictionary [
	^ '(' , ('|' join: (self generateAll: aViennaNode env: aDictionary)) , ')'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> valueDefinition: aViennaNode env: aDictionary [
	| patternNode pattern body binder |
	patternNode := aViennaNode first.
	pattern := self generate: patternNode env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	^ patternNode label = 'PatternIdentifier'
		ifTrue: [ '(' , patternNode first , ' := ' , body , ')' ]
		ifFalse: [ 
			binder := self binder: pattern with: body vars: (self boundVariables: aViennaNode first) asArray.
			'(' , binder , '  ifFalse: [ViennaNoMatch signal])' ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> valueDefinitions: aViennaNode env: aDictionary [
	self subclassResponsibility
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> varNameGenerator: aString uniqueIn: anArrayOfString [
	| var |
	var := aString.
	^ [ 
	var := '_' , var.
	[ anArrayOfString contains: [ :str | (str findString: var) > 0 ] ] whileTrue: [ var := '_' , var ].
	var ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> waitingExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-statements' }
ViennaVDM2Smalltalk >> whileLoop: aViennaNode env: aDictionary [
	| cond body |
	cond := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	^ '[' , cond , '] whileTrue: [' , body , ']'
]

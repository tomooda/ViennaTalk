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
				do: [ :patternListAndExpression | 
					| patList expr |
					patList := patternListAndExpression first.
					expr := patternListAndExpression second.
					patList
						do: [ :pat | 
							| vars binder |
							vars := pat first.
							binder := self binder: pat second with: valueVar vars: vars.
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

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> defExpression: aViennaNode env: aDictionary [
	| definitionList defs expr vars |
	definitionList := ViennaNode label: aViennaNode first label withAll: (self reorderDefinitions: aViennaNode first).
	defs := self generate: definitionList env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	vars := Array new: defs size streamContents: [ :stream | defs do: [ :def | stream nextPutAll: def first first ] ].
	^ '[|' , (' ' join: vars) , '|'
		,
			('.'
				join:
					(defs
						collect: [ :def | 
							| left right |
							left := def first.
							right := def second.
							self binder: left second with: right vars: left first ])) , ' ifFalse: [ViennaNoMatch signal].' , expr
		, '] value'
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

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> equal: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> equalDefinition: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> equalDefinitionList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> exists1Expression: aViennaNode env: aDictionary [
	| bind pat setOrType expr var |
	bind := self generate: aViennaNode first env: aDictionary.
	pat := bind first.
	setOrType := bind second.
	expr := self generate: aViennaNode second env: aDictionary.
	var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: expr)) value.
	^ '(' , setOrType , ' onlyOneSatisfy: [ :' , var , '||' , (' ' join: pat first) , '|'
		, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , expr , '])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> existsExpression: aViennaNode env: aDictionary [
	| multibinds expr varGenerator |
	multibinds := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'exists' uniqueIn: (Array with: expr) , (multibinds collect: #second).
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '('.
			multibinds
				do: [ :multibind | 
					| patterns set |
					patterns := multibind first.
					set := multibind second.
					patterns
						do: [ :pat | 
							| loopVar |
							loopVar := varGenerator value.
							stream
								nextPutAll: set;
								nextPutAll: ' anySatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '||';
								nextPutAll: (' ' join: pat first);
								nextPutAll: '|';
								nextPutAll: (self binder: pat second with: loopVar vars: pat first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
			stream nextPutAll: expr.
			multibinds do: [ :multibind | multibind first do: [ :pat | stream nextPut: $] ] ].
			stream nextPutAll: ')' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> expressionList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> fieldPattern: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> fieldPatternList: aViennaNode env: aDictionary [
	^ self notYetImplemented
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
	^ (self generate: aViennaNode env: aDictionary) , ' power'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> floor: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode env: aDictionary) , ' floor'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> forallExpression: aViennaNode env: aDictionary [
	| multibinds expr varGenerator |
	multibinds := self generate: aViennaNode first env: aDictionary.
	expr := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'forall' uniqueIn: (Array with: expr) , (multibinds collect: #second).
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '('.
			multibinds
				do: [ :multibind | 
					| patterns set |
					patterns := multibind first.
					set := multibind second.
					patterns
						do: [ :pat | 
							| loopVar |
							loopVar := varGenerator value.
							stream
								nextPutAll: set;
								nextPutAll: ' allSatisfy: [:';
								nextPutAll: loopVar;
								nextPutAll: '||';
								nextPutAll: (' ' join: pat first);
								nextPutAll: '|';
								nextPutAll: (self binder: pat second with: loopVar vars: pat first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
			stream nextPutAll: expr.
			multibinds do: [ :multibind | multibind first do: [ :pat | stream nextPut: $] ] ].
			stream nextPutAll: ')' ]
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
ViennaVDM2Smalltalk >> generatorCodeFromBindList: aCollectionOfMultipleBind varGenerator: aVarGeneratorBlock do: aBlock [
	aCollectionOfMultipleBind
		do: [ :pair | 
			| patterns set |
			patterns := pair first.
			set := pair second.
			patterns
				do: [ :pat | 
					| vars matcher |
					vars := pat first.
					matcher := pat second.
					aBlock
						value:
							(self
								generatorCodeFromVar: vars
								matcher: matcher
								set: set
								varGenerator: aVarGeneratorBlock) ] ]
]

{ #category : #utilities }
ViennaVDM2Smalltalk >> generatorCodeFromVar: vars matcher: matcherString set: set varGenerator: aVarGeneratorBlock [
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|' , (self binder: matcherString with: tmp vars: vars)
		, ' ifFalse: [ViennaNoMatch signal].'
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

{ #category : #'initialize-release' }
ViennaVDM2Smalltalk >> initialize [
	super initialize.
	decoder := ViennaVDMValueDecoder new
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> iotaExpression: aViennaNode env: aDictionary [
	| bind pat setOrType expr var |
	bind := self generate: aViennaNode first env: aDictionary.
	pat := bind first.
	setOrType := bind second.
	expr := self generate: aViennaNode second env: aDictionary.
	var := (self varNameGenerator: 'iota' uniqueIn: (Array with: expr)) value.
	^ '(' , setOrType , ' detect: [ :' , var , '||' , (' ' join: pat first) , '|'
		, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , expr , '])'
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
	| patterns body varGenerator vars |
	patterns := (self generate: aViennaNode first env: aDictionary) collect: #first.
	body := self generate: aViennaNode second env: aDictionary.
	varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
	vars := patterns collect: [ :p | varGenerator value ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPut: $[.
			vars
				do: [ :var | 
					stream
						nextPut: $:;
						nextPutAll: var ].
			stream
				nextPutAll: '||';
				nextPutAll: (' ' join: (patterns collect: [ :pat | ' ' join: pat first ]));
				nextPut: $|.
			patterns
				with: vars
				do: [ :pat :var | 
					stream
						nextPutAll: (self binder: pat second with: var vars: pat first);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream nextPutAll: body.
			patterns do: [ :pat | stream nextPut: $] ] ]
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
			vars := patterns inject: #() into: [ :vs :pat | vs , pat first ].
			stream
				nextPutAll: '[|';
				nextPutAll: (' ' join: vars);
				nextPutAll: '|('.
			patterns
				do: [ :pat | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: set;
						nextPutAll: ' anySatisfy: [:';
						nextPutAll: loopVar;
						nextPutAll: '|';
						nextPutAll: (self binder: pat second with: loopVar vars: pat first);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
			stream nextPutAll: guard.
			multibind first do: [ :pat | stream nextPut: $] ].
			stream
				nextPutAll: ') ifFalse: [NotFound signal].';
				nextPutAll: expr;
				nextPutAll: '] value' ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> letExpression: aViennaNode env: aDictionary [
	| localDefinitions body vars |
	localDefinitions := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	vars := Array new: 10 streamContents: [ :stream | localDefinitions do: [ :def | stream nextPutAll: def first ] ].
	^ '[|' , (' ' join: vars) , '|' , ('.' join: (localDefinitions collect: #second)) , '.' , body , '] value'
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
	| keyExpr valueExpr binds guard varGenerator map |
	keyExpr := self generate: aViennaNode first env: aDictionary.
	valueExpr := self generate: aViennaNode second env: aDictionary.
	binds := self generate: aViennaNode third env: aDictionary.
	guard := self generate: ViennaNode fourth env: aDictionary.
	varGenerator := self
		varNameGenerator: 'map'
		uniqueIn:
			{keyExpr.
			valueExpr} , (binds collect: #second) , {(guard ifNil: [ '' ])}.
	map := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '[ | ' , map , ' | ' , map , ' :=Dictionary new.'.
			self
				generatorCodeFromBindList: binds
				varGenerator: varGenerator
				do: [ :generatorScript | stream nextPutAll: generatorScript ].
			guard
				ifNotNil: [ 
					stream
						nextPutAll: guard;
						nextPutAll: ' ifTrue: [' ].
			stream
				nextPutAll: map;
				nextPutAll: ' at: ';
				nextPutAll: keyExpr;
				nextPutAll: ' put: ';
				nextPutAll: valueExpr.
			guard ifNotNil: [ stream nextPut: $] ].
			self generatorCodeFromBindList: binds varGenerator: varGenerator do: [ :generatorScript | stream nextPut: $] ].
			stream
				nextPut: $.;
				nextPutAll: map;
				nextPutAll: '] value' ]
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
	| patternPairs vars maplets |
	patternPairs := self generateAll: aViennaNode env: aDictionary.
	vars := (Array
		new: 10
		streamContents: [ :stream | 
			patternPairs
				do: [ :pair | 
					stream
						nextPutAll: pair first first;
						nextPutAll: pair second first ] ]) asSet asArray.
	maplets := patternPairs
		collect: [ :pair | 
			{(pair first second).
			(pair second second)} ].
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchMapEnumeration: {'
		, (' . ' join: (maplets collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})')}
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
	| varsAndPat1 varsAndPat2 vars pat1 pat2 |
	varsAndPat1 := self generate: aViennaNode first env: aDictionary.
	varsAndPat2 := self generate: aViennaNode second env: aDictionary.
	vars := (varsAndPat1 first , varsAndPat2 first) asSet asArray.
	pat1 := varsAndPat1 second.
	pat2 := varsAndPat2 second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil match: ' , pat1 , ' munion: ' , pat2 , ')')}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapOrSequenceModify: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> mapOrSequenceReference: aViennaNode env: aDictionary [
	| mapOrSeq key |
	mapOrSeq := self generate: aViennaNode first env: aDictionary.
	key := self generate: aViennaNode second env: aDictionary.
	^ '(' , mapOrSeq , ' at: ' , key , ')'
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
	^ {#().
	('(ViennaRuntimeUtil matchValue: ' , literal , ')')}
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> multipleSetBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> multipleTypeBind: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
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

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> patternIdentifier: aViennaNode env: aDictionary [
	| identifierOrNil |
	identifierOrNil := self generate: aViennaNode first env: aDictionary.
	^ {(identifierOrNil ifNil: [ #() ] ifNotNil: [ {identifierOrNil} ]).
	('(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')')}
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> patternList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> preconditionExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> properSubset: aViennaNode env: aDictionary [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '([:set1 :set2 | set1 size < set2 size and: [ set2 includesAll: set1 ]] value: ' , arg1 , ' value: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> recordConstructor: aViennaNode env: aDictionary [
	| constructorName args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	args := self generate: aViennaNode second env: aDictionary.
	^ '(ViennaComposite constructorName: ' , constructorName storeString , ' withAll: {' , (' . ' join: args) , '})'
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
	| constructorName argPatterns vars args |
	constructorName := self generate: aViennaNode first env: aDictionary.
	argPatterns := self generate: aViennaNode second env: aDictionary.
	vars := OrderedCollection new.
	argPatterns do: [ :arg | vars addAll: arg first ].
	args := (argPatterns collect: #second) asSet asArray.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: args) , '})')}
]

{ #category : #private }
ViennaVDM2Smalltalk >> reorderDefinitions: aCollectionOfViennaNode [
	| originalDefs env boundVars freeVars newDefs |
	originalDefs := Array withAll: aCollectionOfViennaNode.
	env := Dictionary new.
	boundVars := (originalDefs
		collect: [ :def | 
			| binds |
			binds := Set new.
			self boundVariables: def into: binds.
			def -> binds asArray ]) asDictionary.
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

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> seqConcPattern: aViennaNode env: aDictionary [
	| varsAndPat1 varsAndPat2 vars pat1 pat2 |
	varsAndPat1 := self generate: aViennaNode first env: aDictionary.
	varsAndPat2 := self generate: aViennaNode second env: aDictionary.
	vars := (varsAndPat1 first , varsAndPat2 first) asSet asArray.
	pat1 := varsAndPat1 second.
	pat2 := varsAndPat2 second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil match: ' , pat1 , ' conc: ' , pat2 , ')')}
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> seqEnumPattern: aViennaNode env: aDictionary [
	| elementPatterns vars elements |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ]) asSet
		asArray.
	elements := elementPatterns collect: #second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchSequenceEnumeration: {' , (' . ' join: elements) , '})')}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceComprehension: aViennaNode env: aDictionary [
	| expr setBinding pat vars matcher set guard varGenerator seq |
	expr := self generate: aViennaNode first env: aDictionary.
	setBinding := self generate: aViennaNode second env: aDictionary.
	guard := self generate: aViennaNode third env: aDictionary.
	pat := setBinding first.
	vars := pat first.
	matcher := pat second.
	set := setBinding second.
	varGenerator := self
		varNameGenerator: 'seq'
		uniqueIn:
			{expr.
			matcher.
			set.
			(guard ifNil: [ '' ])}.
	seq := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: '[|';
				nextPutAll: seq;
				nextPutAll: '|';
				nextPutAll: seq;
				nextPutAll: ':= OrderedCollection new.';
				nextPutAll:
						(self
								generatorCodeFromVar: vars
								matcher: matcher
								set: set , ' asSortedCollection'
								varGenerator: varGenerator).
			guard
				ifNotNil: [ 
					stream
						nextPutAll: guard;
						nextPutAll: ' ifTrue: [' ].
			stream
				nextPutAll: seq;
				nextPutAll: ' add: ';
				nextPutAll: expr.
			guard ifNotNil: [ stream nextPutAll: ']' ].
			stream
				nextPutAll: ']. ';
				nextPutAll: seq;
				nextPutAll: '] value' ]
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
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setCardinality: aViennaNode env: aDictionary [
	^ (self generate: aViennaNode first env: aDictionary) , ' size'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setComprehension: aViennaNode env: aDictionary [
	| expr binds guard varGenerator set |
	expr := self generate: aViennaNode first env: aDictionary.
	binds := self generate: aViennaNode second env: aDictionary.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		varNameGenerator: 'set'
		uniqueIn: (Array with: expr) , (binds collect: #second) , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '[ | ' , set , ' | ' , set , ' :=Set new.'.
			self
				generatorCodeFromBindList: binds
				varGenerator: varGenerator
				do: [ :generatorScript | stream nextPutAll: generatorScript ].
			guard
				ifNotNil: [ 
					stream
						nextPutAll: guard;
						nextPutAll: ' ifTrue: [' ].
			stream
				nextPutAll: set;
				nextPutAll: ' add: ';
				nextPutAll: expr.
			guard ifNotNil: [ stream nextPut: $] ].
			self generatorCodeFromBindList: binds varGenerator: varGenerator do: [ :generatorScript | stream nextPut: $] ].
			stream
				nextPut: $.;
				nextPutAll: set;
				nextPutAll: '] value' ]
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
	| elementPatterns vars elements |
	elementPatterns := self generateAll: aViennaNode env: aDictionary.
	vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ]) asSet
		asArray.
	elements := elementPatterns collect: #second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elements) , '})')}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setEnumeration: aViennaNode env: aDictionary [
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} asSet'
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
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first env: aDictionary.
	arg2 := self generate: aViennaNode second env: aDictionary.
	^ '(' , arg1 , ' to: ' , arg2 , ') asSet'
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
	| varsAndPat1 varsAndPat2 vars pat1 pat2 |
	varsAndPat1 := self generate: aViennaNode first env: aDictionary.
	varsAndPat2 := self generate: aViennaNode second env: aDictionary.
	vars := (varsAndPat1 first , varsAndPat2 first) asSet asArray.
	pat1 := varsAndPat1 second.
	pat2 := varsAndPat2 second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil match: ' , pat1 , ' union: ' , pat2 , ')')}
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

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> tupleConstructor: aViennaNode env: aDictionary [
	^ '{' , (' . ' join: (self generate: aViennaNode first env: aDictionary)) , '} '
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> tuplePattern: aViennaNode env: aDictionary [
	| argPatterns vars args |
	argPatterns := self generateAll: aViennaNode env: aDictionary.
	vars := Set new.
	argPatterns do: [ :arg | vars addAll: arg first ].
	vars := vars asArray.
	args := argPatterns collect: #second.
	^ {(vars reject: #isNil).
	('(ViennaRuntimeUtil matchTuple: {' , (' . ' join: args) , '})')}
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
	^ self generate: aViennaNode first env: aDictionary
]

{ #category : #'code generation-patterns' }
ViennaVDM2Smalltalk >> typeBindList: aViennaNode env: aDictionary [
	^ self generateAll: aViennaNode env: aDictionary
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> typeJudgement: aViennaNode env: aDictionary [
	| expr type |
	expr := self generate: aViennaNode first env: aDictionary.
	type := self generate: aViennaNode second env: aDictionary.
	^ '(' , type , ' includes: ' , expr , ')'
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

{ #category : #'code generation-definitions' }
ViennaVDM2Smalltalk >> valueDefinition: aViennaNode env: aDictionary [
	| pat body vars binder |
	pat := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	vars := pat first.
	binder := self binder: pat second with: body vars: vars.
	^ {vars.
	('(' , binder , '  ifFalse: [ViennaNoMatch signal])')}
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

{ #category : #utilities }
ViennaVDM2Smalltalk >> varsFromMultiPatternBind: multiPatternBind [
	| vars |
	vars := Array new writeStream.
	multiPatternBind
		do: [ :multiPattern | 
			| patterns |
			patterns := multiPattern first.
			patterns do: [ :varAndBlockString | vars nextPut: varAndBlockString first ] ].
	^ vars
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> waitingExpression: aViennaNode env: aDictionary [
	^ self notYetImplemented
]

Class {
	#name : #ViennaVDM2Smalltalk,
	#superclass : #Object,
	#instVars : [
		'decoder'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> and: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' and: [' , arg2 , '])'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> apply: aViennaNode [
	| func args |
	func := self generate: aViennaNode first.
	args := self generate: aViennaNode second.
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticAbs: aViennaNode [
	^ (self generate: aViennaNode first) , ' abs'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticDivide: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' asFloat / ' , arg2 , ' asFloat)'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticIntegerDivision: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' asInteger // ' , arg2 , ' asInteger)'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMinus: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' - ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMod: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' \\ ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticMultiplication: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' * ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticPlus: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' + ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> arithmeticRem: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' rem: ' , arg2 , ')'
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
ViennaVDM2Smalltalk >> casesExpression: aViennaNode [
	| valueExpr patternListAndExpressions defaultExpression varGenerator valueVar foundVar resultVar |
	valueExpr := self generate: aViennaNode first.
	patternListAndExpressions := self generate: aViennaNode second.
	defaultExpression := aViennaNode third ifNotNil: [ :node | self generate: node ].
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
ViennaVDM2Smalltalk >> casesExpressionAlternative: aViennaNode [
	| patlist expr |
	patlist := self generate: aViennaNode first.
	expr := self generate: aViennaNode second.
	^ {patlist.
	expr}
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> casesExpressionAlternatives: aViennaNode [
	^ aViennaNode collect: [ :node | self generate: node ]
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> composition: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' comp: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedSequenceConcatenation: aViennaNode [
	^ (self generate: aViennaNode first) , ' concatenation asOrderedCollection'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> distributedSetIntersection: aViennaNode [
	| arg |
	arg := self generate: aViennaNode first.
	^ '(' , arg
		,
			' asArray in: [ :sets | sets isEmpty ifTrue: [Set new] ifFalse: [(sets copyFrom: 2 to: sets size) inject: sets first into: [:inter :set | inter intersection: set]]])'
]

{ #category : #'code generation' }
ViennaVDM2Smalltalk >> generate: aViennaNode [
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	^ self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode
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

{ #category : #'initialize-release' }
ViennaVDM2Smalltalk >> initialize [
	super initialize.
	decoder := ViennaVDMValueDecoder new
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> sequenceConcatenate: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' , ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> setDifference: aViennaNode [
	| arg1 arg2 |
	arg1 := self generate: aViennaNode first.
	arg2 := self generate: aViennaNode second.
	^ '(' , arg1 , ' copyWithoutAll: ' , arg2 , ')'
]

{ #category : #'code generation-expressions' }
ViennaVDM2Smalltalk >> symbolicLiteral: aViennaNode [
	^ (decoder symbolicLiteral parse: aViennaNode first trim) storeString
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

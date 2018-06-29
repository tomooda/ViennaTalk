Class {
	#name : #ViennaVDM2SmalltalkTranslator,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> abs: arg [
	^ arg , ' abs'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> and: arg1 and: arg2 [
	^ '(' , arg1 , ' & ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> apply: func args: args [
	| t1 |
	t1 := '_f'.
	[ (func findString: t1) > 0 or: [ args contains: [ :arg | (arg findString: t1) > 0 ] ] ] whileTrue: [ t1 := t1 , '_' ].
	^ args ifNotEmpty: ['(' , func , ' in: [ :' , t1 , ' | ' , t1 , ' isCollection ifTrue: [ ' , t1 , ' at: ' , args first , '] ifFalse: [ '
		, t1 , ' valueWithArguments: {' , (' . ' join: args) , '}]])'] ifEmpty: [ func, ' value' ]
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> booleanLiteral [
	^ super booleanLiteral
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> card: arg [
	^ arg , ' size'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> characterLiteral [
	^ super characterLiteral ==> [ :c | c storeString ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> compositionExpression: expr1 and: expr2 [
	^ (super compositionExpression: expr1 and: expr2)
		in: [ :pair | '(ViennaComposition with: ' , pair first , ' with: ' , pair second , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> conc: arg [
	^ arg , ' concatenation'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> concat: arg1 and: arg2 [
	^ '(' , arg1 , ' ^ ' , arg2 , ')'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> decimalLiteral [
	^ super decimalLiteral
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> diff: arg1 and: arg2 [
	^ '(' , arg1 , ' copyWithoutAll: ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> dinter: arg [
	^ '(' , arg
		,
			' asArray in: [ :sets | sets isEmpty ifTrue: [Set new] ifFalse: [(sets copyFrom: 2 to: sets size) inject: sets first into: [:inter :set | inter intersection: set]]])'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> div: arg1 and: arg2 [
	^ '(' , arg1 , ' asInteger // ' , arg2 , ' asInteger)'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> dom: arg [
	^ arg , ' keys asSet'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> dunion: arg [
	^ '(' , arg , ' inject: Set new into: [:union :set | union addAll: set; yourself])'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> elems: arg [
	^ arg asSet
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> equal: arg1 and: arg2 [
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> equiv: arg1 and: arg2 [
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> explicitFunctionDefinition [
	^ super explicitFunctionDefinition
		==> [ :array | 
			| funcName paramSets body varGenerator |
			funcName := array first.
			paramSets := array fifth.
			body := array sixth.
			varGenerator := self
				varNameGenerator: 'func'
				uniqueIn:
					{funcName.
					body}.
			{(Array with: funcName).
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: funcName;
						nextPutAll: ' := '.
					paramSets
						do: [ :params | 
							| vars |
							vars := params collect: [ :p | varGenerator value ].
							stream
								nextPut: $[;
								nextPutAll: (' ' join: (vars collect: [ :v | ' :' , v ]));
								nextPutAll: '||'.
							params
								with: vars
								do: [ :p :v | 
									p first
										do: [ :pv | 
											stream
												nextPutAll: pv;
												nextPut: Character space ] ].
							stream nextPut: $|.
							params
								with: vars
								do: [ :p :v | 
									stream
										nextPutAll: p second;
										nextPutAll: ' value: ';
										nextPutAll: v;
										nextPut: $. ] ].
					stream nextPutAll: body.
					paramSets do: [ :args | stream nextPut: $] ] ])} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> fieldSelect: record with: field [
	^ '(' , record , ' at: ''' , field , ''')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> floor: arg [
	^ arg , ' floor'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> fraction: arg1 and: arg2 [
	^ '(' , arg1 , ' asFloat / ' , arg2 , ' asFloat)'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> functionTypeInstantiation: func args: args [
	^ func
]

{ #category : #utilities }
ViennaVDM2SmalltalkTranslator >> generatorCodeFromBindList: aCollectionOfMultipleBind varGenerator: aVarGeneratorBlock do: aBlock [
	aCollectionOfMultipleBind
		do: [ :pair | 
			| patterns set |
			patterns := pair first.
			set := pair second.
			patterns
				do: [ :pat | 
					| vars binder |
					vars := pat first.
					binder := pat second.
					aBlock
						value:
							(self
								generatorCodeFromVar: vars
								binder: binder
								set: set
								varGenerator: aVarGeneratorBlock) ] ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkTranslator >> generatorCodeFromVar: vars binder: binder set: set varGenerator: aVarGeneratorBlock [
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|' , binder , ' value: ' , tmp , '.'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> greater: arg1 and: arg2 [
	^ '(' , arg1 , ' > ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> greaterEq: arg1 and: arg2 [
	^ '(' , arg1 , ' >= ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> hd: arg [
	^ arg , ' first'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> hexadecimalLiteral [
	^ super hexadecimalLiteral ==> [ :hex | '16r' , hex ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> ifExpression [
	^ super ifExpression
		==> [ :pair | 
			'('
				,
					(pair first
						inject: pair second
						into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ]) , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> imp: arg1 and: arg2 [
	^ '(' , arg1 , ' ==> ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inSet: arg1 and: arg2 [
	^ '(' , arg2 , ' includes: ' , arg1 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inds: arg [
	^ '(1 to: ' , arg size , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inter: arg1 and: arg2 [
	^ '(' , arg1 , ' intersection: ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inverse: arg [
	^ '([:dict :arg | arg keysAndValuesDo: [:k :v | dict at: v put: k]. dict] value: Dictionary new value: ' , arg , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> iterateExpression: expr1 and: expr2 [
	^ '(ViennaIteration with: ' , expr1 , ' with: ' , expr2 , ')'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> lambdaExpression [
	^ super lambdaExpression
		==> [ :pair | 
			| patterns body varGenerator vars |
			patterns := pair first collect: #first.
			body := pair second.
			varGenerator := self varNameGenerator: 'lmd' uniqueIn: (Array with: body).
			vars := patterns collect: [ :p | varGenerator value ].
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPut: $[.
					vars
						do: [ :var | 
							stream
								nextPut: $:;
								nextPutAll: var ].
					stream nextPutAll: '||'.
					patterns
						do: [ :pat | 
							pat first
								do: [ :v | 
									stream
										nextPutAll: v;
										nextPut: $  ] ].
					stream nextPut: $|.
					patterns
						with: vars
						do: [ :pat :var | 
							stream
								nextPutAll: pat second;
								nextPutAll: ' value: ';
								nextPutAll: var;
								nextPut: $. ].
					stream nextPutAll: body.
					patterns do: [ :pat | stream nextPut: $] ] ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> len: arg [
	^ arg , ' size'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> less: arg1 and: arg2 [
	^ '(' , arg1 , ' < ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> lessEq: arg1 and: arg2 [
	^ '(' , arg1 , ' <= ' , arg2 , ')'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> letExpression [
	^ super letExpression
		==> [ :pair | 
			| localDefinitions body vars |
			localDefinitions := pair first.
			body := pair second.
			vars := Array new: 10 streamContents: [ :stream | localDefinitions do: [ :def | stream nextPutAll: def first ] ].
			'[|' , (' ' join: vars) , '|' , ('.' join: (localDefinitions collect: #second)) , '.' , body , '] value' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> map: set domainRestrictedBy: map [
	^ '([:set :map | map copy keysAndValuesRemove: [:k :v | set includes: k]; yourself] value: ' , set , ' value: ' , map
		, ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> map: set domainRestrictedTo: map [
	^ '([:set :map | map copy keysAndValuesRemove: [:k :v | (set includes: k) not]; yourself] value: ' , set , ' value: '
		, map , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> map: map rangeRestrictedBy: set [
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | set includes: v]; yourself] value: ' , map , ' value: ' , set
		, ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> map: map rangeRestrictedTo: set [
	^ '([:map :set | map copy keysAndValuesRemove: [:k :v | (set includes: v) not]; yourself] value: ' , map , ' value: '
		, set , ')'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> mapComprehension [
	^ super mapComprehension
		==> [ :quatro | 
			| keyExpr valueExpr binds guard varGenerator map |
			keyExpr := quatro first.
			valueExpr := quatro second.
			binds := quatro third.
			guard := quatro fourth.
			varGenerator := self
				varNameGenerator: 'map'
				uniqueIn:
					{keyExpr.
					valueExpr} , (binds collect: #second) , {(guard ifNil: [ '' ])}.
			map := varGenerator value.
			String
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
						nextPutAll: '] value' ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> mapEnumeration [
	^ super mapEnumeration
		==> [ :pairs | 
			'(Dictionary new ' , (';' join: (pairs collect: [ :pair | 'at: ' , pair first , ' put: ' , pair second ]))
				, '; yourself)' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> mconcat: arg1 and: arg2 [
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> merge: setOfDict [
	^ '(' , setOfDict , ' in: [:s | | d | d := Dictionary new. s do: [:d1 | d addAll: d1]. d])'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> minus: arg1 and: arg2 [
	^ '(' , arg1 , ' - ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> mod: arg1 and: arg2 [
	^ '(' , arg1 , ' \\ ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> mul: arg1 and: arg2 [
	^ '(' , arg1 , ' * ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> munion: arg1 and: arg2 [
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> nilLiteral [
	^ super nilLiteral ==> [ :t |  ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> not: arg [
	^ arg , ' not'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> notEqual: arg1 and: arg2 [
	^ '(' , arg1 , ' ~= ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> notInSet: arg1 and: arg2 [
	^ '(' , arg2 , ' includes: ' , arg1 , ') not'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> or: arg1 and: arg2 [
	^ '(' , arg2 , ' or: [' , arg1 , '])'
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> patternIdentifier [
	^ super patternIdentifier
		==> [ :identifierOrNil | 
			{(Array with: identifierOrNil).
			('[:_value | ' , (identifierOrNil ifNil: [ 'true' ] ifNotNil: [ identifierOrNil , ':=_value.true' ]) , ']')} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> plus: arg1 and: arg2 [
	^ '(' , arg1 , '+' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> power: set [
	^ '(' , set
		,
			' asArray in: [:set | | power | power := Set new: 1<<set size. 0 to: 1<<(set size)-1 do: [ :i | | elem | elem := Set new:set size//2. 1 to: set size do: [ :b | (i bitAt: b) = 0 ifTrue: [ elem add: (set at: b) ] ]. power add: elem]. power])'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> psubset: arg1 and: arg2 [
	^ '([:set1 :set2 | set1 size < set2 size and: [ set2 includesAll: set1 ]] value: ' , arg1 , ' value: ' , arg2 , ')'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> quoteLiteral [
	^ super quoteLiteral ==> [ :quote | '#''' , quote , '''' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> rem: arg1 and: arg2 [
	^ '(' , arg1 , ' rem: ' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> rng: arg [
	^ arg , ' values asSet'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceComprehension [
	^ super sequenceComprehension
		==> [ :triple | 
			| expr setBinding pat vars binder set guard varGenerator seq |
			expr := triple first.
			setBinding := triple second.
			pat := setBinding first.
			vars := pat first .
			binder := pat second.
			set := setBinding second.
			guard := triple third.
			varGenerator := self
				varNameGenerator: 'seq'
				uniqueIn:
					{expr.
					binder.
					set.
					(guard ifNil: [ '' ])}.
			seq := varGenerator value.
			String
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
										binder: binder
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
						nextPutAll: '] value' ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asOrderedCollection' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setComprehension [
	^ super setComprehension
		==> [ :triple | 
			| expr binds guard varGenerator set |
			expr := triple first.
			binds := triple second.
			guard := triple third.
			varGenerator := self
				varNameGenerator: 'set'
				uniqueIn: (Array with: expr) , (binds collect: #second) , (Array with: (guard ifNil: [ '' ])).
			set := varGenerator value.
			String
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
						nextPutAll: '] value' ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setEnumeration [
	^ super setEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asSet' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setRangeExpression [
	^ super setRangeExpression ==> [ :pair | '(' , pair first , ' to: ' , pair second , ') asSet' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> subsequence: seq from: i1 to: i2 [
	^ '(' , seq , ' copyFrom: ' , i1 , ' to: ' , i2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> subset: arg1 and: arg2 [
	^ '(' , arg2 , ' includesAll: ' , arg1 , ')'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> textLiteral [
	^ super textLiteral ==> [ :text | '(' , text asOrderedCollection storeString , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> tl: arg [
	^ arg , ' copyWithoutFirst'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> tupleConstructor [
	^ super tupleConstructor ==> [ :array | '{' , (' . ' join: array) , '}' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> tuplePattern [
	^ super tuplePattern
		==> [ :args | 
			| vars varGenerator |
			vars := OrderedCollection new.
			args do: [ :arg | vars addAll: arg first ].
			varGenerator := self varNameGenerator: 'var' uniqueIn: (args collect: #second).
			{vars.
			(String
				new: 1024
				streamContents: [ :stream | 
					| var |
					var := varGenerator value.
					stream
						nextPutAll: '[:';
						nextPutAll: var;
						nextPut: $|.
					stream
						nextPutAll:
							((args size - 1 to: 1 by: -1)
								inject: args last second , ' value: (' , var , ' at: ' , args size storeString , ')'
								into: [ :expr :i | '(' , (args at: i) second , ' value: (' , var , ' at: ' , i storeString , ')) and: [' , expr , ']' ]).
					stream nextPut: $] ])} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> tupleSelect: tuple with: index [
	^ '(' , tuple , ' at: ' , index , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> unaryMinus: arg [
	^ arg , ' negated'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> unaryPlus: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> union: arg1 and: arg2 [
	^ '(' , arg1 , ' copy addAll: ' , arg2 , '; yourself)'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> valueDefinition [
	^ super valueDefinition
		==> [ :triple | 
			| pat body vars binder |
			pat := triple first.
			body := triple third.
			vars := pat first.
			binder := pat second.
			{vars.
			('(' , binder , ' value: ' , body , ')')} ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkTranslator >> varNameGenerator: aString uniqueIn: anArrayOfString [
	| var |
	var := aString.
	^ [ 
	var := '_' , var.
	[ anArrayOfString contains: [ :str | (str findString: var) > 0 ] ] whileTrue: [ var := '_' , var ].
	var ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkTranslator >> varsFromMultiPatternBind: multiPatternBind [
	| vars |
	vars := Array new writeStream.
	multiPatternBind
		do: [ :multiPattern | 
			| patterns |
			patterns := multiPattern first.
			patterns do: [ :varAndBlockString | vars nextPut: varAndBlockString first ] ].
	^ vars
]

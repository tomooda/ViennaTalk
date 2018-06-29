Class {
	#name : #ViennaVDM2SmalltalkTranslator,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Value-Core'
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
	^ '(' , func , ' in: [ :_f | _f isCollection ifTrue: [ _f at: ' , args first , '] ifFalse: [ _f valueWithArguments: {'
		, (' . ' join: args) , '}]])'
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
			{(array first).
			(String
				new: 1024
				streamContents: [ :stream | 
					array fifth
						do: [ :args | 
							stream nextPut: $[.
							args
								do: [ :arg | 
									stream
										nextPut: $:;
										nextPutAll: arg ].
							stream nextPut: $| ].
					stream nextPutAll: array sixth.
					array fifth do: [ :args | stream nextPut: $] ] ])} ]
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
	^ '([:dict :n | | newDict | newDict := Dictionary new. dict keysDo: [:k | | v | v := k. n timesRepeat: [v := dict at: v]. newDict at: k put: v]. newDict] value: '
		, expr1 , ' value: ' , expr2 , ')'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> lambdaExpression [
	^ super lambdaExpression
		==> [ :pair | '[' , (' ' join: (pair first collect: [ :var | ':' , var first ])) , ' | ' , pair second , ']' ]
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
			'[|' , (' ' join: (pair first collect: #first)) , '|'
				, ('.' join: (pair first collect: [ :p | p first , ':=' , p second ])) , '.' , pair second , '] value' ]
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
			Array
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[|map|map:=Dictionary new.'.
					quatro third
						do: [ :_multibind | 
							_multibind first
								do: [ :_var | 
									stream
										nextPutAll: _multibind second;
										nextPutAll: ' do: [:';
										nextPutAll: _var;
										nextPut: $| ] ].
					quatro fourth
						ifNotNil: [ :cond | 
							stream
								nextPutAll: cond;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: 'map at: ';
						nextPutAll: quatro first;
						nextPutAll: ' put: ';
						nextPutAll: quatro second.
					quatro fourth ifNotNil: [ stream nextPut: $] ].
					quatro third do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. map] value' ] ]
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
			'(Array new: 1024 streamContents: [:seq | ' , triple second second , ' asSortedCollection do: [:' , triple second first
				, '|' , (triple third ifNil: [ '' ] ifNotNil: [ triple third , ' ifTrue: [' ]) , 'seq nextPut: ' , triple first
				, (triple third ifNil: [ ']])' ] ifNotNil: [ ']]])' ]) ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '}' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setComprehension [
	^ super setComprehension
		==> [ :triple | 
			Array
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[|set|set:=Set new.'.
					triple second
						do: [ :_multibind | 
							_multibind first
								do: [ :_var | 
									stream
										nextPutAll: _multibind second;
										nextPutAll: ' do: [:';
										nextPutAll: _var;
										nextPut: $| ] ].
					triple third
						ifNotNil: [ :cond | 
							stream
								nextPutAll: cond;
								nextPutAll: ' ifTrue: [' ].
					stream
						nextPutAll: 'set add: ';
						nextPutAll: triple first.
					triple third ifNotNil: [ stream nextPut: $] ].
					triple second do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. set] value' ] ]
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
	^ super textLiteral ==> [ :text | text asArray storeString ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> tl: arg [
	^ arg , ' copyWithoutFirst'
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
			{(triple first).
			(triple third)} ]
]

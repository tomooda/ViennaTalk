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
	^ '(' , func , ' in: [ :' , t1 , ' | ' , t1 , ' isCollection ifTrue: [ ' , t1 , ' at: ' , args first , '] ifFalse: [ '
		, t1 , ' valueWithArguments: {' , (' . ' join: args) , '}]])'
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
										nextPutAll: ' :';
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
			String
				new: 1024
				streamContents: [ :stream | 
					| map |
					map := '_map'.
					[ 
					(quatro first findString: map) > 0
						or: [ 
							(quatro second findString: map) > 0
								or: [ 
									(quatro third contains: [ :_multibind | (_multibind second findString: map) > 0 ])
										or: [ quatro fourth notNil and: [ (quatro fourth findString: map) > 0 ] ] ] ] ]
						whileTrue: [ map := map , '_' ].
					stream nextPutAll: '[ | ' , map , ' | ' , map , ' := Dictionary new.'.
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
						nextPutAll: map , ' at: ';
						nextPutAll: quatro first;
						nextPutAll: ' put: ';
						nextPutAll: quatro second.
					quatro fourth ifNotNil: [ stream nextPut: $] ].
					quatro third do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. ' , map , '] value' ] ]
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
			| seq |
			seq := '_seq'.
			[ 
			(triple first findString: seq) > 0
				or: [ (triple second second findString: seq) > 0 or: [ triple third notNil and: [ (triple third findString: seq) > 0 ] ] ] ]
				whileTrue: [ seq := seq , '_' ].
			'(Array new: 1024 streamContents: [ :' , seq , ' | ' , triple second second , ' asSortedCollection do: [:'
				, triple second first , '|' , (triple third ifNil: [ '' ] ifNotNil: [ triple third , ' ifTrue: [' ]) , seq
				, ' nextPut: ' , triple first
				, (triple third ifNil: [ ']]) asOrderedCollection' ] ifNotNil: [ ']]]) asOrderedCollection' ]) ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asOrderedCollection' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setComprehension [
	^ super setComprehension
		==> [ :triple | 
			| set |
			set := '_set'.
			[ 
			(triple first findString: set) > 0
				or: [ 
					(triple second contains: [ :multibind | (multibind second findString: set) > 0 ])
						or: [ triple third notNil and: [ (triple third findString: set) > 0 ] ] ] ] whileTrue: [ set := set , '_' ].
			String
				new: 1024
				streamContents: [ :stream | 
					stream nextPutAll: '[ | ' , set , ' | ' , set , ' :=Set new.'.
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
						nextPutAll: set , ' add: ';
						nextPutAll: triple first.
					triple third ifNotNil: [ stream nextPut: $] ].
					triple second do: [ :_multibind | _multibind first do: [ :_var | stream nextPut: $] ] ].
					stream nextPutAll: '. ' , set , '] value' ] ]
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
	^ super textLiteral ==> [ :text | text asOrderedCollection storeString ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> tl: arg [
	^ arg , ' copyWithoutFirst'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> tupleConstructor [
	^ super tupleConstructor
		==> [ :array | 
			'((Array new: ' , array size storeString , ') '
				, (';' join: ((1 to: array size) collect: [ :i | 'at: ' , i storeString , ' put: ' , (array at: i) ]))
				, '; yourself)' ]
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

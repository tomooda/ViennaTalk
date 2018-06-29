Class {
	#name : #ViennaVDM2SmalltalkTranslator,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> abs: arg [
	^ arg , ' abs'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> accessFunctionDefinition [
	^ super accessFunctionDefinition ==> #second
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> accessOperationDefinition [
	^ super accessOperationDefinition ==> #second
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> accessTypeDefinition [
	^ super accessTypeDefinition ==> #second
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> accessValueDefinition [
	^ super accessValueDefinition ==> #second
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> and: arg1 and: arg2 [
	^ '(' , arg1 , ' and: [' , arg2 , '])'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> anonymousField [
	^ super anonymousField ==> [ :fieldtype | '{nil . false. ' , fieldtype , '}' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> apply: func args: args [
	^ '(' , func , ' applyTo: {' , (' . ' join: args) , '})'
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> assignStatement [
	^ super assignStatement
		==> [ :pair | 
			| desig expr |
			desig := pair first.
			expr := pair second.
			desig isString
				ifTrue: [ desig , ' := ' , expr ]
				ifFalse: [ 
					| ident path |
					ident := desig first.
					path := desig second.
					ident , ' := ' , ident , ' copyAtPath: {' , (' . ' join: path) , '} put: ' , expr ] ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> assignmentDefinition [
	^ super assignmentDefinition
		==> [ :triple | 
			| ident value |
			ident := triple first.
			value := triple third.
			{{ident}.
			(value ifNil: [ '' ] ifNotNil: [ ident , ' := ' , value ])} ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> basicType [
	^ super basicType ==> [ :typename | 'ViennaType ' , typename ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkTranslator >> binder: aBlockString with: aString vars: anArrayOfString [
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
						('.' join: (anArrayOfString collect: [ :varName | varName , ' := binds first at: ' , varName storeString ]));
				nextPutAll: '. true])' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> blockStatement [
	^ super blockStatement
		==> [ :array | 
			| decls statements vars |
			decls := array first.
			statements := array second.
			vars := decls inject: #() into: [ :vs :decl | vs , decl first ].
			'[|' , (' ' join: vars) , '|' , ('.' join: (decls collect: #second) , statements) , '] value.' ]
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> booleanLiteral [
	^ super booleanLiteral
		==> [ :b | 
			b
				ifTrue: [ 'true' ]
				ifFalse: [ 'false' ] ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> callStatement [
	^ super callStatement
		==> [ :pair | 
			| callee args |
			callee := pair first.
			args := pair second.
			callee , ' valueWithArguments: {' , (' . ' join: args) , '}' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> card: arg [
	^ arg , ' size'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> casesExpression [
	^ super casesExpression
		==> [ :triple | 
			| valueExpr patternListAndExpressions defaultExpression varGenerator valueVar foundVar resultVar |
			valueExpr := triple first.
			patternListAndExpressions := triple second.
			defaultExpression := triple third.
			varGenerator := self
				varNameGenerator: 'cases'
				uniqueIn:
					(Array with: valueExpr with: (defaultExpression ifNil: [ '' ])) , (patternListAndExpressions collect: #second).
			valueVar := varGenerator value.
			foundVar := varGenerator value.
			resultVar := varGenerator value.
			String
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
						nextPutAll: '])' ] ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> casesStatement [
	^ super casesStatement
		==> [ :triple | 
			| valueExpr defaultSpatternListAndStatement defaultStatement varGenerator valueVar foundVar resultVar |
			valueExpr := triple first.
			defaultSpatternListAndStatement := triple second.
			defaultStatement := triple third.
			varGenerator := self
				varNameGenerator: 'cases'
				uniqueIn:
					(Array with: valueExpr with: (defaultStatement ifNil: [ '' ])) , (defaultSpatternListAndStatement collect: #second).
			valueVar := varGenerator value.
			foundVar := varGenerator value.
			resultVar := varGenerator value.
			String
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
					defaultSpatternListAndStatement
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
						nextPutAll: (defaultStatement ifNil: [ 'ViennaNoMatch signal' ]);
						nextPutAll: '].';
						nextPutAll: resultVar;
						nextPutAll: '])' ] ]
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> characterLiteral [
	^ super characterLiteral ==> [ :c | c storeString ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> compositeType [
	^ super compositeType
		==> [ :pair | 
			| constructorName fields |
			constructorName := pair first.
			fields := pair second.
			'(ViennaType compose: ' , constructorName storeString , ' of: {' , (' . ' join: fields) , '})' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> compositionExpression: expr1 and: expr2 [
	^ (super compositionExpression: expr1 and: expr2) in: [ :pair | '(' , pair first , ' comp: ' , pair second , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> conc: arg [
	^ arg , ' concatenation asOrderedCollection'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> concat: arg1 and: arg2 [
	^ '(' , arg1 , ' , ' , arg2 , ')'
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> dclStatement [
	^ super dclStatement
		==> [ :defs | 
			{(defs inject: #() into: [ :vars :def | vars , def first ]).
			('.' join: (defs collect: #second))} ]
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> decimalLiteral [
	^ super decimalLiteral
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> defExpression [
	^ super defExpression
		==> [ :pair | 
			| defs expr vars |
			defs := pair first.
			expr := pair second.
			vars := Array new: defs size streamContents: [ :stream | defs do: [ :def | stream nextPutAll: def first first ] ].
			'[|' , (' ' join: vars) , '|'
				,
					('.'
						join:
							(defs
								collect: [ :def | 
									| left right |
									left := def first.
									right := def second.
									self binder: left second with: right vars: left first ])) , ' ifFalse: [ViennaNoMatch signal].' , expr , '] value' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> defStatement [
	^ super defStatement
		==> [ :pair | 
			| defs expr vars |
			defs := pair first.
			expr := pair second.
			vars := Array new: defs size streamContents: [ :stream | defs do: [ :def | stream nextPutAll: def first first ] ].
			'[|' , (' ' join: vars) , '|'
				,
					('.'
						join:
							(defs
								collect: [ :def | 
									| left right |
									left := def first.
									right := def second.
									self binder: left second with: right vars: left first ])) , ' ifFalse: [ViennaNoMatch signal].' , expr
				, '] value' ]
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

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> document [
	^ super document
		==> [ :array | 
			| vars bodies |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			bodies := array collect: #second.
			'|' , (' ' join: vars) , '|' , ('' join: bodies) ]
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
	^ arg , ' asSet'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> equal: arg1 and: arg2 [
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> equalityAbstractionField [
	^ super equalityAbstractionField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			'{' , fieldName storeString , '. true. ' , pair second , '}' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> equiv: arg1 and: arg2 [
	^ '(' , arg1 , ' = ' , arg2 , ')'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> exists1Expression [
	^ super exists1Expression
		==> [ :pair | 
			| pat setOrType exprPart var |
			pat := pair first first.
			setOrType := pair first second.
			exprPart := pair second.
			var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: exprPart)) value.
			'(' , setOrType , ' onlyOneSatisfy: [ :' , var , '||' , (' ' join: pat first) , '|'
				, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , exprPart , '])' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> existsExpression [
	^ super existsExpression
		==> [ :pair | 
			| multibinds expr varGenerator |
			multibinds := pair first.
			expr := pair second.
			varGenerator := self varNameGenerator: 'exists' uniqueIn: (Array with: expr) , (multibinds collect: #second).
			String
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
					stream nextPutAll: ')' ] ]
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
										nextPutAll: (self binder: p second with: v vars: p first);
										nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ] ].
					stream nextPutAll: body.
					paramSets do: [ :args | stream nextPut: $] ] ])} ]
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> explicitOperationDefinition [
	^ super explicitOperationDefinition
		==> [ :array | 
			| opname opType opname2 params opbody varGenerator vars |
			opname := array first.
			opType := array second.
			opname2 := array third.
			params := array fourth.
			opbody := array fifth.
			varGenerator := self
				varNameGenerator: 'op'
				uniqueIn:
					{opname.
					opbody}.
			vars := params collect: [ :p | varGenerator value ].
			{{opname}.
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: opname;
						nextPutAll: ' := ['.
					vars
						ifNotEmpty: [ 
							vars
								do: [ :v | 
									stream
										nextPutAll: ' :';
										nextPutAll: v ].
							stream nextPutAll: ' |' ].
					stream
						nextPutAll: ' | ';
						nextPutAll: (' ' join: (params inject: #() into: [ :vs :pat | vs , pat first ]));
						nextPutAll: ' _opContext | _opContext := thisContext. '.
					params
						with: vars
						do: [ :p :v | 
							stream
								nextPutAll: (self binder: p second with: v vars: p first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					stream
						nextPutAll: opbody;
						nextPutAll: ']' ])} ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> fieldReference: stateDesig with: field [
	| ident path |
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

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> fieldSelect: record with: field [
	^ '(' , record , ' at: ''' , field , ''')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> floor: arg [
	^ arg , ' floor'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> forallExpression [
	^ super forallExpression
		==> [ :pair | 
			| multibinds expr varGenerator |
			multibinds := pair first.
			expr := pair second.
			varGenerator := self varNameGenerator: 'forall' uniqueIn: (Array with: expr) , (multibinds collect: #second).
			String
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
					stream nextPutAll: ')' ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> fraction: arg1 and: arg2 [
	^ '(' , arg1 , ' asFloat / ' , arg2 , ' asFloat)'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> functionDefinitions [
	^ super functionDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			{vars.
			(array inject: '' into: [ :code :def | code , def second , '.' ])} ]
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
ViennaVDM2SmalltalkTranslator >> generatorCodeFromVar: vars matcher: matcherString set: set varGenerator: aVarGeneratorBlock [
	| tmp |
	tmp := aVarGeneratorBlock value.
	^ set , ' do: [:' , tmp , '||' , (' ' join: vars) , '|'
		, (self binder: matcherString with: tmp vars: vars) , ' ifFalse: [ViennaNoMatch signal].'
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

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> identifiedField [
	^ super identifiedField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			'{' , fieldName storeString , '. false. ' , pair second , '}' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> identityStatement [
	^ super identityStatement ==> [ :ignore | '' ]
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

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> ifStatement [
	^ super ifStatement
		==> [ :pair | 
			pair first
				inject: (pair second ifNil: [ '' ])
				into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> imp: arg1 and: arg2 [
	^ '(' , arg1 , ' not or: [' , arg2 , '])'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inSet: arg1 and: arg2 [
	^ '(' , arg2 , ' includes: ' , arg1 , ')'
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> indexForLoop [
	^ super indexForLoop
		==> [ :quin | 
			| ident start end step body |
			ident := quin first.
			start := quin second.
			end := quin third.
			step := quin fourth.
			body := quin fifth.
			String
				new: 1024
				streamContents: [ :stream | 
					stream
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
						nextPutAll: ']' ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inds: arg [
	^ '(1 to: ' , arg , ' size) asSet'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> initialisation [
	^ ((self reserved: 'init') , identifier , (self operator: '==') , identifier , eq , 'mk_' asParser , identifier
		, lparen , ((expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ])
		, rparen)
		==> [ :array | 
			| patVar patVar2 constructor values |
			patVar := array second.
			patVar2 := array fourth.
			patVar = patVar2
				ifTrue: [ 
					constructor := array seventh.
					values := array ninth.
					{constructor.
					values} ]
				ifFalse: [ PPFailure message: 'init pattern mismatch: ' , patVar , ', ' , patVar2 ] ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> inmapType [
	^ super inmapType
		==> [ :pair | 
			| domaintype rangetype |
			domaintype := pair first.
			rangetype := pair second.
			'(' , domaintype , ' inmapTo: ' , rangetype , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inter: arg1 and: arg2 [
	^ '(' , arg1 , ' intersection: ' , arg2 , ')'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> invariantFunction [
	^ super invariantFunction
		==> [ :pair | 
			| pat patVars patMatcher expr valVar |
			pat := pair first.
			patVars := pat first reject: #isNil.
			patMatcher := pat second.
			expr := pair second.
			valVar := (self
				varNameGenerator: 'value'
				uniqueIn:
					{(pat second).
					expr}) value.
			'[:' , valVar , '||' , (' ' join: patVars) , '|'
				, (self binder: pat second with: valVar vars: (pat first reject: #isNil)) , ' and: [' , expr , ']]' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> inverse: arg [
	^ arg , ' inversed'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> iotaExpression [
	^ super iotaExpression
		==> [ :pair | 
			| pat setOrType exprPart var |
			pat := pair first first.
			setOrType := pair first second.
			exprPart := pair second.
			var := (self varNameGenerator: 'exists1' uniqueIn: (Array with: exprPart)) value.
			'(' , setOrType , ' detect: [ :' , var , '||' , (' ' join: pat first) , '|'
				, (self binder: pat second with: var vars: pat first) , ' ifFalse: [ViennaNoMatch signal].' , exprPart , '])' ]
]

{ #category : #'parsers-type discriminations' }
ViennaVDM2SmalltalkTranslator >> isExpression [
	^ super isExpression
		==> [ :pair | 
			| typeName expr |
			typeName := pair first.
			expr := pair second.
			(#('bool' 'nat' 'nat1' 'int' 'rat' 'real' 'char' 'token') includes: typeName)
				ifTrue: [ '(ViennaType ' , typeName , ' includes: ' , expr , ')' ]
				ifFalse: [ '(' , typeName , ' includes: ' , expr , ')' ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> iterateExpression: expr1 and: expr2 [
	^ '(' , expr1 , ' ** ' , expr2 , ')'
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
ViennaVDM2SmalltalkTranslator >> letBeExpression [
	^ super letBeExpression
		==> [ :pair | 
			| multibind guard expr varGenerator |
			multibind := pair first.
			guard := pair second.
			expr := pair third.
			varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: expr).
			String
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
						nextPutAll: '] value' ] ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> letBeStatement [
	^ super letBeStatement
		==> [ :pair | 
			| multibind guard expr varGenerator |
			multibind := pair first.
			guard := pair second.
			expr := pair third.
			varGenerator := self varNameGenerator: 'letbe' uniqueIn: (Array with: multibind second with: guard with: expr).
			String
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
						nextPutAll: '] value' ] ]
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

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> letStatement [
	^ super letStatement
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
				, (pairs ifEmpty: [ ')' ] ifNotEmpty: [ '; yourself)' ]) ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> mapEnumerationPattern [
	^ super mapEnumerationPattern
		==> [ :patternPairs | 
			| vars maplets |
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
			{vars.
			('(ViennaRuntimeUtil matchMapEnumeration: {'
				, (' . ' join: (maplets collect: [ :pair | '{' , pair first , ' . ' , pair second , '}' ])) , '})')} ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> mapMunionPattern [
	^ super mapMunionPattern
		==> [ :pair | 
			| vars pat1 pat2 |
			vars := (pair first first , pair second first) asSet asArray.
			pat1 := pair first second.
			pat2 := pair second second.
			{vars.
			('(ViennaRuntimeUtil match: ' , pat1 , ' munion: ' , pat2 , ')')} ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> mapOrSequenceReference: stateDesig with: expr [
	| ident path |
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

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> mapType [
	^ super mapType
		==> [ :pair | 
			| domaintype rangetype |
			domaintype := pair first.
			rangetype := pair second.
			'(' , domaintype , ' mapTo: ' , rangetype , ')' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> matchValueExpression [
	^ super matchValueExpression
		==> [ :expressionString | 
			{#().
			('(ViennaRuntimeUtil matchValue: ' , expressionString , ')')} ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> matchValueLiteral [
	^ super matchValueLiteral
		==> [ :literal | 
			{#().
			('(ViennaRuntimeUtil matchValue: ' , literal , ')')} ]
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

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> multipleAssignStatement [
	^ ((self reserved: 'atomic') , lparen , (super assignStatement separatedBy: semicolon) withoutSeparators , rparen)
		==> [ :quatro | 
			| assigns |
			assigns := quatro third.
			assigns size < 2
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
							stream nextPutAll: '] value' ] ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> munion: arg1 and: arg2 [
	^ '(Dictionary new addAll: ' , arg1 , '; addAll: ' , arg2 , '; yourself)'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> name [
	^ super name
		==> [ :stringOrPair | 
			stringOrPair isString
				ifTrue: [ stringOrPair ]
				ifFalse: [ '(' , stringOrPair first , ' at: ' , stringOrPair second storeString , ')' ] ]
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> nilLiteral [
	^ super nilLiteral ==> [ :t | 'nil' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> nondeterministicStatement [
	^ super nondeterministicStatement
		==> [ :statements | 'ViennaRuntimeUtil shuffleDo: {' , ('.' join: (statements collect: [ :s | '[' , s , ']' ])) , '}' ]
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

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> operationDefinitions [
	^ super operationDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :def | vs , def first ].
			{vars.
			(array inject: '' into: [ :code :def | code , def second , '.' ])} ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> optionalType [
	^ super optionalType ==> [ :basetype | basetype , ' optional' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> or: arg1 and: arg2 [
	^ '(' , arg1 , ' or: [' , arg2 , '])'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> partialFunctionType [
	^ super partialFunctionType
		==> [ :pair | 
			| argstype return |
			argstype := pair first.
			return := pair second.
			'(' , argstype , '->' , return , ')' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> patternBind [
	^ (bind ==> [ :pair | pair first ]) / pattern
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> patternIdentifier [
	^ super patternIdentifier
		==> [ :identifierOrNil | 
			{(Array with: identifierOrNil).
			('(ViennaRuntimeUtil matchIdentifier: ' , identifierOrNil storeString , ')')} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> plus: arg1 and: arg2 [
	^ '(' , arg1 , '+' , arg2 , ')'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> power: set [
	^ set , ' power'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> productType [
	^ super productType ==> [ :basetypes | '(' , ('*' join: basetypes) , ')' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> psubset: arg1 and: arg2 [
	^ '([:set1 :set2 | set1 size < set2 size and: [ set2 includesAll: set1 ]] value: ' , arg1 , ' value: ' , arg2 , ')'
]

{ #category : #'parsers-literals' }
ViennaVDM2SmalltalkTranslator >> quoteLiteral [
	^ super quoteLiteral ==> [ :quote | '#''' , quote , '''' ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> quoteType [
	^ super quoteType ==> [ :quote | '(ViennaType quote: ' , quote , ')' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> recordConstructor [
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			args := constructorAndArgs second.
			'(ViennaComposite constructorName: ' , constructorName storeString , ' withAll: {' , (' . ' join: args) , '})' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> recordModifier [
	^ super recordModifier
		==> [ :pair | 
			| record modifiers |
			record := pair first.
			modifiers := pair second.
			'(' , record , ' copy '
				,
					('; '
						join:
							(modifiers collect: [ :fieldAndValue | ' at: ' , fieldAndValue first storeString , ' put: ' , fieldAndValue second ]))
				, '; yourself)' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> recordPattern [
	^ super recordPattern
		==> [ :tuple | 
			| constructorName argPatterns vars args |
			constructorName := tuple first.
			argPatterns := tuple second.
			vars := OrderedCollection new.
			argPatterns do: [ :arg | vars addAll: arg first ].
			args := (argPatterns collect: #second) asSet asArray.
			{vars.
			('(ViennaRuntimeUtil matchRecord: ' , constructorName storeString , ' args: {' , (' . ' join: args) , '})')} ]
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> recordTypeDefinition [
	^ super recordTypeDefinition
		==> [ :array | 
			| ident flist inv record |
			ident := array first.
			flist := array second.
			inv := array third.
			record := 'ViennaCompositeType constructorName: ' , ident storeString , ' withAll: {' , (' . ' join: flist) , '}'.
			inv ifNotNil: [ record := '(' , record , ') inv: ' , inv ].
			ident , ' := ' , record , '.' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> rem: arg1 and: arg2 [
	^ '(' , arg1 , ' rem: ' , arg2 , ')'
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> returnStatement [
	^ super returnStatement ==> [ :expr | 'thisContext viennaReturn: ' , expr ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> rng: arg [
	^ arg , ' values asSet'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> seq1Type [
	^ super seq1Type ==> [ :basetype | basetype , ' seq1' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> seqConcPattern [
	^ super seqConcPattern
		==> [ :pair | 
			| vars pat1 pat2 |
			vars := (pair first first , pair second first) asSet asArray.
			pat1 := pair first second.
			pat2 := pair second second.
			{vars.
			('(ViennaRuntimeUtil match: ' , pat1 , ' conc: ' , pat2 , ')')} ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> seqEnumPattern [
	^ super seqEnumPattern
		==> [ :elementPatterns | 
			| vars elements |
			vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ])
				asSet asArray.
			elements := elementPatterns collect: #second.
			{vars.
			('(ViennaRuntimeUtil matchSequenceEnumeration: {' , (' . ' join: elements) , '})')} ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> seqType [
	^ super seqType ==> [ :basetype | basetype , ' seq' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceComprehension [
	^ super sequenceComprehension
		==> [ :triple | 
			| expr setBinding pat vars matcher set guard varGenerator seq |
			expr := triple first.
			setBinding := triple second.
			pat := setBinding first.
			vars := pat first .
			matcher := pat second.
			set := setBinding second.
			guard := triple third.
			varGenerator := self
				varNameGenerator: 'seq'
				uniqueIn:
					{expr.
					matcher.
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
						nextPutAll: '] value' ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asOrderedCollection' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> sequenceForLoop [
	^ super sequenceForLoop
		==> [ :triple | 
			| pat seqExpr body varGenerator |
			pat := triple first.
			seqExpr := triple second.
			body := triple third.
			varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: seqExpr with: body) , pat first.
			String
				new: 1024
				streamContents: [ :stream | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: seqExpr;
						nextPutAll: ' do: [:';
						nextPutAll: loopVar;
						nextPutAll: '||';
						nextPutAll: (' ' join: pat first);
						nextPutAll: '|';
						nextPutAll: (self binder: pat second with: loopVar vars: pat first);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
					stream nextPutAll: body.
					stream nextPutAll: ']' ] ]
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

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> setEnumPattern [
	^ super setEnumPattern
		==> [ :elementPatterns | 
			| vars elements |
			vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ])
				asSet asArray.
			elements := elementPatterns collect: #second.
			{vars.
			('(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elements) , '})')} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setEnumeration [
	^ super setEnumeration ==> [ :elems | '{' , (' . ' join: elems) , '} asSet' ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> setForLoop [
	^ super setForLoop
		==> [ :triple | 
			| pat setExpr body varGenerator |
			pat := triple first.
			setExpr := triple second.
			body := triple third.
			varGenerator := self varNameGenerator: 'for' uniqueIn: (Array with: setExpr with: body) , pat first.
			String
				new: 1024
				streamContents: [ :stream | 
					| loopVar |
					loopVar := varGenerator value.
					stream
						nextPutAll: setExpr;
						nextPutAll: ' asSortedCollection do: [:';
						nextPutAll: loopVar;
						nextPutAll: '||';
						nextPutAll: (' ' join: pat first);
						nextPutAll: '|';
						nextPutAll: (self binder: pat second with: loopVar vars: pat first);
						nextPutAll: ' ifFalse: [ViennaNoMatch signal].'.
					stream nextPutAll: body.
					stream nextPutAll: ']' ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> setRangeExpression [
	^ super setRangeExpression ==> [ :pair | '(' , pair first , ' to: ' , pair second , ') asSet' ]
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> setType [
	^ super setType ==> [ :basetype | basetype , ' set' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> setUnionPattern [
	^ super setUnionPattern
		==> [ :pair | 
			| vars pat1 pat2 |
			vars := (pair first first , pair second first) asSet asArray.
			pat1 := pair first second.
			pat2 := pair second second.
			{vars.
			('(ViennaRuntimeUtil match: ' , pat1 , ' union: ' , pat2 , ')')} ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> smalltalkStatement [
	| backquote |
	backquote := $` asParser.
	^ ((backquote , ((backquote not , #any asParser) ==> #second) star , backquote)
		==> [ :triple | String withAll: triple second ]) trim
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> stateDefinition [
	^ super stateDefinition
		==> [ :quatro | 
			| constructor fields init vars |
			constructor := quatro first.
			fields := quatro second.
			init := quatro fourth.
			vars := fields collect: #first.
			init
				ifNil: [ PPFailure message: 'initalisation is required in state definition' ]
				ifNotNil: [ 
					| initConstructor values |
					initConstructor := init first.
					values := init second.
					initConstructor = constructor
						ifTrue: [ 
							vars size = values size
								ifTrue: [ 
									{vars.
									((1 to: vars size)
										inject: ''
										into: [ :code :index | code , (vars at: index) , ' := ' , (values at: index) , '.' ])} ]
								ifFalse: [ 
									PPFailure
										message:
											'Number of state variables and number of arguments must agree: ' , vars size printString , ', '
												, values size printString ] ]
						ifFalse: [ PPFailure message: 'Constructor must be the same name as state definition: ' , constructor , ', ' , initConstructor ] ] ]
]

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> statement [
	^ super statement / self smalltalkStatement
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
	^ arg , ' tail'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> totalFunctionType [
	^ super totalFunctionType
		==> [ :pair | 
			| argstype return |
			argstype := pair first.
			return := pair second.
			'(' , argstype , '+>' , return , ')' ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> tupleConstructor [
	^ super tupleConstructor ==> [ :array | '{' , (' . ' join: array) , '}' ]
]

{ #category : #'parsers-patterns' }
ViennaVDM2SmalltalkTranslator >> tuplePattern [
	^ super tuplePattern
		==> [ :argPatterns | 
			| vars args |
			vars := Set new.
			argPatterns do: [ :arg | vars addAll: arg first ].
			vars := vars asArray.
			args := argPatterns collect: #second.
			{vars.
			('(ViennaRuntimeUtil matchTuple: {' , (' . ' join: args) , '})')} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> tupleSelect: tuple with: index [
	^ '(' , tuple , ' at: ' , index , ')'
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> typeDefinitions [
	^ super typeDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :typedef | vs , typedef first ].
			{vars.
			(array inject: '' into: [ :code :typedef | code , typedef second ])} ]
]

{ #category : #'parsers-type discriminations' }
ViennaVDM2SmalltalkTranslator >> typeJudgement [
	^ super typeJudgement
		==> [ :pair | 
			| t e |
			t := pair second.
			e := pair first.
			'(' , t , ' includes: ' , e , ')' ]
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> typeSynonym [
	^ super typeSynonym
		==> [ :triple | 
			| ident typeExpr inv |
			ident := triple first.
			typeExpr := triple second.
			inv := triple third.
			{{ident}.
			(ident , ' := ' , typeExpr , (inv ifNotNil: [ ' inv: ' , inv ] ifNil: [ '' ]) , '.')} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> unaryMinus: arg [
	^ arg , ' negated'
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> unaryPlus: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDM2SmalltalkTranslator >> undefinedExpression [
	^ super undefinedExpression ==> [ :t | 'ViennaUndefinedEvaluationError signal' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDM2SmalltalkTranslator >> union: arg1 and: arg2 [
	^ '(' , arg1 , ' copy addAll: ' , arg2 , '; yourself)'
]

{ #category : #'parsers-types' }
ViennaVDM2SmalltalkTranslator >> unionType [
	^ super unionType ==> [ :basetypes | '(' , ('|' join: basetypes) , ')' ]
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> valueDefinition [
	^ super valueDefinition
		==> [ :triple | 
			| pat body vars binder |
			pat := triple first.
			body := triple third.
			vars := pat first.
			binder := self binder: pat second with: body vars: vars.
			{vars.
			'(', binder, '  ifFalse: [ViennaNoMatch signal])'} ]
]

{ #category : #'parsers-definitions' }
ViennaVDM2SmalltalkTranslator >> valueDefinitions [
	^ super valueDefinitions
		==> [ :array | 
			| vars |
			vars := array inject: #() into: [ :vs :valdef | vs , valdef first ].
			{vars.
			(array inject: '' into: [ :code :valdef | code , valdef second , '.' ])} ]
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

{ #category : #'parsers-statements' }
ViennaVDM2SmalltalkTranslator >> whileLoop [
	^ super whileLoop
		==> [ :pair | 
			| cond body |
			cond := pair first.
			body := pair second.
			'[' , cond , '] whileTrue: [' , body , ']' ]
]

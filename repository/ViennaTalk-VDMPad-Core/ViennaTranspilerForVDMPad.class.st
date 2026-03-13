Class {
	#name : 'ViennaTranspilerForVDMPad',
	#superclass : 'ViennaTranspilerForExecutionTracing',
	#category : 'ViennaTalk-VDMPad-Core',
	#package : 'ViennaTalk-VDMPad-Core'
}

{ #category : 'code generation-expressions' }
ViennaTranspilerForVDMPad >> apply: aViennaNode env: aDictionary [

	| func args |
	func := '(_document _step: '
	        , (self generate: aViennaNode function env: aDictionary)
	        , ')'.
	args := self
		        generate: aViennaNode argumentExpressionList
		        env: aDictionary.
	^ args ifEmpty: [ func , ' value' ] ifNotEmpty: [
			  args size <= 4
				  ifTrue: [
				  '(' , func , ' value: ' , (' value: ' join: args) , ')' ]
				  ifFalse: [
				  '(' , func , ' valueWithArguments: {' , (' . ' join: args)
				  , '})' ] ]
]

{ #category : 'code generation-statements' }
ViennaTranspilerForVDMPad >> callStatement: aViennaNode env: aDictionary [

	| callee args |
	callee := '(_document _step: '
	          , (self generate: aViennaNode name env: aDictionary) , ')'.
	args := self generate: aViennaNode expressionList env: aDictionary.
	^ args
		  ifEmpty: [ callee , ' value' ]
		  ifNotEmpty: [
		  '(' , callee , ' value: ' , (' value: ' join: args) , ')' ]
]

{ #category : 'class access' }
ViennaTranspilerForVDMPad >> documentBaseClass [

	^ ViennaTranspiledModularDocumentForVDMPad
]

{ #category : 'code generation-statements' }
ViennaTranspilerForVDMPad >> indexForLoop: aViennaNode env: aDictionary [

	| ident start end step body |
	ident := self generate: aViennaNode identifier env: aDictionary.
	start := self generate: aViennaNode startExpression env: aDictionary.
	end := self generate: aViennaNode endExpression env: aDictionary.
	step := self generate: aViennaNode stepExpression env: aDictionary.
	body := self generate: aViennaNode statement env: aDictionary.
	^ self stringStreamContents: [ :stream |
		  stream
			  nextPut: Character space;
			  nextPutAll: start;
			  nextPutAll: ' to: ';
			  nextPutAll: end.
		  step ifNotNil: [
			  stream
				  nextPutAll: ' by: ';
				  nextPutAll: step ].
		  stream
			  nextPutAll: ' do: [:';
			  nextPutAll: ident;
			  nextPutAll: '| _document _step: nil. ';
			  nextPutAll: body;
			  nextPutAll: ']' ]
]

{ #category : 'code generation-expressions' }
ViennaTranspilerForVDMPad >> mapComprehension: aViennaNode env: aDictionary [

	| keyExpr valueExpr bindListNode guard varGenerator map pair flatBinds setsAndVars |
	keyExpr := self generate: aViennaNode first env: aDictionary.
	valueExpr := self generate: aViennaNode second env: aDictionary.
	bindListNode := aViennaNode third.
	guard := self generate: aViennaNode fourth env: aDictionary.
	varGenerator := self varNameGenerator: 'map' uniqueIn: {
			                keyExpr.
			                valueExpr } , { (guard ifNil: [ '' ]) }.
	map := varGenerator value.
	pair := self
		        flattenBindList: bindListNode
		        varGenerator: varGenerator
		        env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ self stringStreamContents: [ :stream |
			  | body |
			  body := map , ' at: ' , keyExpr , ' put: ' , valueExpr.
			  guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			  body := '_document _step: (' , body , ')'.
			  stream nextPutAll: '(['.
			  setsAndVars do: [ :setAndVar |
					  stream
						  nextPutAll: ' :';
						  nextPutAll: setAndVar second ].
			  stream
				  nextPutAll: ' | | ' , map , ' | ' , map , ' :=Dictionary new.';
				  nextPutAll: (self
						   generatorFromFlatBinds: flatBinds
						   body: body
						   varGenerator: varGenerator
						   env: aDictionary);
				  nextPutAll: '. ';
				  nextPutAll: map;
				  nextPutAll: ']'.
			  setsAndVars do: [ :setAndVar |
					  stream
						  nextPutAll: ' value: ';
						  nextPutAll: setAndVar first ].
			  stream nextPut: $) ]
]

{ #category : 'code generation-expressions' }
ViennaTranspilerForVDMPad >> sequenceComprehension: aViennaNode env: aDictionary [

	| expr bindNode setNode guard varGenerator seq set |
	expr := self generate: aViennaNode first env: aDictionary.
	bindNode := aViennaNode second.
	setNode := bindNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self varNameGenerator: 'seq' uniqueIn: {
			                expr.
			                (guard ifNil: [ '' ]) }.
	seq := varGenerator value.
	set := varGenerator value.
	bindNode first isViennaPatternIdentifierNode ifTrue: [
			| var |
			var := bindNode first first.
			expr := '_document _step: ' , expr.
			^ bindNode isViennaSeqBindNode
				  ifTrue: [
						  '(' , (self generate: setNode env: aDictionary) , (guard
							   ifNotNil: [
									   ' select: [:' , var , ' | ' , guard , '] thenCollect: [:'
									   , var , ' | ' ]
							   ifNil: [ ' collect: [:' , var , ' | ' ]) , expr , '])' ]
				  ifFalse: [
						  '(' , (setNode isViennaSetRangeExpressionNode
							   ifTrue: [
							   '(' , (self intervalExpression: setNode env: aDictionary)
							   , ')' ]
							   ifFalse: [
									   setNode isViennaSequenceIndicesNode
										   ifTrue: [
										   '(' , (self indicesExpression: setNode env: aDictionary)
										   , ')' ]
										   ifFalse: [
										   (self generate: setNode env: aDictionary)
										   , ' asSortedCollection' ] ]) , (guard
							   ifNotNil: [
									   ' select: [:' , var , ' | ' , guard , '] thenCollect: [:'
									   , var , ' | ' ]
							   ifNil: [ ' collect: [:' , var , ' | ' ]) , expr
						  , ']) asOrderedCollection' ] ].
	^ self stringStreamContents: [ :stream |
			  | body |
			  body := seq , ' add: ' , expr.
			  guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			  body := '_document _step: (' , body , ')'.
			  stream
				  nextPutAll: '([ :' , set , ' | | ' , seq , ' | ' , seq
					  , ' :=OrderedCollection new.';
				  nextPutAll: (self
						   generatorFromFlatBinds: { {
								   bindNode first.
								   (ViennaLocalNameNode identifier: set) } }
						   body: body
						   varGenerator: varGenerator
						   env: aDictionary);
				  nextPutAll: '. ';
				  nextPutAll: seq;
				  nextPutAll: '] value: ';
				  nextPutAll: (setNode isViennaSetRangeExpressionNode
						   ifTrue: [
							   '(' , (self intervalExpression: setNode env: aDictionary)
							   , ')' ]
						   ifFalse: [
							   (self generate: setNode env: aDictionary)
							   , ' asSortedCollection' ]);
				  nextPut: $) ]
]

{ #category : 'code generation-statements' }
ViennaTranspilerForVDMPad >> sequenceForLoop: aViennaNode env: aDictionary [

	| guard patNode pat seqExpr body vars varGenerator |
	guard := nil.
	patNode := aViennaNode patternOrBind.
	patNode isViennaBindNode ifTrue: [
			guard := self generate: patNode typeOrExpression env: aDictionary.
			patNode := patNode pattern ].
	pat := self generate: patNode env: aDictionary.
	seqExpr := self generate: aViennaNode expression env: aDictionary.
	body := self generate: aViennaNode statement env: aDictionary.
	patNode isViennaPatternIdentifierNode ifTrue: [
			^ seqExpr , ' do: [:' , patNode identifier , ' | _document _step: nil. '
			  , (guard ifNil: [ '' ] ifNotNil: [
						   '(' , guard , ' includes: ' , patNode identifier
						   , ') ifFalse: [ViennaBindingViolation signal].' ]) , body
			  , ']' ].
	vars := aViennaNode patternOrBind uniqueBoundIdentifiers.
	varGenerator := self
		                varNameGenerator: 'for'
		                uniqueIn: (Array with: seqExpr with: body) , vars.
	^ self stringStreamContents: [ :stream |
			  | loopVar |
			  loopVar := varGenerator value.
			  stream
				  nextPutAll: seqExpr;
				  nextPutAll: ' do: [:';
				  nextPutAll: loopVar;
				  nextPutAll: '||';
				  nextPutAll: (' ' join: vars);
				  nextPutAll: '|';
				  nextPutAll: (guard ifNil: [ '' ] ifNotNil: [
								   '(' , guard , ' includes: ' , loopVar
								   , ') ifFalse: [ViennaBindingViolation signal].' ]);
				  nextPutAll: (self binder: pat with: loopVar vars: vars);
				  nextPutAll: ' ifFalse: [ViennaNoMatch signal].';
				  nextPutAll: '_document _step: nil. ';
				  nextPutAll: body;
				  nextPutAll: ']' ]
]

{ #category : 'code generation-expressions' }
ViennaTranspilerForVDMPad >> setComprehension: aViennaNode env: aDictionary [

	| expr bindListNode guard varGenerator set pair setsAndVars flatBinds |
	expr := self generate: aViennaNode first env: aDictionary.
	bindListNode := aViennaNode second.
	guard := self generate: aViennaNode third env: aDictionary.
	varGenerator := self
		                varNameGenerator: 'set'
		                uniqueIn:
		                (Array with: expr)
		                , (Array with: (guard ifNil: [ '' ])).
	set := varGenerator value.
	pair := self
		        flattenBindList: bindListNode
		        varGenerator: varGenerator
		        env: aDictionary.
	flatBinds := pair first.
	setsAndVars := pair second.
	^ self stringStreamContents: [ :stream |
			  | body |
			  body := set , ' add: ' , expr.
			  guard ifNotNil: [ body := guard , ' ifTrue: [' , body , ']' ].
			  body := '_document _step: (' , body , ')'.
			  stream nextPutAll: '(['.
			  setsAndVars do: [ :setAndVar |
					  stream
						  nextPutAll: ' :';
						  nextPutAll: setAndVar second ].
			  stream
				  nextPutAll: ' | | ' , set , ' | ' , set , ' :=Set new.';
				  nextPutAll: (self
						   generatorFromFlatBinds: flatBinds
						   body: body
						   varGenerator: varGenerator
						   env: aDictionary);
				  nextPutAll: '. ';
				  nextPutAll: set;
				  nextPutAll: ']'.
			  setsAndVars do: [ :setAndVar |
					  stream
						  nextPutAll: ' value: ';
						  nextPutAll: setAndVar first ].
			  stream nextPut: $) ]
]

{ #category : 'code generation-statements' }
ViennaTranspilerForVDMPad >> setForLoop: aViennaNode env: aDictionary [

	| pat setExpr body vars varGenerator |
	pat := self generate: aViennaNode pattern env: aDictionary.
	body := self generate: aViennaNode third env: aDictionary.
	(aViennaNode pattern isViennaPatternIdentifierNode and: [
		 aViennaNode expression isViennaFinitePowerSetNode ]) ifTrue: [
			^ (self
				   generate: aViennaNode expression expression
				   env: aDictionary) , ' powerDo: [:'
			  , aViennaNode pattern identifier , ' | ' , body , ']' ].
	setExpr := aViennaNode expression isViennaSetRangeExpressionNode
		           ifTrue: [
		           self
			           intervalExpression: aViennaNode expression
			           env: aDictionary ]
		           ifFalse: [
		           self generate: aViennaNode expression env: aDictionary ].
	aViennaNode pattern isViennaPatternIdentifierNode ifTrue: [
			^ setExpr , ' do: [:' , aViennaNode pattern identifier , ' | _document _step: nil. '
			  , body , ']' ].
	vars := aViennaNode pattern uniqueBoundIdentifiers.
	varGenerator := self
		                varNameGenerator: 'for'
		                uniqueIn: (Array with: setExpr with: body) , vars.
	^ self stringStreamContents: [ :stream |
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
				  nextPutAll: ' ifFalse: [ViennaNoMatch signal].';
				  nextPutAll: '_document _step: nil. ';
				  nextPutAll: body;
				  nextPutAll: ']' ]
]

{ #category : 'code generation-statements' }
ViennaTranspilerForVDMPad >> whileLoop: aViennaNode env: aDictionary [
	| cond body |
	cond := self generate: aViennaNode first env: aDictionary.
	body := self generate: aViennaNode second env: aDictionary.
	^ '[_document _step: nil. ' , cond , '] whileTrue: [' , body , ']'
]

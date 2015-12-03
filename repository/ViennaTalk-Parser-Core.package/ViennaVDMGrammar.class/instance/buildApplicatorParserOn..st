parsers-expressions
buildApplicatorParserOn: anExpressionParser
	| applyArgs subsequenceArgs functionTypeInstantiationArgs fieldSelector tupleSelector actions |
	applyArgs := (lparen
		, (expressionList) , rparen)
		==> [ :triple | 
			{#apply.
			(triple second)} ].
	subsequenceArgs := (lparen , expression , comma , (self operator: '...') , comma , expression , rparen)
		==> [ :array | 
			{#subsequence.
			(array second).
			(array sixth)} ].
	functionTypeInstantiationArgs := (lbracket , (type separatedBy: comma) withoutSeparators , rbracket)
		==> [ :triple | 
			{#instantiation.
			(triple second)} ].
	fieldSelector := ((self operator: $.) , identifier)
		==> [ :pair | 
			{#field.
			(pair second)} ].
	tupleSelector := ((self operator: '.#') , #digit asParser plus flatten trim)
		==> [ :pair | 
			{#tuple.
			(pair second)} ].
	actions := Dictionary new
		at: #apply put: [ :left :right | self apply: left args: right second ];
		at: #subsequence put: [ :left :right | self subsequence: left from: right second to: right third ];
		at: #instantiation put: [ :left :right | self functionTypeInstantiation: left args: right second ];
		at: #field put: [ :left :right | self fieldSelect: left with: right second ];
		at: #tuple put: [ :left :right | self tupleSelect: left with: right second ];
		yourself.
	anExpressionParser
		precedence: [ :expr | expr , (applyArgs / subsequenceArgs / functionTypeInstantiationArgs / tupleSelector / fieldSelector) plus ]
		do: [ :pair | pair second inject: pair first into: [ :left :right | (actions at: right first) value: left value: right ] ]
parsers-expressions
buildApplicatorParserOn: anExpressionParser
	| applyArgs subsequenceArgs functionTypeInstantiationArgs fieldSelector actions |
	applyArgs := ((self operator: $()
		, ((expression separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :args | args ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :triple | 
			{#apply.
			(triple second)} ].
	subsequenceArgs := ((self operator: $() , expression , (self operator: $,) , (self operator: '...')
		, (self operator: ',') , expression , (self operator: $)))
		==> [ :array | 
			{#subsequence.
			(array second).
			(array sixth)} ].
	functionTypeInstantiationArgs := ((self operator: $[) , (type separatedBy: (self operator: $,)) withoutSeparators
		, (self operator: $]))
		==> [ :triple | 
			{#instantiation.
			(triple second)} ].
	fieldSelector := ((self operator: $.) , identifier)
		==> [ :pair | 
			{#field.
			(pair second)} ].
	actions := Dictionary new
		at: #apply put: [ :left :right | self apply: left args: right second ];
		at: #subsequence put: [ :left :right | self subsequence: left from: right second to: right third ];
		at: #instantiation put: [ :left :right | self functionTypeInstantiation: left args: right second ];
		at: #field put: [ :left :right | self fieldSelect: left with: right second ];
		yourself.
	anExpressionParser
		precedence: [ :expr | 'mk_' asParser not , expr , (applyArgs / subsequenceArgs / functionTypeInstantiationArgs / fieldSelector) plus ]
		do: [ :triple | triple third inject: triple second into: [ :left :right | (actions at: right first) value: left value: right ] ]
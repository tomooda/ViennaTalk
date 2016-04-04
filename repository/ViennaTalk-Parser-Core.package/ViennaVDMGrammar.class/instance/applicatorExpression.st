parsers-expressions
applicatorExpression
	^ (self combinatorExpression
		,
			(((lparen , expression , comma , self dots , comma , expression , rparen)
				==> [ :array | 
					{#subsequence:from:to:.
					(array second).
					(array sixth)} ])
				/
					((lparen , expressionList , rparen)
						==> [ :array | 
							{#apply:args:.
							(array second)} ])
				/
					((lbracket , (type separatedBy: comma) withoutSeparators , rbracket)
						==> [ :array | 
							{#functionTypeInstantiation:args:.
							(array second)} ])
				/
					(((self operator: $.) , identifier trim)
						==> [ :array | 
							{#fieldSelect:with:.
							(array second)} ])
				/
					(((self operator: '.#') , #digit asParser plus flatten trim)
						==> [ :array | 
							{#tupleSelect:with:.
							(array second)} ])) star)
		==> [ :pair | 
			| left array |
			left := pair first.
			array := pair second.
			array
				inject: left
				into: [ :expr :selAndArg | 
					self
						perform: selAndArg first
						withArguments:
							(selAndArg copy
								at: 1 put: expr;
								yourself) ] ]
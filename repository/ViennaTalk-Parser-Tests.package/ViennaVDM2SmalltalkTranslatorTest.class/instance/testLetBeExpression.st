tests-expressions
testLetBeExpression
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
						let
							mk_(x, y), mk_(z, w) in set {mk_(1, 2), mk_(2, 3)}
						be st
							y = z
						in
							mk_(x, y, z, w)'))
		equals: #(1 2 2 3).
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
						let
							mk_(x, y), mk_(z, w) in set {mk_(1, 2), mk_(3, 4)}
						be st
							y = z
						in
							mk_(x, y, z, w)') ]
		raise: NotFound
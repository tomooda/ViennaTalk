tests-operators
testFunctionTypeInstantiationArgs
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
					let 
						inc[@num] : @num -> @num
						inc(x) == x + 1
					in
						inc[int](2)'))
		equals: 3
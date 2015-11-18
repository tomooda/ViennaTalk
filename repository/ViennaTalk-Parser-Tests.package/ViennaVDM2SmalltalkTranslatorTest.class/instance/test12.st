testing
test12
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
	let
		f : int * int -> int f(x,y)==x+y,
		g : int -> int * int g(x) == mk_(x, x)
	in
		(f comp g)(1)'))
		equals: 2
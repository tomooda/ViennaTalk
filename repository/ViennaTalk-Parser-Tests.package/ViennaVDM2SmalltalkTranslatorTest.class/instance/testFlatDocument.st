tests-definitions
testFlatDocument
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new flatDocument trim end
						parse:
							'
				types T = nat; 
				values one:T = 1; 
				functions
					succ : T -> T
					succ(x) == x + 1;
				state S of
					count : T
					init s == s = mk_S(0)
				end
				operations 
					inc : () ==> T
					inc() == (count := succ(count); return count);') , '. inc value; value; value')
		equals: 3
tests-expressions
testMapApplication
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression parse: '({1|-><one>, 2|-><two>, 3|-><three>} comp {<one>|->1, <two>|->2,<three>|->3})(<two>)'))
		equals: #'<two>'
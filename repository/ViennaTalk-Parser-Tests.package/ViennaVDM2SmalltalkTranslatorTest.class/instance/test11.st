testing
test11
	self
		assert:
			(Compiler
				evaluate:
					(translator expression parse: '({1|-><one>, 2|-><two>, 3|-><three>} comp {<one>|->1, <two>|->2,<three>|->3})(<two>)'))
		equals: #'<two>'
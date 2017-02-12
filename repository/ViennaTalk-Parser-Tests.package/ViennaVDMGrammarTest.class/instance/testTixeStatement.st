tests-statements
testTixeStatement
	self assert: (grammar statement end parse: 'tixe { p1 |-> skip, p2 |-> return e1 } in return e2') equals: #(('p1' nil 'p2' 'e1') 'e2')
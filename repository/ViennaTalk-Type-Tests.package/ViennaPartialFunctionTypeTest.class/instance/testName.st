tests
testName
	self assert: (nat * int -> bool) name equals: 'nat*int->bool'.
	self assert: ((nat | bool) * int -> bool) name equals: '(nat|bool)*int->bool'.
	self assert: (int -> nat -> nat1) name equals: '(int->nat)->nat1'.
	self assert: (int -> (nat -> nat1)) name equals: 'int->nat->nat1'
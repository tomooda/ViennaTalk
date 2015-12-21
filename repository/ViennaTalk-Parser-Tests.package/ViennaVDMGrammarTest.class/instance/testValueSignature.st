tests-interfaces
testValueSignature
	self assert: (grammar valueSignature end parse: 'v1, v2 : nat') equals: #(#('v1' 'v2') 'nat')
tests
testChar4
	self should: [reader parse: '''\uabxyz'''] raise: Error
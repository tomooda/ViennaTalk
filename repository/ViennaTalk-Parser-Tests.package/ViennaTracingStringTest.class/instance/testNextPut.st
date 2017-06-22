tests
testNextPut
	| stream |
	stream := 'abc' asViennaTracingString: 1.
	stream nextPut: $z.
	self assert: stream string equals: 'abcz'.
	self assert: stream sources equals: (OrderedCollection with: (1 to: 3) -> 1)
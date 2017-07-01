tests
testNextPutAll
	| stream |
	stream := 'abc' asViennaTracingString: 1.
	stream nextPutAll: ('xyz' asViennaTracingString: 2).
	self assert: stream string equals: 'abcxyz'.
	self assert: stream sources equals: (OrderedCollection with: (1 to: 3) -> 1 with: (4 to: 6) -> 2)
	
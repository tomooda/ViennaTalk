Class {
	#name : #ViennaTracingStringTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTracingStringTest >> testAsString [
	self assert: ('abc' , ('xyz' asViennaTracingString: 1)) asString equals: 'abc' , 'xyz'
]

{ #category : #tests }
ViennaTracingStringTest >> testAsViennaTracingString [
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc asViennaTracingString == abc
]

{ #category : #tests }
ViennaTracingStringTest >> testAt [
	self assert: ('abc' asViennaTracingString at: 2) equals: ('abc' at: 2)
]

{ #category : #tests }
ViennaTracingStringTest >> testAtPut [
	self
		assert:
			('abc' asViennaTracingString
				at: 2 put: $B;
				yourself)
		equals:
			('abc'
				at: 2 put: $B;
				yourself)
]

{ #category : #tests }
ViennaTracingStringTest >> testBasicAt [
	self assert: ('abc' asViennaTracingString basicAt: 2) equals: ('abc' basicAt: 2)
]

{ #category : #tests }
ViennaTracingStringTest >> testComma [
	| abc xyz abcxyz |
	abc := 'abc' asViennaTracingString: 1.
	xyz := 'xyz' asViennaTracingString: 2.
	abcxyz := abc , xyz.
	self assert: abc string equals: 'abc'.
	self assert: abc sources equals: (OrderedCollection with: (1 to: 3) -> 1).
	self assert: xyz string equals: 'xyz'.
	self assert: xyz sources equals: (OrderedCollection with: (1 to: 3) -> 2).
	self assert: abcxyz string equals: 'abcxyz'.
	self assert: abcxyz sources equals: (OrderedCollection with: (1 to: 3) -> 1 with: (4 to: 6) -> 2)
]

{ #category : #tests }
ViennaTracingStringTest >> testCopyFromTo [
	| abcxyz bcxy |
	abcxyz := ('abc' asViennaTracingString: 1), ('xyz' asViennaTracingString: 2).
	bcxy := abcxyz copyFrom: 2 to: 5.
	self assert: (bcxy at: 1) equals: $b.
	self assert: (bcxy at: 2) equals: $c.
	self assert: (bcxy at: 3) equals: $x.
	self assert: (bcxy at: 4) equals: $y.
	self assert: (bcxy sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (bcxy sourceAt: 2 ifAbsent: []) equals: 1.
	self assert: (bcxy sourceAt: 3 ifAbsent: []) equals: 2.
	self assert: (bcxy sourceAt: 4 ifAbsent: []) equals: 2.
	
]

{ #category : #tests }
ViennaTracingStringTest >> testCr [
	| abc |
	abc := ('abc' asViennaTracingString: 1).
	abc cr.
	self assert: (abc at: 1) equals: $a.
	self assert: (abc at: 2) equals: $b.
	self assert: (abc at: 3) equals: $c.
	self assert: (abc at: 4) equals: Character cr.
	self assert: (abc sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 2 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 3 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 4 ifAbsent: []) equals: nil.
	
]

{ #category : #tests }
ViennaTracingStringTest >> testEquals [
	self assert: 'abc' asViennaTracingString = 'abc'.
	self assert: 'abc' asViennaTracingString = ('abc' asViennaTracingString: 1).
	self assert: 'abc' = 'abc' asViennaTracingString
]

{ #category : #tests }
ViennaTracingStringTest >> testHash [
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc hash equals: 'abc' hash
]

{ #category : #tests }
ViennaTracingStringTest >> testIsViennaTracingString [
	| abc |
	abc := 'abc' asViennaTracingString: 1.
	self assert: abc isViennaTracingString .
	self deny: 'abc' isViennaTracingString.
	self deny: Object new isViennaTracingString
]

{ #category : #tests }
ViennaTracingStringTest >> testJoin [
	| a b c abc |
	a := 'a' asViennaTracingString: 1.
	b := 'b'.
	c := 'c' asViennaTracingString: 3.
	abc := ' ' asViennaTracingString join: { a . b . c }.
	self assert: abc asString equals: 'a b c' .
	self assert: (abc sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 2 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 3 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 4 ifAbsent: []) equals: nil.
	self assert: (abc sourceAt: 5 ifAbsent: []) equals: 3.

]

{ #category : #tests }
ViennaTracingStringTest >> testNextPut [
	| stream |
	stream := 'abc' asViennaTracingString: 1.
	stream nextPut: $z.
	self assert: stream string equals: 'abcz'.
	self assert: stream sources equals: (OrderedCollection with: (1 to: 3) -> 1)
]

{ #category : #tests }
ViennaTracingStringTest >> testNextPutAll [
	| stream |
	stream := 'abc' asViennaTracingString: 1.
	stream nextPutAll: ('xyz' asViennaTracingString: 2).
	self assert: stream string equals: 'abcxyz'.
	self assert: stream sources equals: (OrderedCollection with: (1 to: 3) -> 1 with: (4 to: 6) -> 2)
	
]

{ #category : #tests }
ViennaTracingStringTest >> testPostCopy [
	| abc copy |
	abc := 'abc' asViennaTracingString.
	copy := abc copy.
	abc nextPutAll: 'xyz'.
	self assert: abc asString equals: 'abcxyz'.
	self assert: copy asString equals: 'abc'
]

{ #category : #tests }
ViennaTracingStringTest >> testSize [
	self assert: 'abc' asViennaTracingString size equals: 3
]

{ #category : #tests }
ViennaTracingStringTest >> testSourceAtIfAbsent [
	| abc xyz abcxyz |
	abc := 'abc' asViennaTracingString: 1.
	xyz := 'xyz'.
	abcxyz := abc , xyz.
	self assert: (abcxyz sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abcxyz sourceAt: 4 ifAbsent: []) equals: nil.

]

{ #category : #tests }
ViennaTracingStringTest >> testSpace [
	| abc |
	abc := ('abc' asViennaTracingString: 1).
	abc space.
	self assert: (abc at: 1) equals: $a.
	self assert: (abc at: 2) equals: $b.
	self assert: (abc at: 3) equals: $c.
	self assert: (abc at: 4) equals: Character space.
	self assert: (abc sourceAt: 1 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 2 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 3 ifAbsent: []) equals: 1.
	self assert: (abc sourceAt: 4 ifAbsent: []) equals: nil.
	
]

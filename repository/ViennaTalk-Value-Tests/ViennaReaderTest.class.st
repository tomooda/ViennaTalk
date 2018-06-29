Class {
	#name : #ViennaReaderTest,
	#superclass : #TestCase,
	#instVars : [
		'reader'
	],
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #running }
ViennaReaderTest >> setUp [
	reader := ViennaReader new
]

{ #category : #tests }
ViennaReaderTest >> testChar1 [
	self assert: (reader parse: '''a''') equals: $a
]

{ #category : #tests }
ViennaReaderTest >> testChar2 [
	self assert: (reader parse: '''\n''') equals: Character cr
]

{ #category : #tests }
ViennaReaderTest >> testChar3 [
	self should: [reader parse: '''abc'''] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testChar4 [
	self should: [reader parse: '''\uabxyz'''] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testComposite1 [
	self assert: (reader parse: 'mk_foo()') equals: (ViennaComposite constructorName: #foo)
]

{ #category : #tests }
ViennaReaderTest >> testComposite2 [
	self assert: (reader parse: 'mk_foo(1)') equals: (ViennaComposite constructorName: #foo with: 1)
]

{ #category : #tests }
ViennaReaderTest >> testComposite3 [
	self
		assert: (reader parse: 'mk_foo(1,2,3)')
		equals:
			(ViennaComposite
				constructorName: #foo
				with: 1
				with: 2
				with: 3)
]

{ #category : #tests }
ViennaReaderTest >> testFalse [
	self assert: (reader parse: 'false') equals: false
]

{ #category : #tests }
ViennaReaderTest >> testMap1 [
	self
		assert: (reader parse: '{1|->2, 3|->4}')
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 3 put: 4;
				yourself)
]

{ #category : #tests }
ViennaReaderTest >> testMap2 [
	self assert: (reader parse: '{|->}') equals: Dictionary new
]

{ #category : #tests }
ViennaReaderTest >> testMap3 [
	self
		assert: (reader parse: '{1 |-> 2}')
		equals:
			(Dictionary new
				at: 1 put: 2;
				yourself)
]

{ #category : #tests }
ViennaReaderTest >> testNil [
	self assert: (reader parse: 'nil') equals: nil
]

{ #category : #tests }
ViennaReaderTest >> testNumber1 [
	self assert: (reader parse: '1') equals: 1
]

{ #category : #tests }
ViennaReaderTest >> testNumber2 [
	self assert: (reader parse: '-1') equals: -1
]

{ #category : #tests }
ViennaReaderTest >> testNumber3 [
	self assert: (reader parse: '-3.14') equals: -3.14
]

{ #category : #tests }
ViennaReaderTest >> testNumber4 [
	self assert: (reader parse: '1.4e8') equals: 1.4e8
]

{ #category : #tests }
ViennaReaderTest >> testQuote1 [
	self assert: (reader parse: '<quote>') equals: #quote
]

{ #category : #tests }
ViennaReaderTest >> testQuote2 [
	self should: [reader parse: '<quo!te>'] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testSeq1 [
	self assert: (reader parse: '[]') equals: #() asOrderedCollection
]

{ #category : #tests }
ViennaReaderTest >> testSeq2 [
	self assert: (reader parse: '[1]') equals: #(1) asOrderedCollection
]

{ #category : #tests }
ViennaReaderTest >> testSeq3 [
	self assert: (reader parse: '[1, 2, 3]') equals: #(1 2 3) asOrderedCollection
]

{ #category : #tests }
ViennaReaderTest >> testSet1 [
	self assert: (reader parse: '{}') equals: #() asSet
]

{ #category : #tests }
ViennaReaderTest >> testSet2 [
	self assert: (reader parse: '{1}') equals: #(1) asSet
]

{ #category : #tests }
ViennaReaderTest >> testSet3 [
	self assert: (reader parse: '{1,2,3}') equals: #(1 2 3) asSet
]

{ #category : #tests }
ViennaReaderTest >> testString1 [
	self assert: (reader parse: '"abc"') equals: 'abc'
]

{ #category : #tests }
ViennaReaderTest >> testString2 [
	self assert: (reader parse: '"\n"') equals: String cr
]

{ #category : #tests }
ViennaReaderTest >> testString3 [
	self assert: (reader parse: '"\u0061bc"') equals: 'abc'
]

{ #category : #tests }
ViennaReaderTest >> testString4 [
	self should: [reader parse: '"\uxyzw"'] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testToken1 [
	self assert: (reader parse: 'mk_token(1)') equals: (ViennaComposite constructorName: #token with: 1)
]

{ #category : #tests }
ViennaReaderTest >> testToken2 [
	self should: [reader parse: 'mk_token()'] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testToken3 [
	self should: [reader parse: 'mk_token(1,2)'] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testTrue [
	self assert: (reader parse: 'true') equals: true
]

{ #category : #tests }
ViennaReaderTest >> testTuple1 [
	self assert: (reader parse: 'mk_(1, 2)') equals: #(1 2)
]

{ #category : #tests }
ViennaReaderTest >> testTuple2 [
	self should: [reader parse: 'mk_()'] raise: Error
]

{ #category : #tests }
ViennaReaderTest >> testTuple3 [
	self should: [reader parse: 'mk_(1)'] raise: Error
]

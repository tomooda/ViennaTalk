Class {
	#name : #ViennaWriterTest,
	#superclass : #TestCase,
	#instVars : [
		'writer'
	],
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #running }
ViennaWriterTest >> setUp [
	writer := ViennaWriter new
]

{ #category : #tests }
ViennaWriterTest >> testChar1 [
	self assert: (writer stringify: $a) equals: '''a'''
]

{ #category : #tests }
ViennaWriterTest >> testChar2 [
	self assert: (writer stringify: (Character codePoint: 16r1234)) equals: '''\u1234'''
]

{ #category : #tests }
ViennaWriterTest >> testComposite1 [
	self assert: (writer stringify: (ViennaComposite constructorName: #foo)) equals: 'mk_foo()'
]

{ #category : #tests }
ViennaWriterTest >> testComposite2 [
	self assert: (writer stringify: (ViennaComposite constructorName: #foo with: 1)) equals: 'mk_foo(1)'
]

{ #category : #tests }
ViennaWriterTest >> testComposite3 [
	self assert: (writer stringify: (ViennaComposite constructorName: #foo with: 1 with: 2 with: 3)) equals: 'mk_foo(1,2,3)'
]

{ #category : #tests }
ViennaWriterTest >> testFalse [
	self assert: (writer stringify: false) equals: 'false'
]

{ #category : #tests }
ViennaWriterTest >> testMap1 [
	self assert: (writer stringify: Dictionary new) equals: '{|->}'
]

{ #category : #tests }
ViennaWriterTest >> testMap2 [
	self assert: (writer stringify: (Dictionary new at: 1 put: 2; yourself)) equals: '{1|->2}'
]

{ #category : #tests }
ViennaWriterTest >> testMap3 [
	self
		assert:
			(ViennaReader new
				parse:
					(writer
						stringify:
							{(1 -> 2).
							(3 -> 4)} asDictionary))
		equals: {1 -> 2. 3 -> 4} asDictionary 
]

{ #category : #tests }
ViennaWriterTest >> testNil [
	self assert: (writer stringify: nil) equals: 'nil'
]

{ #category : #tests }
ViennaWriterTest >> testNumber1 [
	self assert: (writer stringify: 1) equals: '1'
]

{ #category : #tests }
ViennaWriterTest >> testNumber2 [
	self assert: (writer stringify: -3.14) equals: '-3.14'
]

{ #category : #tests }
ViennaWriterTest >> testNumber3 [
	self assert: (writer stringify: 1.0e8) equals: '1.0e8'
]

{ #category : #tests }
ViennaWriterTest >> testQuote1 [
	self assert: (writer stringify: #quote) equals: '<quote>'
]

{ #category : #tests }
ViennaWriterTest >> testQuote2 [
	self should: [writer stringify: #'quo!te'] raise: Error
]

{ #category : #tests }
ViennaWriterTest >> testSeq1 [
	self assert: (writer stringify: #() asOrderedCollection) equals: '[]'
]

{ #category : #tests }
ViennaWriterTest >> testSeq2 [
	self assert: (writer stringify: #(1) asOrderedCollection) equals: '[1]'
]

{ #category : #tests }
ViennaWriterTest >> testSeq3 [
	self assert: (writer stringify: #(1 2 3) asOrderedCollection) equals: '[1,2,3]'
]

{ #category : #tests }
ViennaWriterTest >> testSet1 [
	self assert: (writer stringify: #() asSet) equals: '{}'
]

{ #category : #tests }
ViennaWriterTest >> testSet2 [
	self assert: (writer stringify: #(1) asSet) equals: '{1}'
]

{ #category : #tests }
ViennaWriterTest >> testSet3 [
	self assert: (ViennaReader new parse: (writer stringify: #(1 2 3) asSet)) equals: #(1 2 3) asSet
]

{ #category : #tests }
ViennaWriterTest >> testString1 [
	self assert: (writer stringify: 'abc') equals: '"abc"'
]

{ #category : #tests }
ViennaWriterTest >> testString2 [
	self assert: (writer stringify: (String with: (Character codePoint: 16r1234))) equals: '"\u1234"'
]

{ #category : #tests }
ViennaWriterTest >> testTrue [
	self assert: (writer stringify: true) equals: 'true'
]

{ #category : #tests }
ViennaWriterTest >> testTuple1 [
	self should: [ writer stringify: #()] raise: Error
]

{ #category : #tests }
ViennaWriterTest >> testTuple2 [
	self should: [ writer stringify: #(1) ] raise: Error
]

{ #category : #tests }
ViennaWriterTest >> testTuple3 [
	self assert: (writer stringify: #(1 2 3)) equals: 'mk_(1,2,3)'
]

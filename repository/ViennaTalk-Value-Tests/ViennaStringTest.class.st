Class {
	#name : #ViennaStringTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Value-Tests'
}

{ #category : #tests }
ViennaStringTest >> testBoolean [
	self assert: true viennaString equals: 'true'.
	self assert: false viennaString equals: 'false'
]

{ #category : #tests }
ViennaStringTest >> testCharacter [
	self assert: $a viennaString equals: '''a'''.
	self assert: Character lf viennaString equals: '''\n'''
]

{ #category : #tests }
ViennaStringTest >> testComposite [
	self assert: (ViennaComposite constructorName: 'T') viennaString equals: 'mk_T()'.
	self assert: (ViennaComposite constructorName: 'T' with: 1) viennaString equals: 'mk_T(1)'.
	self
		assert: (ViennaComposite constructorName: 'T' with: 1 with: 2) viennaString
		equals: 'mk_T(1, 2)'
]

{ #category : #tests }
ViennaStringTest >> testInt [
	self assert: 1 viennaString equals: '1'.
	self assert: -1 viennaString equals: '-1'
]

{ #category : #tests }
ViennaStringTest >> testNil [
	self assert: nil viennaString equals: 'nil'
]

{ #category : #tests }
ViennaStringTest >> testQuote [
	self assert: #abc viennaString equals: '<abc>'

]

{ #category : #tests }
ViennaStringTest >> testReal [
	self assert: 1.0 viennaString equals: '1.0'.
	self assert: -1.0 viennaString equals: '-1.0'.
	self assert: -1.0e-16 viennaString equals: '-1.0e-16'
]

{ #category : #tests }
ViennaStringTest >> testString [
	self assert: 'abc' viennaString equals: '"abc"'.
	self assert: ('abc', String lf, 'xyz') viennaString equals: '"abc\nxyz"'.
	self assert: ('abc', String cr, 'xyz') viennaString equals: '"abc\rxyz"'
]

{ #category : #tests }
ViennaStringTest >> testTuple [
	self assert: #(1 2 3) viennaString equals: 'mk_(1, 2, 3)'
]

Class {
	#name : #ViennaTokenTypeTest,
	#superclass : #TestCase,
	#instVars : [
		'token'
	],
	#category : #'ViennaTalk-Type-Tests'
}

{ #category : #running }
ViennaTokenTypeTest >> setUp [

	super setUp.
	token := ViennaTokenType current
]

{ #category : #tests }
ViennaTokenTypeTest >> testDo [
	self should: [ token do: [ :i |  ] ] raise: ShouldNotImplement
]

{ #category : #tests }
ViennaTokenTypeTest >> testIncludes [
	self deny: (token includes: 1.23).
	self assert: (token includes: (ViennaToken with: 1.23))
]

{ #category : #tests }
ViennaTokenTypeTest >> testIsCompatibleWith [

	self assert: (ViennaType token isCompatibleWith: ViennaType token).
	self deny: (ViennaType token isCompatibleWith: ViennaType char)
]

{ #category : #tests }
ViennaTokenTypeTest >> testIsEnumerable [
	self deny: token isEnumerable
]

{ #category : #tests }
ViennaTokenTypeTest >> testName [
	self assert: token name equals: 'token'
]

{ #category : #tests }
ViennaTokenTypeTest >> testPlus [

	| nat |
	nat := ViennaType nat.
	self assert: token + token equals: token.
	self assert: token + nat equals: token | nat.
	self assert: nat + token equals: nat | token
]

{ #category : #tests }
ViennaTokenTypeTest >> testRemoveTypeHolders [
	self assert: ViennaType token asTypeHolder removeTypeHolders equals: ViennaType token
]

{ #category : #tests }
ViennaTokenTypeTest >> testSubtype [
	self assert: token <= token
]

{ #category : #tests }
ViennaTokenTypeTest >> testValue [
	| content |
	content := 'abc'.
	(token value: content)
		in: [ :t | 
			self assert: t equals: (ViennaToken with: content).
			self assert: t value equals: content ].
	self assert: (token applyTo: (Array with: content)) equals: (ViennaToken with: content).
	self should: [ token applyTo: Array new ] raise: Error.
	self should: [ token applyTo: (Array with: content with: content) ] raise: Error
]

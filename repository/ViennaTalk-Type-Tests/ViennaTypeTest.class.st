Class {
	#name : #ViennaTypeTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Type-Tests'
}

{ #category : #tests }
ViennaTypeTest >> testAsTypeHolder [
	self assert: ViennaType nat asTypeHolder type equals: ViennaType nat
]

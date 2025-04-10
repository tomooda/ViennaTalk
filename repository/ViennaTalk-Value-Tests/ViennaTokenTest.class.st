Class {
	#name : 'ViennaTokenTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-Value-Tests',
	#package : 'ViennaTalk-Value-Tests'
}

{ #category : 'tests' }
ViennaTokenTest >> testEqual [
	self assert: (ViennaToken with: 1) equals: (ViennaToken with: 1).
	self deny: (ViennaToken with: 1) = (ViennaToken with: 0)
]

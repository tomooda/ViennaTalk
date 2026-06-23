Class {
	#name : 'ViennaAssertionViolation',
	#superclass : 'ViennaError',
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'accessing' }
ViennaAssertionViolation >> expression [

	^ self subclassResponsibility
]

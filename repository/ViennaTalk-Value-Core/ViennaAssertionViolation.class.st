Class {
	#name : 'ViennaAssertionViolation',
	#superclass : 'Error',
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'accessing' }
ViennaAssertionViolation >> expression [

	^ self subclassResponsibility
]

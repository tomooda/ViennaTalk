Class {
	#name : 'ViennaStateInvariantViolation',
	#superclass : 'ViennaAssertionViolation',
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'accessing' }
ViennaStateInvariantViolation >> expression [

	^ #state
]

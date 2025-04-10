Class {
	#name : 'ViennaRuntimeTypeError',
	#superclass : 'ViennaAssertionViolation',
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'accessing' }
ViennaRuntimeTypeError >> expression [

	^ #type
]

{ #category : 'private - testing' }
ViennaRuntimeTypeError >> isResumable [
	"Determine whether an exception is resumable."

	^ true
]

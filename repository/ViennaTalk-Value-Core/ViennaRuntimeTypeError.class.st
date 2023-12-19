Class {
	#name : #ViennaRuntimeTypeError,
	#superclass : #Error,
	#category : #'ViennaTalk-Value-Core'
}

{ #category : #'private - testing' }
ViennaRuntimeTypeError >> isResumable [
	"Determine whether an exception is resumable."

	^ true
]

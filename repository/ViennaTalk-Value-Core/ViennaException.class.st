Class {
	#name : 'ViennaException',
	#superclass : 'Exception',
	#instVars : [
		'expression'
	],
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'signaling' }
ViennaException class >> expression: anObject [
	^ self new
		expression: anObject;
		signal
]

{ #category : 'controlling' }
ViennaException class >> tixe: anArrayOfAssociations in: aBlock [
	| theBlock |
	theBlock := aBlock.
	^ [ theBlock value ]
		on: self
		do: [ :ex | 
			anArrayOfAssociations
				do: [ :assoc | 
					(assoc key value: ex expression)
						ifNotEmpty: [ :binding | 
							theBlock := [ assoc value value: binding first ].
							ex retry ] ].
			ex pass ]
]

{ #category : 'controlling' }
ViennaException class >> trap: matcherBlock with: handlerBlock in: aBlock [
	^ aBlock
		on: self
		do: [ :ex | 
			(matcherBlock value: ex expression)
				ifNotNil: [ :bindings | handlerBlock value: bindings ]
				ifNil: [ ex pass ] ]
]

{ #category : 'accessing' }
ViennaException >> defaultAction [
	^ UnhandledError signalForException: self
]

{ #category : 'accessing' }
ViennaException >> expression [
	^ expression
]

{ #category : 'accessing' }
ViennaException >> expression: anObject [
	expression := anObject.
	self messageText: expression viennaString
]

Extension { #name : 'Context' }

{ #category : '*ViennaTalk-ExecutionTrace-Core' }
Context >> viennaReturnValue [

	| context |
	context := self sender.
	[ context notNil ] whileTrue: [
			context selector = #resume:through: ifTrue: [
				^ context arguments first ].
			context := context sender ].
	^ self home receiver
]

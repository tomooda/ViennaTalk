Extension { #name : 'Context' }

{ #category : '*ViennaTalk-Transpiler-ExecutionTrace' }
Context >> viennaReturnValue [

	| context |
	context := self sender.
	[ context notNil ] whileTrue: [
			context selector = #resume:through: ifTrue: [
				^ context arguments first ].
			context := context sender ].
	^ self home receiver
]

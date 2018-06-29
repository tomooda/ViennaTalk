Extension { #name : #Object }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> inv [
	
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> stateInvariantViolation [
	^ ViennaStateInvariantViolation signal
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> viennaAtomic: aBlock [
	aBlock
		on: ViennaStateInvariantViolation
		do: [ :ex | ex resume ].
	self inv
]

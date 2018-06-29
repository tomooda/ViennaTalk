Extension { #name : #Object }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> inv [
	
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> isViennaTracingString [
	^ false
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

{ #category : #'*ViennaTalk-Parser-Code Generators' }
Object >> writeToSlot: aSlot of: anObject [
	^anObject writeSlot: aSlot value: self
]

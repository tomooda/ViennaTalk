Extension { #name : #Object }

{ #category : #'*ViennaTalk-Transpiler-Runtime' }
Object >> inv [
	
]

{ #category : #'*ViennaTalk-Transpiler-Runtime' }
Object >> stateInvariantViolation [
	^ ViennaStateInvariantViolation signal
]

{ #category : #'*ViennaTalk-Transpiler-Runtime' }
Object >> viennaAtomic: aBlock [
	aBlock
		on: ViennaStateInvariantViolation
		do: [ :ex | ex resume ].
	self inv
]

{ #category : #'*ViennaTalk-Transpiler-Runtime' }
Object >> writeToSlot: aSlot of: anObject [
	^anObject writeSlot: aSlot value: self
]

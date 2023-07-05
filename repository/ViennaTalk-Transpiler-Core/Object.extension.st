Extension { #name : #Object }

{ #category : #'*ViennaTalk-Transpiler-Core' }
Object >> inv [

	^ self typeDefinition inv
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
Object >> isViennaTracingString [
	^ false
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
Object >> stateInvariantViolation [
	^ ViennaStateInvariantViolation signal
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
Object >> viennaAtomic: aBlock [
	aBlock
		on: ViennaStateInvariantViolation
		do: [ :ex | ex resume ].
	self inv
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
Object >> writeToSlot: aSlot of: anObject [
	^anObject writeSlot: aSlot value: self
]

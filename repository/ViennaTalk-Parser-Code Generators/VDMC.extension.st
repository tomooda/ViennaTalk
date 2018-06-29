Extension { #name : #VDMC }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
VDMC >> asTranspiledAnimation [
	| animation |
	animation := ViennaTranspiledAnimation new.
	animation specification: specification ifError: [ :msg | self error: msg ].
	self state
		keysAndValuesDo: [ :globalName :value | animation plainAt: globalName put: value ].
	^ animation
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
VDMC >> becomeTranspiledAnimation [
	| animation |
	animation := self asTranspiledAnimation.
	self dependents do: [ :dependent | animation addDependent: dependent ].
	self become: animation
]

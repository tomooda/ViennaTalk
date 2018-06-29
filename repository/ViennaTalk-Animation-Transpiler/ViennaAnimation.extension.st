Extension { #name : #ViennaAnimation }

{ #category : #'*ViennaTalk-Animation-Transpiler' }
ViennaAnimation >> asTranspiledAnimation [
	| animation |
	animation := ViennaTranspiledAnimation new.
	animation specification: specification ifError: [ :msg | self error: msg ].
	self state
		keysAndValuesDo: [ :globalName :value | animation plainAt: globalName put: value ].
	^ animation
]

{ #category : #'*ViennaTalk-Animation-Transpiler' }
ViennaAnimation >> becomeTranspiledAnimation [
	| animation |
	animation := self asTranspiledAnimation.
	self dependents do: [ :dependent | animation addDependent: dependent ].
	self become: animation
]

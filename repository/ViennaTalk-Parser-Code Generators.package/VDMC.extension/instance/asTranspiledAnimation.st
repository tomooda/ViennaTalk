*ViennaTalk-Parser-Code Generators
asTranspiledAnimation
	| animation |
	animation := ViennaTranspiledAnimation new.
	animation specification: specification ifError: [ :msg | self error: msg ].
	self state
		keysAndValuesDo: [ :globalName :value | animation plainAt: globalName put: value ].
	^ animation
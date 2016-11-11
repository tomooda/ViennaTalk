*ViennaTalk-Parser-Code Generators
becomeTranspiledAnimation
	| animation |
	animation := self asTranspiledAnimation.
	self dependents do: [ :dependent | animation addDependent: dependent ].
	self become: animation
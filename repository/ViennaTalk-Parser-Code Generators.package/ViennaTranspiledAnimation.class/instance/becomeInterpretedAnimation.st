private
becomeInterpretedAnimation
	| animation |
	animation := self asInterpretedAnimation.
	self dependents do: [ :dependent |  animation addDependent: dependent].
	self become: animation
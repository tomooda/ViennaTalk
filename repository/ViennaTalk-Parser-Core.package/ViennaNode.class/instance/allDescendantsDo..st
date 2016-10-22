enumerating
allDescendantsDo: aBlock
	aBlock value: self.
	self do: [ :node | node allDescendantsDo: aBlock ]
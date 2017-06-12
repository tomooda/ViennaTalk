enumerating
detect: aBlock
	self do: [ :node | (aBlock value: node) ifTrue: [ ^node ] ].
	^ NotFound signalFor: self
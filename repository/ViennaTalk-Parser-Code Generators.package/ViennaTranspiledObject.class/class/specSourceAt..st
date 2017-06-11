specification
specSourceAt: aSelector
	^ self specSourceFor: (self nodeDict at: aSelector asSymbol ifAbsent: [ ^ String new ])
Extension { #name : 'ViennaAnimation' }

{ #category : '*ViennaTalk-Engine-Networking' }
ViennaAnimation class >> url: aStringOrUrl [
	^ self new
		engine: (ViennaClient on: aStringOrUrl);
		yourself
]

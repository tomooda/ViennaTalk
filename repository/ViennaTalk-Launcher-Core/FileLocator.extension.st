Extension { #name : #FileLocator }

{ #category : #'*ViennaTalk-Launcher-Core' }
FileLocator class >> viennaTalkDirectory [
	^ (self localDirectory / 'ViennaTalk') ensureCreateDirectory
]

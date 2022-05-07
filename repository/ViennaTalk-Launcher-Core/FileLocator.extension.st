Extension { #name : #FileLocator }

{ #category : #'*ViennaTalk-Launcher-Core' }
FileLocator class >> viennaTalkDirectory [
	^ (self localDirectory / 'ViennaTalk') ensureCreateDirectory
]

{ #category : #'*ViennaTalk-Launcher-Core' }
FileLocator class >> viennaTalkDocumentDirectory [

	^ (self documents / 'ViennaTalk') ensureCreateDirectory
]

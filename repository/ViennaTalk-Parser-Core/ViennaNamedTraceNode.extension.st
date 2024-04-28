Extension { #name : #ViennaNamedTraceNode }

{ #category : #'*ViennaTalk-Parser-Core' }
ViennaNamedTraceNode >> parser [

	^ ViennaVDMParser new namedTrace end
]

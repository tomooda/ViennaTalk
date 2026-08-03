Extension { #name : 'AppGeneratorSupport' }

{ #category : '*ViennaTalk-Application' }
AppGeneratorSupport class >> isEmbedded [

	^ Smalltalk arguments includes: '--embedded'
]

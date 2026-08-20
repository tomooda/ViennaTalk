Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaEvalScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

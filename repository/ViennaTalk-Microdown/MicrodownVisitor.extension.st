Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaEvalBlockScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

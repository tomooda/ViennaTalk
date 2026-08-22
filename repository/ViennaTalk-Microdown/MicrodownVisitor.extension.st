Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaEval: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

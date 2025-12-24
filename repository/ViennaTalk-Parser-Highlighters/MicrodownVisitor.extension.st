Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Parser-Highlighters' }
MicrodownVisitor >> visitViennaTalkScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

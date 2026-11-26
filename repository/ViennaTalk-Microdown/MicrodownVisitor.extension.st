Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaEval: aMicViennaEvalBlock [

	^ self visitScript: aMicViennaEvalBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaExec: aMicViennaEvalBlock [

	^ self visitScript: aMicViennaEvalBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaSource: aMicViennaSourceBlock [

	^ self visitScript: aMicViennaSourceBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaTalkScript: aSlide [

	^ aSlide children collect: [ :each | self visit: each ]
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaWatch: aMicViennaWatchBlock [

	^ self visitScript: aMicViennaWatchBlock
]

Extension { #name : 'MicrodownVisitor' }

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaEval: aMicViennaEvalBlock [

	^ self visitCode: aMicViennaEvalBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaExec: aMicViennaEvalBlock [

	^ self visitCode: aMicViennaEvalBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaSource: aMicViennaSourceBlock [

	^ self visitCode: aMicViennaSourceBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaTalkScript: aMicViennaTalkScriptBlock [

	^ self visitCode: aMicViennaTalkScriptBlock
]

{ #category : '*ViennaTalk-Microdown' }
MicrodownVisitor >> visitViennaWatch: aMicViennaWatchBlock [

	^ self visitCode: aMicViennaWatchBlock
]

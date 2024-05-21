Class {
	#name : 'ViennaErrorStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaErrorStatementNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter keyword: 'error'
]

{ #category : 'private' }
ViennaErrorStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'testing' }
ViennaErrorStatementNode >> isViennaErrorNode [

	^ true
]

{ #category : 'testing' }
ViennaErrorStatementNode >> isViennaErrorStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaErrorStatementNode >> label [

	^ 'ErrorStatement'
]

{ #category : 'typechecking' }
ViennaErrorStatementNode >> maximalType [

	^ ViennaType unit
]

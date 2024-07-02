Class {
	#name : 'ViennaInline',
	#superclass : 'ViennaRefactoring',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaInline class >> isAbstract [ 
	^ self == ViennaInline
]

{ #category : 'accessing' }
ViennaInline >> name [
	^ 'Inline ' , (self shortDescription: ast source) asText allBold
]

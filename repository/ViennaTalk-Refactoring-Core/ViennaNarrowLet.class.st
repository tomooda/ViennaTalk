Class {
	#name : 'ViennaNarrowLet',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'definitionNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaNarrowLet class >> isAbstract [
	^ self = ViennaNarrowLet
]

{ #category : 'testing' }
ViennaNarrowLet >> acceptsNode: aString [
	^ self subclassResponsibility
]

{ #category : 'operations' }
ViennaNarrowLet >> check [

	ast ifNil: [ ^ false ].
	(self acceptsNode: ast) ifFalse: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	^ true
]

{ #category : 'accessing' }
ViennaNarrowLet >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : 'accessing' }
ViennaNarrowLet >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : 'accessing' }
ViennaNarrowLet >> findDefinitionNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaNarrowLet >> name [
	^ 'Narrow ' , (self shortDescription: ast source) asText allBold
]

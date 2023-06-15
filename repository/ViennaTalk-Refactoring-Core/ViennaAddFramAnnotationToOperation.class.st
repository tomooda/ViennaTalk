Class {
	#name : #ViennaAddFramAnnotationToOperation,
	#superclass : #ViennaAdd,
	#instVars : [
		'newAspect'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #execution }
ViennaAddFramAnnotationToOperation >> execute [

	(self containerNode ifNil: [ ^ self ]) addAnnotation:
		(self newAst ifNil: [ ^ nil ])
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> findContainerNode [

	ast ifNil: [ ^ nil ].
	ast isViennaExplicitOperationDefinitionNode ifTrue: [
		ast := ast parent ].
	ast label = 'ImplicitOperationDefinition' ifTrue: [
		ast := ast parent ].
	ast label = 'OperationDefinition' ifTrue: [ ast := ast parent ].
	ast isViennaAccessOperationDefinitionNode ifFalse: [ ^ nil ].
	ast annotations ifNil: [ ^ nil ].
	ast annotations ifEmpty: [ ^ nil ].
	^ ast
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> findNewAspect [

	| aspects |
	aspects := #( Function Input Output Control Time Precondition
	              Resource ).
	^ (UIManager default chooseFrom: aspects message: 'Select an aspect') 
		  ifNotNil: [ :index | aspects at: index ifAbsent: [ nil ] ]
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> findNewName [

	^ newAspect ifNotNil: [ 
		  UIManager default request: self newNameQuery initialAnswer: '' ]
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> name [

	^ 'Add FRAM annotation to ', ast name
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> newAspect [

	^ newAspect ifNil: [ newAspect := self findNewAspect ]
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> newAst [

	^ (self newAspect notNil and: [ self newName notNil ])
		  ifTrue: [ 'FRAM ', (self newAspect ifNil: [ '' ]) , ' ' , self newName ]
		  ifFalse: [ nil ]
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> newNameQuery [

	^ 'new ' , (newAspect ifNil: [ '' ]) , ' name'
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> parser [

	^ nil
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> sortingOrder [
	^ 10.0
]

{ #category : #accessing }
ViennaAddFramAnnotationToOperation >> sourceWithNewName: aString [

	^ '--@FRAM ' , (self newAspect ifNil: [ '' ]) , aString
]

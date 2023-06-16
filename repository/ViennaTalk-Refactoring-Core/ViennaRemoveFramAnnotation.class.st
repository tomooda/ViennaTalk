Class {
	#name : #ViennaRemoveFramAnnotation,
	#superclass : #ViennaRemove,
	#instVars : [
		'annotation'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaRemoveFramAnnotation >> annotation [

	^ annotation ifNil: [ annotation := self findAnnotation ]
]

{ #category : #operations }
ViennaRemoveFramAnnotation >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRemoveFramAnnotation >> execute [

	^ self definitionNode removeAnnotation: self annotation
]

{ #category : #accessing }
ViennaRemoveFramAnnotation >> findAnnotation [

	^ self definitionNode ifNotNil: [ :node | 
		  (UIManager default
			   chooseFrom: (node annotations ifNil: [ {  } ])
			   message: 'Select an annotation to remove.') ifNotNil: [ :index | 
			  index >= 1
				  ifTrue: [ node annotations at: index ]
				  ifFalse: [ nil ] ] ]
]

{ #category : #accessing }
ViennaRemoveFramAnnotation >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaExplicitOperationDefinitionNode ifTrue: [
		ast := ast parent ].
	ast isViennaImplicitOperationDefinitionNode ifTrue: [
		ast := ast parent ].
	ast isViennaOperationDefinitionNode ifTrue: [ ast := ast parent ].
	ast isViennaAccessOperationDefinitionNode ifFalse: [ ^ nil ].
	ast annotations ifNil: [ ^ nil ].
	ast annotations ifEmpty: [ ^ nil ].
	^ ast
]

{ #category : #accessing }
ViennaRemoveFramAnnotation >> name [
	^ 'Remove FRAM annotation from ', ast name
]

{ #category : #accessing }
ViennaRemoveFramAnnotation >> sortingOrder [
	^ 10.1
]

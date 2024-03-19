Class {
	#name : #ViennaAddTestOperation,
	#superclass : #ViennaAddExplicitOperation,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaAddTestOperation >> check [

	^ self containerNode notNil and: [
		  (self containerNode resolveIdentifier: self newName) isNil ]
]

{ #category : #accessing }
ViennaAddTestOperation >> ensureContainerSection [

	self containerNode ifNotNil: [ :testModule |
		testModule sectionsDo: [ :section |
			section isViennaOperationDefinitionsNode ifTrue: [ ^ section ] ].
		^ testModule moduleBody add: ViennaOperationDefinitionsNode empty ].
	^ nil
]

{ #category : #accessing }
ViennaAddTestOperation >> execute [

	^ self ensureContainerSection add: self newAst
]

{ #category : #accessing }
ViennaAddTestOperation >> findContainerNode [

	^ ((ast ifNotNil: #module) ifNotNil: #identifier) ifNotNil: [
		  :identifier | ast moduleNamed: identifier , 'Test' ]
]

{ #category : #accessing }
ViennaAddTestOperation >> name [
	^ 'Add a test operation'
]

{ #category : #accessing }
ViennaAddTestOperation >> newName [

	(ast notNil and: [
		 ast isViennaFunctionDefinitionNode or: [
			 ast isViennaOperationDefinitionNode ] ]) ifFalse: [ ^ nil ].
	^ 'test' , ast identifier capitalized
]

{ #category : #accessing }
ViennaAddTestOperation >> sourceWithNewName: aString [

	^ aString , ' : () ==> () ' , aString , '() == skip'
]

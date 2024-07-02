Class {
	#name : 'ViennaAdd',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'newName',
		'containerNode'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaAdd class >> isAbstract [
	^ self == ViennaAdd
]

{ #category : 'operations' }
ViennaAdd >> check [

	^ ast notNil and: [ self containerNode notNil ]
]

{ #category : 'accessing' }
ViennaAdd >> containerNode [

	^ containerNode ifNil: [ containerNode := self findContainerNode ]
]

{ #category : 'operations' }
ViennaAdd >> execute [

	^ self containerNode ifNotNil: [ :container |
		  self newAst ifNotNil: [ :n | container add: n ] ]
]

{ #category : 'accessing' }
ViennaAdd >> findContainerNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaAdd >> findNewName [

	(UIManager default request: self newNameQuery initialAnswer: '')
		ifNotNil: [ :ans |
			ans trim ifNotEmpty: [ :name |
				(ViennaVDMParser current identifier end parse: name)
					isPetit2Failure ifFalse: [ ^ name ] ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaAdd >> newAst [

	| newAst |
	newAst := self parser parse:
		          (self sourceWithNewName: (self newName ifNil: [ ^ nil ])).
	^ newAst isPetit2Failure
		  ifTrue: [ nil ]
		  ifFalse: [ newAst ]
]

{ #category : 'accessing' }
ViennaAdd >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : 'accessing' }
ViennaAdd >> newName: aString [
	newName := aString
]

{ #category : 'accessing' }
ViennaAdd >> newNameQuery [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaAdd >> parser [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaAdd >> sourceWithNewName: aString [

	^ self subclassResponsibility
]

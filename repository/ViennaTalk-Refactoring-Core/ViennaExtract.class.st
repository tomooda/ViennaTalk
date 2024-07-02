Class {
	#name : 'ViennaExtract',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'newName'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaExtract class >> isAbstract [
	^ self == ViennaExtract
]

{ #category : 'accessing' }
ViennaExtract >> findNewName [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaExtract >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : 'accessing' }
ViennaExtract >> newName: aString [
	newName := aString
]

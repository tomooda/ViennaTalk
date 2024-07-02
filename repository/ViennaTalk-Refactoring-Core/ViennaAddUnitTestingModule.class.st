Class {
	#name : 'ViennaAddUnitTestingModule',
	#superclass : 'ViennaAddModule',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddUnitTestingModule >> findContainerNode [

	^ super findContainerNode ifNotNil: [ :document | 
		  (document moduleNamed: self newName)
			  ifNotNil: [ nil ]
			  ifNil: [ document ] ]
]

{ #category : 'accessing' }
ViennaAddUnitTestingModule >> findNewName [

	^ 'UnitTesting'
]

{ #category : 'accessing' }
ViennaAddUnitTestingModule >> name [
	^ 'Add UnitTesting module'
]

{ #category : 'accessing' }
ViennaAddUnitTestingModule >> sortingOrder [
	^ 0.01
]

{ #category : 'accessing' }
ViennaAddUnitTestingModule >> sourceWithNewName: aString [

	^ ViennaModuleNode unitTestingSource
]

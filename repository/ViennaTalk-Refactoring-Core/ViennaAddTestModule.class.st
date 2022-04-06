Class {
	#name : #ViennaAddTestModule,
	#superclass : #ViennaAddModule,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaAddTestModule >> findContainerNode [

	ast ifNil: [ ^ nil ].
	(ast label = 'Module' and: [ 
		 (ast document moduleNamed: self newName) isNil and: [ 
			 (ast document moduleNamed: 'UnitTesting') notNil ] ]) ifTrue: [ 
		^ ast document ].
	^ nil
]

{ #category : #accessing }
ViennaAddTestModule >> findNewName [

	^ ast name ifNotNil: [ :name | name , 'Test' ]
]

{ #category : #accessing }
ViennaAddTestModule >> name [
	^ 'Add test module for ', ast name
]

{ #category : #accessing }
ViennaAddTestModule >> sourceWithNewName: aString [

	^ 'module ' , aString , ' imports from UnitTesting operations assert : bool * seq of char ==> () renamed assert; assertEquals  : ? * ? * seq of char ==> () renamed assertEquals; assertApproxEquals : real * real * real * seq of char ==> () renamed assertApproxEquals exports all definitions end ' , aString
]
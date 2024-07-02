Class {
	#name : 'ViennaAddTestModule',
	#superclass : 'ViennaAddModule',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaAddTestModule >> findContainerNode [

	ast ifNil: [ ^ nil ].
	(ast isViennaModuleNode and: [
		 (ast document moduleNamed: self newName) isNil and: [
			 (ast document moduleNamed: 'UnitTesting') notNil ] ]) ifTrue: [
		^ ast document ].
	^ nil
]

{ #category : 'accessing' }
ViennaAddTestModule >> findNewName [

	^ ast identifier ifNotNil: [ :name | name , 'Test' ]
]

{ #category : 'accessing' }
ViennaAddTestModule >> name [
	^ 'Add test module for ', ast identifier
]

{ #category : 'accessing' }
ViennaAddTestModule >> sourceWithNewName: aString [

	^ 'module ' , aString , ' imports from ', ast identifier, ' all, from UnitTesting operations assert : bool * seq of char ==> () renamed assert; assertEquals  : ? * ? * seq of char ==> () renamed assertEquals; assertApproxEquals : real * real * real * seq of char ==> () renamed assertApproxEquals exports all definitions operations end ' , aString
]

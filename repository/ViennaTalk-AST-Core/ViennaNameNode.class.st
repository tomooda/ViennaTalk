Class {
	#name : 'ViennaNameNode',
	#superclass : 'ViennaStateDesignatorNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaNameNode class >> isAbstract [

	^ self = ViennaNameNode
]

{ #category : 'converting' }
ViennaNameNode >> asGlobalName [

	^ self subclassResponsibility
]

{ #category : 'accessing-definitions' }
ViennaNameNode >> definition [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaNameNode >> designatesStateVariable [

	^ self resolve
		  ifNotNil: [ :def | def isViennaFieldNode ]
		  ifNil: [ false ]
]

{ #category : 'testing' }
ViennaNameNode >> isFunctionNameNode [

	^ (self identifier beginsWith: 'pre_') or: [
		  (self identifier beginsWith: 'post_') or: [
			  (self identifier beginsWith: 'inv_') or: [
				  self resolve
					  ifNotNil: [ :def | def isFunctionDefinition ]
					  ifNil: [ false ] ] ] ]
]

{ #category : 'testing' }
ViennaNameNode >> isOperationNameNode [

	^ self resolve
		  ifNotNil: [ :def | def isOperationDefinition ]
		  ifNil: [ false ]
]

{ #category : 'testing' }
ViennaNameNode >> isReadAccess [

	^ self isWriteAccess not
]

{ #category : 'testing' }
ViennaNameNode >> isViennaNameNode [

	^ true
]

{ #category : 'testing' }
ViennaNameNode >> isWriteAccess [

	^ self hasParentSuchThat: [ :node |
		  node parent notNil and: [ node parent isViennaAssignStatementNode and: [ node parent stateDesignator == node ] ] ]
]

{ #category : 'typechecking' }
ViennaNameNode >> maximalType [

	^ self definition ifNotNil: #typecheck ifNil: [
		  ViennaTypeError
			  on: self
			  signal: 'Unresolved local name: ' , self source ]
]

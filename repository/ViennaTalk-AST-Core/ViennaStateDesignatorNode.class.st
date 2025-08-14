Class {
	#name : 'ViennaStateDesignatorNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaStateDesignatorNode class >> isAbstract [

	^ self = ViennaStateDesignatorNode
]

{ #category : 'accessing' }
ViennaStateDesignatorNode >> identifier [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaStateDesignatorNode >> isAssignable [

	^ self subclassResponsibility
]

{ #category : 'testing' }
ViennaStateDesignatorNode >> isAssignee [

	^ self isAssignable and: [
		  (self parent isViennaAssignStatementNode and: [
			   self parent stateDesignator == self ]) or: [
			  self parent isViennaStateDesignatorNode and: [
				  parent isAssignee and: [ self parent stateDesignator == self ] ] ] ]
]

{ #category : 'testing' }
ViennaStateDesignatorNode >> isViennaStateDesignatorNode [

	^ true
]

{ #category : 'accessing-definitions' }
ViennaStateDesignatorNode >> localResolve [

	^ self subclassResponsibility
]

{ #category : 'accessing-definitions' }
ViennaStateDesignatorNode >> resolve [

	^ self subclassResponsibility
]

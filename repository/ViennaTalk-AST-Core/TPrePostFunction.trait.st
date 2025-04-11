Trait {
	#name : 'TPrePostFunction',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
TPrePostFunction >> post [

	^ self postFunction ifNotNil: #body
]

{ #category : 'accessing' }
TPrePostFunction >> post: aViennaExpressionNode [

	self postFunction
		ifNotNil: [ :postFunction |
		postFunction body: aViennaExpressionNode ]
		ifNil: [
			self postFunction:
				(aViennaExpressionNode ifNotNil: #asViennaPrePostFunctionNode) ]
]

{ #category : 'accessing' }
TPrePostFunction >> postFunction [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
TPrePostFunction >> postFunction: aViennaPrePostFunctionDefinitionNode [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
TPrePostFunction >> pre [

	^ self preFunction ifNotNil: #body
]

{ #category : 'accessing' }
TPrePostFunction >> pre: aViennaExpressionNode [

	self preFunction
		ifNotNil: [ :preFunction | preFunction body: aViennaExpressionNode ]
		ifNil: [
			self preFunction:
				(aViennaExpressionNode ifNotNil: #asViennaPrePostFunctionNode) ]
]

{ #category : 'accessing' }
TPrePostFunction >> preFunction [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
TPrePostFunction >> preFunction: aViennaPrePostFunctionDefinitionNode [

	^ self subclassResponsibility
]

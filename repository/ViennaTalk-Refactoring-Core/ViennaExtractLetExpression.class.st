Class {
	#name : #ViennaExtractLetExpression,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractLetExpression >> check [

	^ ast isViennaExpressionNode and: [
		  ast isViennaLetExpressionNode not and: [
			  ast isOperationNameNode not ] ]
]

{ #category : #operations }
ViennaExtractLetExpression >> execute [

	self newName ifNil: [ ^ nil ].
	^ self replaceNode: ast with: (ViennaLetExpressionNode
			   localDefinitionList: (ViennaNode
					    label: 'LocalDefinitionList'
					    with: (ViennaNode label: 'LocalDefinition' with: (ViennaNode
								      label: 'ValueDefinition'
								      with:
								      (ViennaNode
									       label: 'PatternIdentifier'
									       with: self newName)
								      with: nil
								      with: ast copyFragment)))
			   expression: (ViennaLocalNameNode identifier: self newName))
]

{ #category : #accessing }
ViennaExtractLetExpression >> findNewName [
	(UIManager default
		request: 'local name for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractLetExpression >> name [

	^ 'Extract let expression with ' asText
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' = ' ])
	  , (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractLetExpression >> sortingOrder [
	^ 2.52
]

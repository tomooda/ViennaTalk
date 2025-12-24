Class {
	#name : 'ViennaAddOneMutationTest',
	#superclass : 'ViennaMutationTest',
	#category : 'ViennaTalk-Mutation-Tests',
	#package : 'ViennaTalk-Mutation-Tests'
}

{ #category : 'utilities' }
ViennaAddOneMutationTest >> createMutation [

	^ ViennaAddOneMutation new
]

{ #category : 'tests' }
ViennaAddOneMutationTest >> testCanMutate [

	| body |
	body := ((document moduleNamed: 'A') lookupIdentifier: 'f') body.
	self assert: (mutation canMutate: ('x' asViennaExpressionAst
				  parent: body;
				  typecheck;
				  yourself)).
	self assert: (mutation canMutate: '1' asViennaExpressionAst).
	self assert: (mutation canMutate: ('x+1' asViennaExpressionAst
				  parent: body;
				  typecheck;
				  yourself))
]

{ #category : 'tests' }
ViennaAddOneMutationTest >> testMutate [

	self
		assert: (mutation mutate: 'x' asViennaExpressionAst)
		equals: 'x+1' asViennaExpressionAst.
	self
		assert: (mutation mutate: '1' asViennaExpressionAst)
		equals: '1+1' asViennaExpressionAst.
	self
		assert: (mutation mutate: 'x+1' asViennaExpressionAst)
		equals: 'x+1+1' asViennaExpressionAst
]

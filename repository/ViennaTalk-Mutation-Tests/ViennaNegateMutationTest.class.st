Class {
	#name : 'ViennaNegateMutationTest',
	#superclass : 'ViennaMutationTest',
	#category : 'ViennaTalk-Mutation-Tests',
	#package : 'ViennaTalk-Mutation-Tests'
}

{ #category : 'utilities' }
ViennaNegateMutationTest >> createMutation [

	^ ViennaNegateMutation new
]

{ #category : 'tests' }
ViennaNegateMutationTest >> testCanMutate [

	| body |
	body := ((document moduleNamed: 'A') lookupIdentifier: 'f') body.
	self assert: (mutation canMutate: ('x > 0' asViennaExpressionAst
				  parent: body;
				  typecheck;
				  yourself)).
	self assert: (mutation canMutate: 'true' asViennaExpressionAst).
	self assert: (mutation canMutate: ('x > 0 and x < 10' asViennaExpressionAst
				  parent: body;
				  typecheck;
				  yourself))
]

{ #category : 'tests' }
ViennaNegateMutationTest >> testMutate [

	self
		assert: (mutation mutate: 'x > 0' asViennaExpressionAst)
		equals: 'not (x > 0)' asViennaExpressionAst.
	self
		assert: (mutation mutate: 'true' asViennaExpressionAst)
		equals: 'not true' asViennaExpressionAst.
	self
		assert: (mutation mutate: 'x > 0 and x < 10' asViennaExpressionAst)
		equals: 'not(x > 0 and x < 10)' asViennaExpressionAst
]

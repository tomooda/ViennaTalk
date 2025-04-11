Class {
	#name : 'ViennaAddOneMutation',
	#superclass : 'ViennaMutation',
	#category : 'ViennaTalk-Mutation-Core',
	#package : 'ViennaTalk-Mutation-Core'
}

{ #category : 'testing' }
ViennaAddOneMutation >> canMutate: aViennaNode [

	^ aViennaNode isViennaExpressionNode and: [
		  aViennaNode typecheck isRealType ]
]

{ #category : 'mutating' }
ViennaAddOneMutation >> mutate: aViennaNode [

	^ ViennaArithmeticPlusNode
		  expression: aViennaNode
		  expression: (ViennaSymbolicLiteralNode string: '1')
]

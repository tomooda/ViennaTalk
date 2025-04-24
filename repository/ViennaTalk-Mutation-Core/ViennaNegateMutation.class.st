Class {
	#name : 'ViennaNegateMutation',
	#superclass : 'ViennaMutation',
	#category : 'ViennaTalk-Mutation-Core',
	#package : 'ViennaTalk-Mutation-Core'
}

{ #category : 'testing' }
ViennaNegateMutation >> canMutate: aViennaNode [

	^ aViennaNode isViennaExpressionNode and: [
		  aViennaNode typecheck = ViennaType bool and: [
			  aViennaNode isAssignee not and: [
				  aViennaNode parent isNil or: [
					  aViennaNode parent isViennaInvariantInitialFunctionNode not
						  and: [
							  (aViennaNode hasParentSuchThat: [ :node |
								   node isViennaNamedTraceNode ]) not ] ] ] ] ]
]

{ #category : 'mutating' }
ViennaNegateMutation >> mutate: aViennaNode [

	^ ViennaNotNode expression: aViennaNode
]

{ #category : 'accessing' }
ViennaNegateMutation >> name [

	^ 'negate'
]

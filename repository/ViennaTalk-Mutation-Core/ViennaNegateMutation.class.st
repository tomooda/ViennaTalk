Class {
	#name : 'ViennaNegateMutation',
	#superclass : 'ViennaMutation',
	#category : 'ViennaTalk-Mutation-Core',
	#package : 'ViennaTalk-Mutation-Core'
}

{ #category : 'testing' }
ViennaNegateMutation >> canMutate: aViennaNode [

	^ aViennaNode isViennaExpressionNode and: [
		  aViennaNode typecheck = ViennaType bool ]
]

{ #category : 'mutating' }
ViennaNegateMutation >> mutate: aViennaNode [

	^ ViennaNotNode expression: aViennaNode
]

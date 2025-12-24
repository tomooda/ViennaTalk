Class {
	#name : 'ViennaMutationTest',
	#superclass : 'TestCase',
	#instVars : [
		'document',
		'mutation'
	],
	#category : 'ViennaTalk-Mutation-Tests',
	#package : 'ViennaTalk-Mutation-Tests'
}

{ #category : 'testing' }
ViennaMutationTest class >> isAbstract [

	^ self = ViennaMutationTest
]

{ #category : 'utilities' }
ViennaMutationTest >> createMutation [

	^ self subclassResponsibility
]

{ #category : 'running' }
ViennaMutationTest >> setUp [

	document := 'module A exports all definitions functions f : nat -> nat f(x) == if x < 10 then x + 1 else x end A'
		            asViennaDocumentAst
		            typecheck;
		            yourself.
	mutation := self createMutation
]

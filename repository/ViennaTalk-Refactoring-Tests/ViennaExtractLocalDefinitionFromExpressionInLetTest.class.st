Class {
	#name : #ViennaExtractLocalDefinitionFromExpressionInLetTest,
	#superclass : #ViennaRefactoringTest,
	#category : #'ViennaTalk-Refactoring-Tests'
}

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLetTest >> createSpec [

	^ '
module A
exports all
definitions
state S of
z : nat
init s == s = mk_S(0)
end
operations
	pure op : nat ==> nat
	op(x) == let a = x + 1 in z := (x - 1) * a + z;
end A' asViennaDocumentAst
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLetTest >> findFailureAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  statement expression expression1 expression2
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLetTest >> findSuccessAst [

	^ ((self spec moduleNamed: 'A') resolveIdentifier: 'op') statement
		  statement expression expression1 expression1
]

{ #category : #accessing }
ViennaExtractLocalDefinitionFromExpressionInLetTest >> resultingSpec [

	^ '
module A
exports all
definitions
state S of
	z : nat
init s == s = mk_S(0)
end

operations
	pure op : nat ==> nat
	op(x) == let a = x + 1, b = x - 1 in z := b * a + z;

end A' asViennaDocumentAst
]

{ #category : #running }
ViennaExtractLocalDefinitionFromExpressionInLetTest >> setupRefactoring: aViennaRefactoring [

	aViennaRefactoring newName: 'b'
]

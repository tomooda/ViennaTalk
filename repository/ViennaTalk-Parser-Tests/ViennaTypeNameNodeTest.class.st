Class {
	#name : #ViennaTypeNameNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeNameNodeTest >> testAsMaximalViennaType [

	self
		assert:
			('types T = nat * int inv mk_(n, i) == n > i; values v : T = mk_(2, 1.2)'
				 asViennaDocumentAst resolveIdentifier: 'v') type
				asMaximalViennaType
		equals: ViennaType nat * ViennaType int
]

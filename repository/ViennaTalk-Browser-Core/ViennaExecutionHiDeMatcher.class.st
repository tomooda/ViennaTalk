Class {
	#name : 'ViennaExecutionHiDeMatcher',
	#superclass : 'ViennaDiffSetHiDeMatcher',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'enumerfating' }
ViennaExecutionHiDeMatcher >> transitionsFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self referersTo: aViennaGlobalName in: aViennaEpiLog do: aBlock.
	self refereesFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock
]

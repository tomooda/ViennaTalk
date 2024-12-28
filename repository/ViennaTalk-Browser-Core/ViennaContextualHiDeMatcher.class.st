Class {
	#name : 'ViennaContextualHiDeMatcher',
	#superclass : 'ViennaDiffSetHiDeMatcher',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'enumerfating' }
ViennaContextualHiDeMatcher >> transitionsFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self referersTo: aViennaGlobalName in: aViennaEpiLog do: aBlock.
	self refereesFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock
]

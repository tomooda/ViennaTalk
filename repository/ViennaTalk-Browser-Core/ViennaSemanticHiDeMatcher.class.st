Class {
	#name : 'ViennaSemanticHiDeMatcher',
	#superclass : 'ViennaDiffSetHiDeMatcher',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'enumerating' }
ViennaSemanticHiDeMatcher >> transitionsFrom: aViennaGlobalName in: aViennaEpiLog do: aBlock [

	self referersTo: aViennaGlobalName in: aViennaEpiLog do: aBlock
]

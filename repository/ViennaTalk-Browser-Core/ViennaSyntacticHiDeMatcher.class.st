Class {
	#name : 'ViennaSyntacticHiDeMatcher',
	#superclass : 'ViennaDiffSetHiDeMatcher',
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'accessing' }
ViennaSyntacticHiDeMatcher >> impactOf: aViennaEpiLog [

	^ (self diffSet: aViennaEpiLog) changedGlobalNames
]

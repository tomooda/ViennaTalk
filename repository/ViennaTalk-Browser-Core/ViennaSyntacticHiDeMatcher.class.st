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

{ #category : 'evaluating' }
ViennaSyntacticHiDeMatcher >> value: aViennaEpiLog value: anotherViennaEpiLog [

	^ (self impactOf: aViennaEpiLog) includesAny:
		  (self impactOf: anotherViennaEpiLog)
]

Class {
	#name : 'ViennaDiffSetHiDeMatcher',
	#superclass : 'ViennaHiDeMatcher',
	#instVars : [
		'epiLogEnumerator'
	],
	#category : 'ViennaTalk-Browser-Core-HiDeHo',
	#package : 'ViennaTalk-Browser-Core',
	#tag : 'HiDeHo'
}

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> diffSet: aViennaEpiLog [

	^ epiLogEnumerator diffSet: aViennaEpiLog
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> epiLogEnumerator [

	^ epiLogEnumerator
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> epiLogEnumerator: aViennaEpiLogEnumerator [

	epiLogEnumerator := aViennaEpiLogEnumerator
]

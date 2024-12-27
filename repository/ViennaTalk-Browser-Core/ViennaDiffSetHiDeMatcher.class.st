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

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> impactOf: aViennaEpiLog [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaDiffSetHiDeMatcher >> prevFrom: aViennaEpiLog [

	^ epiLogEnumerator prevFrom: aViennaEpiLog
]

{ #category : 'evaluating' }
ViennaDiffSetHiDeMatcher >> value: aViennaEpiLog value: anotherViennaEpiLog [

	^ (self impactOf: aViennaEpiLog) includesAny:
		  (self impactOf: anotherViennaEpiLog)
]

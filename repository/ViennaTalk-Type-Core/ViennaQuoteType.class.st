Class {
	#name : #ViennaQuoteType,
	#superclass : #ViennaBasicType,
	#instVars : [
		'symbol'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaQuoteType class >> precedence [
	^ 6
]

{ #category : #'instance creation' }
ViennaQuoteType class >> with: aSymbol [
	^ self new
		setSymbol: aSymbol;
		yourself
]

{ #category : #comparing }
ViennaQuoteType >> = anObject [
	^ self class = anObject class and: [ symbol == anObject symbol ]
]

{ #category : #enumerating }
ViennaQuoteType >> basicDo: aBlock [
	aBlock value: symbol
]

{ #category : #testing }
ViennaQuoteType >> basicIncludes: anObject [
	^ symbol == anObject
]

{ #category : #testing }
ViennaQuoteType >> basicIsEnumerable [
	^ true
]

{ #category : #comparing }
ViennaQuoteType >> hash [
	^ symbol hash
]

{ #category : #accessing }
ViennaQuoteType >> name [
	^ '<', symbol asString, '>'
]

{ #category : #private }
ViennaQuoteType >> setSymbol: aSymbol [
	symbol := aSymbol asSymbol
]

{ #category : #private }
ViennaQuoteType >> symbol [
	^ symbol
]

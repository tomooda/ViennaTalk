Class {
	#name : #ViennaQuoteType,
	#superclass : #ViennaType,
	#type : #variable,
	#instVars : [
		'symbol'
	],
	#category : 'ViennaTalk-Type-Core'
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
ViennaQuoteType >> do: aBlock [
	aBlock value: symbol
]

{ #category : #comparing }
ViennaQuoteType >> hash [
	^ symbol hash
]

{ #category : #testing }
ViennaQuoteType >> includes: anObject [
	^ symbol == anObject
]

{ #category : #testing }
ViennaQuoteType >> isEnumerable [
	^ true
]

{ #category : #accessing }
ViennaQuoteType >> name [
	^ symbol asString
]

{ #category : #private }
ViennaQuoteType >> setSymbol: aSymbol [
	symbol := aSymbol asSymbol
]

{ #category : #private }
ViennaQuoteType >> symbol [
	^ symbol
]

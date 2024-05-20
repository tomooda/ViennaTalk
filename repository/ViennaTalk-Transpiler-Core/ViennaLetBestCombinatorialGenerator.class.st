Class {
	#name : 'ViennaLetBestCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'bindSubgenerators',
		'isBindReady',
		'isDone',
		'guardBlock',
		'subgenerator'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaLetBestCombinatorialGenerator class >> multibind: aCollectionOfViennaBindCombinatorialGenerator suchthat: aBlock in: aViennaCombinatorialGenerator [

	^ self new
		  bindSubgenerators: aCollectionOfViennaBindCombinatorialGenerator;
		  guardBlock: aBlock;
		  subgenerator: aViennaCombinatorialGenerator;
		  yourself
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> bindSubgenerators [

	^ bindSubgenerators
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> bindSubgenerators: anArrayOfViennaCombinatorialGenerator [

	bindSubgenerators := anArrayOfViennaCombinatorialGenerator.
	isDone := false
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> guardBlock [

	^ guardBlock
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> guardBlock: aBlock [

	guardBlock := aBlock
]

{ #category : 'initialization' }
ViennaLetBestCombinatorialGenerator >> initialize [

	super initialize.
	bindSubgenerators := Array new.
	guardBlock := [ :value | true ].
	isBindReady := false.
	isDone := true
]

{ #category : 'copying' }
ViennaLetBestCombinatorialGenerator >> postCopy [

	super postCopy.
	bindSubgenerators := bindSubgenerators collect: #copy.
	subgenerator := subgenerator ifNotNil: #copy
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> reset [

	bindSubgenerators do: #reset.
	isDone := false.
	subgenerator reset
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> step: aDictionary [

	isDone ifTrue: [ ^ self ].
	isBindReady ifFalse: [
		[ self valueGuard: aDictionary ] whileFalse: [
			(self stepBind: aDictionary) ifFalse: [ ^ nil ] ].
		isBindReady := true ].
	(subgenerator step: aDictionary copy) ifTrue: [
		isBindReady := true.
		^ true ].
	subgenerator reset.
	[ self stepBind: aDictionary ] whileTrue: [
		(self valueGuard: aDictionary) ifTrue: [
			isBindReady := true.
			^ true ] ].
	isDone := true.
	^ false
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> stepBind: aDictionary [

	| env |
	isDone ifTrue: [ ^ false ].
	env := aDictionary copy.
	bindSubgenerators do: [ :generator |
		isBindReady := false.
		(generator step: env) ifTrue: [ ^ true ].
		generator reset ].
	isDone := true.
	^ false
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> subgenerator [

	^ subgenerator
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> subgenerator: aVIennaCombinatorialGenerator [

	subgenerator := aVIennaCombinatorialGenerator
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> value: aDictionary [

	| env |
	isBindReady ifFalse: [
		[ self valueGuard: aDictionary ] whileFalse: [
			(self stepBind: aDictionary) ifFalse: [ ^ nil ] ].
		isBindReady := true ].
	isDone ifTrue: [ ^ nil ].
	env := aDictionary copy.
	self valueBind: env.
	^ subgenerator value: env
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> valueBind: aDictionary [

	isDone ifTrue: [ ^ nil ].
	bindSubgenerators do: [ :generator | generator value: aDictionary ]
]

{ #category : 'operations' }
ViennaLetBestCombinatorialGenerator >> valueGuard: aDictionary [

	| env |
	env := aDictionary copy.
	self valueBind: env.
	^ guardBlock value: env
]

Class {
	#name : 'ViennaBindCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'valueStream',
		'bindStream',
		'bindBlock',
		'isBindReady'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaBindCombinatorialGenerator class >> collection: aCollection bindBlock: aBlock [

	^ self new
		  set: aCollection;
		  bindBlock: aBlock;
		  yourself
]

{ #category : 'accessing' }
ViennaBindCombinatorialGenerator >> bindBlock [

	^ bindBlock
]

{ #category : 'accessing' }
ViennaBindCombinatorialGenerator >> bindBlock: aBlock [

	bindBlock := aBlock
]

{ #category : 'initialize' }
ViennaBindCombinatorialGenerator >> initialize [

	super initialize.
	valueStream := Array new readStream.
	bindStream := Array new readStream.
	isBindReady := false
]

{ #category : 'copying' }
ViennaBindCombinatorialGenerator >> postCopy [

	super postCopy.
	valueStream := valueStream ifNotNil: #copy.
	bindStream := bindStream ifNotNil: #copy
]

{ #category : 'operations' }
ViennaBindCombinatorialGenerator >> reset [
	"reset the enumeration of the trace paths"

	valueStream reset.
	bindStream := Array new readStream.
	isBindReady := false
]

{ #category : 'accessing' }
ViennaBindCombinatorialGenerator >> set [

	^ valueStream contents
]

{ #category : 'accessing' }
ViennaBindCombinatorialGenerator >> set: aCollection [

	valueStream := aCollection asArray readStream.
	bindStream := Array new readStream.
	isBindReady := false
]

{ #category : 'operations' }
ViennaBindCombinatorialGenerator >> step: aDictionary [

	bindStream next.
	isBindReady := false.
	^ self stepBind: aDictionary
]

{ #category : 'operations' }
ViennaBindCombinatorialGenerator >> stepBind: aDictionary [

	[ bindStream atEnd ] whileTrue: [
		valueStream atEnd ifTrue: [ ^ false ].
		bindStream := (bindBlock value: valueStream next)
			              readStream ].
	isBindReady := true.
	^ true
]

{ #category : 'operations' }
ViennaBindCombinatorialGenerator >> value: aDictionary [

	isBindReady ifFalse: [
		(self stepBind: aDictionary) ifFalse: [ ^ nil ] ].
	^ bindStream peek ifNotNil: [ :bind |
		  bind keysAndValuesDo: [ :var :value |
			  aDictionary at: var put: value ] ]
]

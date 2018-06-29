Class {
	#name : #WWTTranslator,
	#superclass : #Object,
	#instVars : [
		'matcherPairs',
		'vdmDecoder',
		'source'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #'instance creation' }
WWTTranslator class >> withAll: anArrayOfPairOfWWTTranslationMatcher [
	^ self new
		matcherPairs: anArrayOfPairOfWWTTranslationMatcher;
		yourself
]

{ #category : #'initialize-release' }
WWTTranslator >> initialize [
	super initialize.
	vdmDecoder := ViennaVDMValueDecoder new.
	matcherPairs := Array new.
	source := String new
]

{ #category : #translating }
WWTTranslator >> jsonToVdm: aString [
	| jsonObj |
	jsonObj := (NeoJSONReader on: aString readStream)
		listClass: OrderedCollection;
		next.
	matcherPairs
		do: [ :pair | 
			| vdmMatcher jsonMatcher |
			vdmMatcher := pair first.
			jsonMatcher := pair second.
			(jsonMatcher accept: jsonObj)
				ifNotNil: [ :binds | 
					| translatedBinds |
					translatedBinds := Dictionary new.
					binds keysAndValuesDo: [ :var :val | translatedBinds at: var put: (self jsonToVdm: val) ].
					^ (vdmMatcher emit: translatedBinds) viennaString ] ].
	^ jsonObj viennaString
]

{ #category : #accessing }
WWTTranslator >> matcherPairs: anArrayOfPairOfWWTTranslationMatcher [
	matcherPairs := anArrayOfPairOfWWTTranslationMatcher
]

{ #category : #accessing }
WWTTranslator >> source [
	^ source
]

{ #category : #accessing }
WWTTranslator >> source: aString [
	source := aString
]

{ #category : #translating }
WWTTranslator >> vdmToJson: aString [
	| vdmObj |
	vdmObj := vdmDecoder parse: aString.
	vdmObj isPetitFailure
		ifTrue: [ ^ aString ].
	matcherPairs
		do: [ :pair | 
			| vdmMatcher jsonMatcher |
			vdmMatcher := pair first.
			jsonMatcher := pair second.
			(vdmMatcher accept: vdmObj)
				ifNotNil: [ :binds | 
					| translatedBinds |
					translatedBinds := Dictionary new.
					binds keysAndValuesDo: [ :var :val | translatedBinds at: var put: (self vdmToJson: val) ].
					^ NeoJSONWriter toString: (jsonMatcher emit: translatedBinds) ] ].
	^ NeoJSONWriter toString: vdmObj
]

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
WWTTranslator >> jsonToVdm: jsonObj [
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
					^ (vdmMatcher emit: translatedBinds)  ] ].
	^ jsonObj 
]

{ #category : #translating }
WWTTranslator >> jsonToVdmString: jsonString [
	| jsonObj |
	jsonObj := (NeoJSONReader on: jsonString readStream)
		listClass: OrderedCollection;
		next.
	^ (self jsonToVdm: jsonObj) viennaString
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
WWTTranslator >> vdmToJson: vdmObj [
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
					^ jsonMatcher emit: translatedBinds ] ].
	^ vdmObj
]

{ #category : #translating }
WWTTranslator >> vdmToJsonString: vdmString [
	| vdmObj |
	vdmString trim = '()'
		ifTrue: [ ^ String new ].
	vdmObj := vdmDecoder parse: vdmString.
	vdmObj isPetitFailure
		ifTrue: [ ^ vdmObj ].
	^ NeoJSONWriter toString: (self vdmToJson: vdmObj)
]

Class {
	#name : #WWTTranslationRuleParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'vdmSet',
		'vdmSeq',
		'vdmMap',
		'vdmTuple',
		'vdmComposite',
		'vdmValue',
		'vdmPattern',
		'jsonList',
		'jsonObj1',
		'jsonObj2',
		'jsonValue',
		'jsonPattern',
		'var',
		'rule'
	],
	#category : 'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #parsers }
WWTTranslationRuleParser >> jsonList [
	^ ($[ asParser trim , jsonPattern , $] asParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonObj1 [
	^ (${ asParser trim , var , $: asParser trim , jsonPattern , $} asParser trim)
		==> [ :quin | 
			| key value |
			key := quin second.
			value := quin fourth.
			WWTTranslationDictionaryMatcher key: key value: value ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonObj2 [
	^ (${ asParser trim
		,
			((PPJsonParser new stringToken , $: asParser trim , jsonPattern)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: $, asParser trim) withoutSeparators , $} asParser trim)
		==> [ :triple | 
			| pairs |
			pairs := triple second.
			WWTTranslationMapMatcher from: (pairs collect: [ :pair | pair first -> pair second ]) asDictionary ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonPattern [
	^ jsonValue / jsonList / jsonObj1 / jsonObj2 / var
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonValue [
	^ PPJsonParser new value flatten
		==> [ :json | 
			WWTTranslationObjectMatcher
				with:
					((NeoJSONReader on: json readStream)
						listClass: OrderedCollection;
						next) ]
]

{ #category : #parsing }
WWTTranslationRuleParser >> parse: aString [
	| translator |
	translator := super parse: aString.
	translator isPetitFailure
		ifFalse: [ translator source: aString ].
	^ translator
]

{ #category : #parsers }
WWTTranslationRuleParser >> rule [
	^ (vdmPattern , '<=>' asParser trim , jsonPattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #parsing }
WWTTranslationRuleParser >> start [
	^ rule star ==> [ :pairs | WWTTranslator withAll: pairs ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> var [
	^ ($$ asParser , (PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star)
		flatten trim ==> [ :name | WWTTranslationBindingMatcher variable: name ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmComposite [
	| identifier |
	identifier := (PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') star.
	^ ('mk_' asParser , (identifier , ($` asParser , identifier) optional) flatten , $( asParser trim
		, (vdmPattern separatedBy: $, asParser trim) withoutSeparators , $) asParser trim)
		==> [ :array | 
			| constructor args |
			constructor := array second.
			args := array fourth.
			WWTTranslationCompositeMatcher constructor: constructor withAll: args ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmMap [
	^ (${ asParser trim , vdmPattern , '|->' asParser trim , vdmPattern , $} asParser trim)
		==> [ :array | 
			| key value |
			key := array second.
			value := array fourth.
			WWTTranslationDictionaryMatcher key: key value: value ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmPattern [
	^ vdmValue / vdmSet / vdmSeq / vdmMap / vdmTuple / vdmComposite / var
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmSeq [
	^ ($[ asParser trim , vdmPattern , $] asParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmSet [
	^ (${ asParser trim , vdmPattern , $} asParser trim) ==> [ :triple | WWTTranslationSetMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmTuple [
	^ ('mk_' asParser trim , $( asParser trim , (vdmPattern separatedBy: $, asParser trim) withoutSeparators
		, $) asParser trim) ==> [ :array | WWTTranslationArrayMatcher withAll: array third ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmValue [
	^ ViennaVDMValueDecoder new expression ==> [ :obj | WWTTranslationObjectMatcher with: obj ]
]

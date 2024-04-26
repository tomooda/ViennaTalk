Class {
	#name : #WWTTranslationRuleParser,
	#superclass : #PP2CompositeNode,
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
	#category : #'ViennaTalk-WeblyWalkThrough-Translators'
}

{ #category : #parsers }
WWTTranslationRuleParser >> jsonList [
	^ ($[ asPParser trim , jsonPattern , $] asPParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonObj1 [
	^ (${ asPParser trim , var , $: asPParser trim , jsonPattern , $} asPParser trim)
		==> [ :quin | 
			| key value |
			key := quin second.
			value := quin fourth.
			WWTTranslationDictionaryMatcher key: key value: value ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> jsonObj2 [
	^ (${ asPParser trim
		,
			((PP2JsonParser new stringToken , $: asPParser trim , jsonPattern)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: $, asPParser trim) withoutSeparators , $} asPParser trim)
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
	^ PP2JsonParser new value flatten
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
	translator isPetit2Failure
		ifFalse: [ translator source: aString ].
	^ translator
]

{ #category : #parsers }
WWTTranslationRuleParser >> rule [
	^ (vdmPattern , '<=>' asPParser trim , jsonPattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #parsing }
WWTTranslationRuleParser >> start [
	^ rule starA ==> [ :pairs | WWTTranslator withAll: pairs ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> var [
	^ ($$ asPParser , (PP2PredicateObjectNode on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected')
		, (PP2PredicateObjectNode on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected') starA)
		flatten trim ==> [ :name | WWTTranslationBindingMatcher variable: name ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmComposite [
	| identifier |
	identifier := (PP2PredicateObjectNode
		on: [ :c | ViennaUnicode isInitialLetter: c ]
		message: 'identifier expected')
		,
			(PP2PredicateObjectNode
				on: [ :c | ViennaUnicode isFollowingLetter: c ]
				message: 'identifier expected') starA.
	^ ('mk_' asPParser
		, (identifier , ($` asPParser , identifier) optional) flatten
		, $( asPParser trim
		, (vdmPattern separatedBy: $, asPParser trim) withoutSeparators
		, $) asPParser trim)
		==> [ :array | 
			| constructor args |
			constructor := array second.
			args := array fourth.
			WWTTranslationCompositeMatcher constructor: constructor withAll: args ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmMap [
	^ (${ asPParser trim , vdmPattern , '|->' asPParser trim , vdmPattern , $} asPParser trim)
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
	^ ($[ asPParser trim , vdmPattern , $] asPParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmSet [
	^ (${ asPParser trim , vdmPattern , $} asPParser trim) ==> [ :triple | WWTTranslationSetMatcher with: triple second ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmTuple [
	^ ('mk_' asPParser trim , $( asPParser trim
		, (vdmPattern separatedBy: $, asPParser trim) withoutSeparators
		, $) asPParser trim)
		==> [ :array | WWTTranslationArrayMatcher withAll: array third ]
]

{ #category : #parsers }
WWTTranslationRuleParser >> vdmValue [

	^ ViennaVDMValueDecoder current expression
	  ==> [ :obj | WWTTranslationObjectMatcher with: obj ]
]

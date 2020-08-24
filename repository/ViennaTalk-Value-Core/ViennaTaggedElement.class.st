Class {
	#name : #ViennaTaggedElement,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'name',
		'attributes',
		'eventHandlers',
		'contents',
		'tokens',
		'identifier'
	],
	#category : #'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaTaggedElement class >> name: aString attributes: aDictionary eventHandlers: anotherDictionary contents: anArray tokens: aSet identifier: anInteger [
	^ self new
		name: aString;
		attributes: aDictionary;
		eventHandlers: anotherDictionary;
		contents: anArray;
		tokens: aSet;
		identifier: anInteger;
		yourself
]

{ #category : #comparing }
ViennaTaggedElement >> = anObject [
	^ self class = anObject class
		and: [ name = anObject name
				and: [ attributes = anObject attributes
						and: [ eventHandlers = anObject eventHandlers
								and: [ contents = anObject contents
										and: [ tokens = anObject tokens and: [ identifier = anObject identifier ] ] ] ] ] ]
]

{ #category : #printing }
ViennaTaggedElement >> asXml [
	^ self printXml
]

{ #category : #accessing }
ViennaTaggedElement >> attributes [
	^ attributes
]

{ #category : #accessing }
ViennaTaggedElement >> attributes: aDictionary [
	attributes := aDictionary
]

{ #category : #accessing }
ViennaTaggedElement >> contents [
	^ contents
]

{ #category : #accessing }
ViennaTaggedElement >> contents: anArrayOfViennaTaggedElementOrString [
	contents := anArrayOfViennaTaggedElementOrString
]

{ #category : #accessing }
ViennaTaggedElement >> eventHandlers [
	^ eventHandlers
]

{ #category : #accessing }
ViennaTaggedElement >> eventHandlers: aDictionary [
	eventHandlers := aDictionary
]

{ #category : #comparing }
ViennaTaggedElement >> hash [
	^ (((((self class hash bitXor: name hash) bitXor: attributes hash)
		bitXor: eventHandlers hash) bitXor: contents hash)
		bitXor: tokens hash) bitXor: identifier hash
]

{ #category : #accessing }
ViennaTaggedElement >> identifier [
	^ identifier
]

{ #category : #accessing }
ViennaTaggedElement >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
ViennaTaggedElement >> name [
	^ name
]

{ #category : #accessing }
ViennaTaggedElement >> name: aString [
	name := aString
]

{ #category : #printing }
ViennaTaggedElement >> neoJsonOn: neoJSONWriter [
	(Dictionary new
		at: 'TaggedElement'
			put:
			{name.
			attributes.
			(eventHandlers associations
				collect: [ :assoc | assoc key -> {('Handler' -> assoc value)} asDictionary ])
				asDictionary.
			contents.
			(tokens asArray
				collect: [ :assoc | {('token' -> assoc value)} asDictionary ]).
			identifier};
		yourself) neoJsonOn: neoJSONWriter
]

{ #category : #printing }
ViennaTaggedElement >> printXml [
	^ String streamContents: [ :stream | self printXmlOn: stream ]
]

{ #category : #printing }
ViennaTaggedElement >> printXmlOn: aStream [
	aStream
		nextPut: $<;
		nextPutAll: name.
	attributes
		keysAndValuesDo: [ :key :value | 
			(key size > 2
				and: [ (key copyFrom: 1 to: 2) = 'on'
						and: [ eventHandlers includesKey: (key allButFirst: 2) ] ])
				ifFalse: [ aStream
						space;
						nextPutAll: key;
						nextPutAll: '="';
						nextPutAll: value asHTMLString;
						nextPut: $" ] ].
	eventHandlers
		keysAndValuesDo: [ :event :handler | 
			aStream
				space;
				nextPutAll: 'on';
				nextPutAll: event;
				nextPutAll: '="Webly.event(event,''';
				nextPutAll: handler first;
				nextPutAll: ''',''';
				nextPutAll: handler second;
				nextPutAll: ''', ()=>{';
				nextPutAll:
					(attributes
						at: 'on' , event
						ifPresent: [ :value | value asHTMLString ]
						ifAbsent: [ '' ]);
				nextPutAll: '})"' ].
	aStream
		nextPutAll: ' tokens="';
		nextPutAll: tokens viennaString asHTMLString;
		nextPut: $".
	aStream
		nextPutAll: ' identifier="';
		nextPutAll: identifier printString;
		nextPut: $".
	contents
		ifEmpty: [ aStream nextPutAll: ' />' ]
		ifNotEmpty: [ aStream nextPutAll: ' >'.
			contents
				do: [ :content | 
					content isString
						ifTrue: [ aStream nextPutAll: content asHTMLString ]
						ifFalse: [ content printXmlOn: aStream ] ].
			aStream
				nextPutAll: '</';
				nextPutAll: name;
				nextPutAll: '>' ]
]

{ #category : #accessing }
ViennaTaggedElement >> tokens [
	^ tokens
]

{ #category : #accessing }
ViennaTaggedElement >> tokens: aSet [
	tokens := aSet
]

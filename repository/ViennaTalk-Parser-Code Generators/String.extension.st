Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Code Generators' }
String >> , aString [
	^ aString isViennaTracingString
		ifTrue: [ self asViennaTracingString , aString ]
		ifFalse: [ super , aString ]
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
String >> asViennaTracingString [
	^ ViennaTracingString fromString: self
]

{ #category : #'*ViennaTalk-Parser-Code Generators' }
String >> asViennaTracingString: anObject [
	^ ViennaTracingString
		string: self
		sources: (OrderedCollection with: (1 to: self size) -> anObject)
]

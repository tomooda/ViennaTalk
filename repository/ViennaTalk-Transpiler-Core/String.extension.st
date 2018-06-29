Extension { #name : #String }

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> , aString [
	^ aString isViennaTracingString
		ifTrue: [ self asViennaTracingString , aString ]
		ifFalse: [ super , aString ]
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString [
	^ ViennaTracingString fromString: self
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString: anObject [
	^ ViennaTracingString
		string: self
		sources: (OrderedCollection with: (1 to: self size) -> anObject)
]

Extension { #name : 'String' }

{ #category : '*ViennaTalk-Parser-Highlighters' }
String >> ++ aTextOrString [

	^ aTextOrString isText
		  ifTrue: [ self asText , aTextOrString ]
		  ifFalse: [ self , aTextOrString ]
]

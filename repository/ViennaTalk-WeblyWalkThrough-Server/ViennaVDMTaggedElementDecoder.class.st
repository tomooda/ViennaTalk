Class {
	#name : #ViennaVDMTaggedElementDecoder,
	#superclass : #ViennaVDMValueDecoder,
	#instVars : [
		'taggedElement'
	],
	#category : #'ViennaTalk-WeblyWalkThrough-Server'
}

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> attributes [
	^ (lbrace
		,
			((mapletArrow ==> [ :single | Array new ])
				/
					((self textLiteral , mapletArrow , (self textLiteral / self numericLiteral))
						==> [ :triple | triple first -> triple third ]
						separatedBy: comma) withoutSeparators) , rbrace)
		==> [ :triple | triple second asDictionary ]
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> contents [
	^ ((lbracket
		,
			(self textLiteral / taggedElement separatedBy: comma)
				withoutSeparators , rbracket)
		==> [ :triple | triple second ifNil: [ Array new ] ])
		/ ((lbracket , rbracket) ==> [ :pair | Array new ])
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> default [
	^ ( self textLiteral / taggedElement) end
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> eventHandlers [
	^ (lbrace
		, (self quoteLiteral separatedBy: comma) withoutSeparators optional
		, rbrace) ==> [ :triple | triple second ifNil: [ Array new ] ]
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> tagName [
	^ self textLiteral
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> taggedElement [
	^ ('mk_TaggedElement' asPParser , lparen , self tagName , comma
		, self attributes , comma , self eventHandlers , comma
		, self contents , comma , self tokens , comma
		, #digit asPParser plus flatten , rparen)
		==> [ :array | 
			ViennaTaggedElement
				name: array third
				attributes: array fifth
				eventHandlers: array seventh
				contents: array ninth
				tokens: (array at: 11)
				identifier: (array at: 13) asInteger ]
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> token [
	^ ('mk_token' asPParser , lparen , expression , rparen)
		==> [ :array | ViennaToken with: array third ]
]

{ #category : #parsing }
ViennaVDMTaggedElementDecoder >> tokens [
	^ (lbrace
		, (self token separatedBy: comma) withoutSeparators optional
		, rbrace)
		==> [ :triple | triple second ifNotNil: #asSet ifNil: [ Set new ] ]
]

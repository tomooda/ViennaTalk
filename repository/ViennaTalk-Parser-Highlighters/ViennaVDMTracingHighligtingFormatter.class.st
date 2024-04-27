Class {
	#name : #ViennaVDMTracingHighligtingFormatter,
	#superclass : #ViennaVDMFormatter,
	#instVars : [
		'identifierAttribute',
		'typeAttribute',
		'moduleAttribute',
		'literalAttribute'
	],
	#category : #'ViennaTalk-Parser-Highlighters'
}

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> format: aViennaNode [

	| text |
	text := (super format: aViennaNode) asText.
	text string: (text string asViennaTracingString: aViennaNode).
	^ text
]

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> identifier: aString [

	^ aString asText addAttribute: self identifierAttribute
]

{ #category : #accessing }
ViennaVDMTracingHighligtingFormatter >> identifierAttribute [
	^ identifierAttribute
		ifNil: [ identifierAttribute := TextColor
				color: (Color blue mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : #private }
ViennaVDMTracingHighligtingFormatter >> join: aString withAll: aCollectionOfString [
	^ aCollectionOfString
		ifNotEmpty: [ | string |
			string := aCollectionOfString first.
			2 to: aCollectionOfString size do:
				[ :index | string := string , aString , (aCollectionOfString at: index) ].
			string ]
		ifEmpty: [ '' ]
]

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> keyword: aString [

	^ aString asText allBold
]

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> literal: aString [

	^ aString asText addAttribute: self literalAttribute
]

{ #category : #accessing }
ViennaVDMTracingHighligtingFormatter >> literalAttribute [
	^ literalAttribute
		ifNil:
			[ literalAttribute := TextColor color: Color yellow muchDarker ]
]

{ #category : #accessing }
ViennaVDMTracingHighligtingFormatter >> moduleAttribute [
	^ moduleAttribute
		ifNil: [ moduleAttribute := TextColor
				color: (Color red mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> moduleName: aString [

	^ aString asText addAttribute: self moduleAttribute
]

{ #category : #accessing }
ViennaVDMTracingHighligtingFormatter >> typeAttribute [
	^ typeAttribute
		ifNil: [ typeAttribute := TextColor
				color: (Color cyan mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : #formatting }
ViennaVDMTracingHighligtingFormatter >> typeName: aString [

	^ aString asText addAttribute: self typeAttribute
]

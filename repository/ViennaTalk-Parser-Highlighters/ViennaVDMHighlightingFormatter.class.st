Class {
	#name : 'ViennaVDMHighlightingFormatter',
	#superclass : 'ViennaVDMFormatter',
	#instVars : [
		'typeAttribute',
		'identifierAttribute',
		'literalAttribute',
		'moduleAttribute'
	],
	#category : 'ViennaTalk-Parser-Highlighters',
	#package : 'ViennaTalk-Parser-Highlighters'
}

{ #category : 'symbol access' }
ViennaVDMHighlightingFormatter >> cr [

	^ super cr asText
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> empty [

	^ String new asText
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> format: aViennaNode [

	aViennaNode isString ifTrue: [ ^ self identifier: aViennaNode ].
	^ (super format: aViennaNode) asText
		  addAttribute: (ViennaASTTextAttribute node: aViennaNode);
		  yourself
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> identifier: aString [

	^ (super identifier: aString) asText addAttribute: self identifierAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlightingFormatter >> identifierAttribute [
	^ identifierAttribute
		ifNil: [ identifierAttribute := TextColor
				color: (Color blue mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'private' }
ViennaVDMHighlightingFormatter >> join: aString withAll: aCollectionOfString [

	^ aCollectionOfString
		  ifNotEmpty: [
			  | string |
			  string := self empty ++ aCollectionOfString first.
			  2 to: aCollectionOfString size do: [ :index |
				  string := string ++ aString ++ (aCollectionOfString at: index) ].
			  string ]
		  ifEmpty: [ self empty ]
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> keyword: aString [

	^ aString asText allBold
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> literal: aString [

	^ aString asText addAttribute: self literalAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlightingFormatter >> literalAttribute [
	^ literalAttribute
		ifNil:
			[ literalAttribute := TextColor color: Color yellow muchDarker ]
]

{ #category : 'accessing' }
ViennaVDMHighlightingFormatter >> moduleAttribute [
	^ moduleAttribute
		ifNil: [ moduleAttribute := TextColor
				color: (Color red mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> moduleName: aString [

	^ aString asText addAttribute: self moduleAttribute
]

{ #category : 'symbol access' }
ViennaVDMHighlightingFormatter >> space [

	^ super space asText
]

{ #category : 'accessing' }
ViennaVDMHighlightingFormatter >> typeAttribute [
	^ typeAttribute
		ifNil: [ typeAttribute := TextColor
				color: (Color cyan mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'formatting' }
ViennaVDMHighlightingFormatter >> typeName: aString [

	^ aString asText addAttribute: self typeAttribute
]

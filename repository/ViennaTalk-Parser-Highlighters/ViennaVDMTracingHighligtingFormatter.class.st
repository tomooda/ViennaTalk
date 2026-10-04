Class {
	#name : 'ViennaVDMTracingHighligtingFormatter',
	#superclass : 'ViennaVDMHighlightingFormatter',
	#category : 'ViennaTalk-Parser-Highlighters',
	#package : 'ViennaTalk-Parser-Highlighters'
}

{ #category : 'formatting' }
ViennaVDMTracingHighligtingFormatter >> empty [

	^ ViennaTracingString new asText
]

{ #category : 'formatting' }
ViennaVDMTracingHighligtingFormatter >> format: aViennaNode [

	| text |
	text := (super format: aViennaNode) asText.
	aViennaNode isString ifFalse: [ text string: (text string asViennaTracingString: aViennaNode) ].
	^ text
]

Class {
	#name : #ViennaVDMSymbolFormatter,
	#superclass : #ViennaAbstractFormatter,
	#category : #'ViennaTalk-Parser-Formatters'
}

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> and [
	^ String with: (Character codePoint:16r2227)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> arrow [
	^ String with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> bool [
	^ String with: (Character codePoint: 16r1D539)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> concat [
	^ String with: Character space with: (Character codePoint: 16r20D5)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dinter [
	^ String with: (Character codePoint: 16r22C2)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> domainRestrictedBy [
	^ String with: (Character codePoint: 16r2A64)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> domainRestrictedTo [
	^ String with: (Character codePoint: 16r22B2)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dot [
	^ String with: (Character codePoint: 16r22C5)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dots [
	^ String with: (Character codePoint: 16r22EF)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dunion [
	^ String with: (Character codePoint: 16r22C3)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> equiv [
	^ String with: (Character codePoint: 16r21D4)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> exists [
	^ String with: (Character codePoint: 16r2203)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> exists1 [
	^ String with: (Character codePoint: 16r2203) with: $!
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> forall [
	^ String with: (Character codePoint: 16r2200)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> greaterThanOrEqual [
	^ Character codePoint: 16r2265
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> imply [
	^ String with: (Character codePoint: 16r21D2)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inmapInfix [
	^ String with: (Character codePoint: 16r2194) with: (Character codePoint: 16rFE0E) with: (Character codePoint: 16r36B)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inmapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inset [
	^ String with: (Character codePoint: 16r2208)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> int [
	^ String with: (Character codePoint: 16r2124)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inter [
	^ Character codePoint: 16r2229
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inverse: aString [
	^ aString++ '⁻¹'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> iota [
	^ String with: (Character codePoint: 16r3B9)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> iterate [
	^ String with: (Character codePoint: 16r2191)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> lambda [
	^ String with: (Character codePoint: 16r1D706)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> lessThanOrEqual [
	^ String with: (Character codePoint: 16r2264)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mapInfix [
	^ String with: (Character codePoint: 16r2192) with: (Character codePoint: 16r36B)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> maplet [
	^ String with: (Character codePoint: 16r21A6)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mu [
	^ String with: (Character codePoint: 16r1D707)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mul [
	^ String with: (Character codePoint: 16r2a2f)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> munion [
	^ String with: (Character codePoint: 16r222A) with: (Character codePoint: 16r36B)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> nat [
	^ String with: (Character codePoint: 16r2115)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> nat1 [
	^ String with: (Character codePoint: 16r2115) with: (Character codePoint: 16r2081)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> not [
	^ String with: (Character codePoint: 16rac)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> notEqual [
	^ String with: (Character codePoint: 16r2260)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> notInSet [
	^ String with: (Character codePoint: 16r2209)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> oparrow [
	^ String with: (Character codePoint: 16r6F) with: (Character codePoint: 16r20EF)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> or [
	^ String with: (Character codePoint: 16r2228)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> override [
	^ String with: (Character codePoint: 16r2020)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> partialFunction [
	^ String with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> power [
	^ String with: (Character codePoint: 16r2131)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> psubset [
	^ String with: (Character codePoint: 16r2282)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> rangeRestrictedBy [
	^ String with: (Character codePoint: 16r2a65)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> rangeRestrictedTo [
	^ String with: (Character codePoint: 16r22B3)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> real [
	^ String with: (Character codePoint: 16r211d)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> seq1Postfix [
	^ '+'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> seq1Prefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> seqPostfix [
	^ '*'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> seqPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> setDifference [
	^ String with: (Character codePoint: 16r2216)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> setPostfix [
	^ '-set'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> setPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> subset [
	^ String with: (Character codePoint: 16r2286)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> totalFunction [
	^ String with: (Character value: 16r21f8)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> union [
	^ String with: (Character codePoint: 16r222A)
]

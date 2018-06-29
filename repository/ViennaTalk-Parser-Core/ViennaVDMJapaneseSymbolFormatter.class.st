Class {
	#name : #ViennaVDMJapaneseSymbolFormatter,
	#superclass : #ViennaAbstractFormatter,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> and [
	^ String with: (Character codePoint:16r2227)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> arrow [
	^ String with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> bool [
	^ 'bool'
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> concat [
	^ String with: Character space with: (Character codePoint: 16r2312)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> dinter [
	^ String with: (Character codePoint: 16r2229)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> domainRestrictedBy [
	^ String with: $- with: (Character codePoint: 16r25c1)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> domainRestrictedTo [
	^ String with: (Character codePoint: 16r25c1)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> dot [
	^ String with: (Character codePoint: 16r30fb)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> dots [
	^ String with: (Character codePoint: 16r2026)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> dunion [
	^ String with: (Character codePoint: 16r222a)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> equiv [
	^ String with: (Character codePoint: 16r21D4)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> exists [
	^ String with: (Character codePoint: 16r2203)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> exists1 [
	^ String with: (Character codePoint: 16r2203) with: $!
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> forall [
	^ String with: (Character codePoint: 16r2200)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> greaterThanOrEqual [
	^ Character codePoint: 16r2267
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> imply [
	^ String with: (Character codePoint: 16r21D2)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inmapInfix [
	^ String with: $m with: (Character codePoint: 16r2194)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inmapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inset [
	^ String with: (Character codePoint: 16r2208)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> int [
	^ String with: (Character codePoint: 16r2124)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inter [
	^ Character codePoint: 16r2229
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inversePostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> inversePrefix [
	^ 'inverse '
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> iota [
	^ String with: (Character codePoint: 16r3B9)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> iterate [
	^ String with: (Character codePoint: 16r2191)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> lambda [
	^ String with: (Character codePoint: 16r03bb)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> lessThanOrEqual [
	^ String with: (Character codePoint: 16r2266)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> mapInfix [
	^ String with: $m with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> mapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> maplet [
	^ String with: (Character codePoint: 16r21A6)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> mu [
	^ String with: (Character codePoint: 16r03bc)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> mul [
	^ String with: (Character codePoint: 16rd7)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> munion [
	^ String with: $m with: (Character codePoint: 16r222a)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> nat [
	^ String with: (Character codePoint: 16r2115)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> nat1 [
	^ String with: (Character codePoint: 16r2115) with: (Character codePoint: 16r2081)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> not [
	^ String with: (Character codePoint: 16rac)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> notEqual [
	^ String with: (Character codePoint: 16r2260)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> notInSet [
	^ String with: (Character codePoint: 16r2209)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> oparrow [
	^ String with: (Character codePoint: 16r6F) with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> or [
	^ String with: (Character codePoint: 16r2228)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> override [
	^ String with: (Character codePoint: 16r2020)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> partialFunction [
	^ String with: (Character codePoint: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> power [
	^ String with: (Character codePoint: 16r2131)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> psubset [
	^ String with: (Character codePoint: 16r2282)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> rangeRestrictedBy [
	^ String with: (Character codePoint: 16r25b7) with: $-
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> rangeRestrictedTo [
	^ String with: (Character codePoint: 16r25b7)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> real [
	^ String with: (Character codePoint: 16r211d)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> seq1Postfix [
	^ '+'
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> seq1Prefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> seqPostfix [
	^ '*'
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> seqPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> setDifference [
	^ String with: (Character codePoint: 16r2216)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> setPostfix [
	^ '-set'
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> setPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> space [
	^ ' '
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> subset [
	^ String with: (Character codePoint: 16r2286)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> totalFunction [
	^ String with: $+ with: (Character value: 16r2192)
]

{ #category : #'symbol access' }
ViennaVDMJapaneseSymbolFormatter >> union [
	^ String with: (Character codePoint: 16r222A)
]

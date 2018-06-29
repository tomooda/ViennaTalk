Class {
	#name : #ViennaVDMSymbolFormatter,
	#superclass : #ViennaAbstractFormatter,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> and [
	^ '∧'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> bool [
	^ '𝔹'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> concat [
	^ ' ⃕'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dinter [
	^ '⋂'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> domainRestrictedBy [
	^ '⩤'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> domainRestrictedTo [
	^ '⊲'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dot [
	^ '⋅'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dots [
	^ '⋯'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> dunion [
	^ '⋃'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> equiv [
	^ '⇔'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> exists [
	^ '∃'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> exists1 [
	^ '∃!'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> forall [
	^ '∀'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> greaterThanOrEqual [
	^ '≥'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> imply [
	^ '⇒'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inmapInfix [
	^ '↔︎ͫ'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inmapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inset [
	^ '∈'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> int [
	^ String with: (Character codePoint: 16r2124)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inter [
	^ '∩'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inversePostfix [
	^ String with: (Character codePoint: 16r207b) with: (Character codePoint: 16r00b9)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> inversePrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> iota [
	^ 'ι'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> iterate [
	^ '↑'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> lambda [
	^ '𝜆'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> lessThanOrEqual [
	^ '≤'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mapInfix [
	^ '→ͫ'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mapPrefix [
	^ ''
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> maplet [
	^ '↦'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mu [
	^ '𝜇'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> mul [
	^ String with: (Character codePoint: 16r2a2f)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> munion [
	^ '∪ͫ'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> nat [
	^ String with: (Character codePoint: 16r2115)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> nat1 [
	^ 'ℕ₁'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> not [
	^ String with: (Character codePoint: 16rac)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> notEqual [
	^ '≠'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> notInSet [
	^ '∉'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> oparrow [
	^ 'o⃯'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> or [
	^ '∪'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> override [
	^ '†'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> partialFunction [
	^ '→'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> power [
	^ 'ℱ'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> psubset [
	^ '⊂'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> rangeRestrictedBy [
	^ String with: (Character codePoint: 16r2a65)
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> rangeRestrictedTo [
	^ '⊳'
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
ViennaVDMSymbolFormatter >> space [
	^ ' '
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> subset [
	^ '⊆'
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> totalFunction [
	^ Character value: 16r21f8
]

{ #category : #'symbol access' }
ViennaVDMSymbolFormatter >> union [
	^ '∪'
]

Class {
	#name : #ViennaVDMTracingFormatter,
	#superclass : #ViennaVDMFormatter,
	#category : 'ViennaTalk-Transpiler-Debugger'
}

{ #category : #formatting }
ViennaVDMTracingFormatter >> format: aViennaNode [
	^ (super format: aViennaNode) asViennaTracingString: aViennaNode
]

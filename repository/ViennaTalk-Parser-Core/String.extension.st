Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpression [
	| ast |
	ast := ViennaVDMParser new expression end parse: self.
	^ Compiler evaluate: (ViennaVDM2Smalltalk new generate: ast)
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatement [
	| ast |
	ast := ViennaVDMParser new statement end parse: self.
	^ Compiler evaluate: (ViennaVDM2Smalltalk new generate: ast)
]

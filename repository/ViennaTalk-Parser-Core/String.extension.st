Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpression [
	^ Compiler new
		evaluate: (ViennaVDM2Smalltalk new generate: self asViennaExpressionAst)
		in: thisContext sender
		to: thisContext sender receiver
		notifying: nil
		ifFail: nil
		logged: false
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpressionAst [
	^ ViennaVDMParser new expression end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatement [
	^ Compiler new
		evaluate: (ViennaVDM2Smalltalk new generate: self asViennaStatementAst)
		in: thisContext sender
		to: thisContext sender receiver
		notifying: nil
		ifFail: nil
		logged: false
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatementAst [
	^ ViennaVDMParser new statement end parse: self
]

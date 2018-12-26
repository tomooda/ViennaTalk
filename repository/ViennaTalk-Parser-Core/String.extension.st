Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpression [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaExpressionAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpressionAst [
	^ ViennaVDMParser new expression end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatement [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaStatementAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatementAst [
	^ ViennaVDMParser new statement end parse: self
]

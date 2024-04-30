Extension { #name : #String }

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> , aString [

	^ [
	  aString isViennaTracingString
		  ifTrue: [ self asViennaTracingString , aString ]
		  ifFalse: [ super , aString ] ]
		  on: Error
		  do: [ :ex | super , aString ]
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaExpression [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaExpressionAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaStatement [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaStatementAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString [
	^ ViennaTracingString fromString: self
]

{ #category : #'*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString: anObject [
	^ ViennaTracingString
		string: self
		sources: (OrderedCollection with: (1 to: self size) -> anObject)
]

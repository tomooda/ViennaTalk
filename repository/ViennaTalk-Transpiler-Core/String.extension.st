Extension { #name : 'String' }

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> asViennaExpression [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaExpressionAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> asViennaStatement [
	^ OpalCompiler new
		source: (ViennaVDM2SmalltalkScript new generate: self asViennaStatementAst);
		context: thisContext sender;
		receiver: thisContext sender receiver;
		evaluate
]

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString [
	^ ViennaTracingString fromString: self
]

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> asViennaTracingString: anObject [
	^ ViennaTracingString
		string: self
		sources: (OrderedCollection with: (1 to: self size) -> anObject)
]

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> copyReplaceFrom: start to: stop with: replacementCollection [

	^ [
	  replacementCollection isViennaTracingString
		  ifTrue: [
			  self asViennaTracingString
				  copyReplaceFrom: start
				  to: stop
				  with: replacementCollection ]
		  ifFalse: [
		  super copyReplaceFrom: start to: stop with: replacementCollection ] ]
		  on: Error
		  do: [ :ex |
			  super copyReplaceFrom: start to: stop with: replacementCollection ]
]

{ #category : '*ViennaTalk-Transpiler-Core' }
String >> ifTracingString: aBlock [

	
]

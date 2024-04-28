Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaDocumentAst [

	^ ViennaVDMParser current document end parse: self trim
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpressionAst [
	^ ViennaVDMParser current expression end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaModuleAst [

	^ ViennaVDMParser current module end parse: self trim
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatementAst [
	^ ViennaVDMParser current statement end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaTypeAst [

	^ ViennaVDMParser current typeOrRecordTypeDefinition end parse: self
]

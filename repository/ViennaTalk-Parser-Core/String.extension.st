Extension { #name : #String }

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaDocumentAst [

	^ ViennaVDMParser new document end parse: self trim
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaExpressionAst [
	^ ViennaVDMParser new expression end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaStatementAst [
	^ ViennaVDMParser new statement end parse: self
]

{ #category : #'*ViennaTalk-Parser-Core' }
String >> asViennaTypeAst [

	^ ViennaVDMParser new typeOrRecordTypeDefinition end parse: self
]

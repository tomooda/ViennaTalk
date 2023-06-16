Class {
	#name : #ViennaVDMParser,
	#superclass : #ViennaVDMGrammar,
	#instVars : [
		'annotations'
	],
	#category : #'ViennaTalk-Parser-Core'
}

{ #category : #accessing }
ViennaVDMParser class >> ignoredNames [

	^ super ignoredNames , #( 'annotations' )
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> abs: arg [

	^ ViennaArithmeticAbsNode expression: arg
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> access [
	^ super access
		=>> [ :start :end :string | 
			ViennaNode
				label: 'Access'
				start: start
				end: end
				with: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessFunctionDefinition [

	self flushAnnotations.
	^ super accessFunctionDefinition =>> [ :start :end :array |
	  (ViennaAccessFunctionDefinitionNode
		   access: (ViennaNode label: 'Access' withAll: array first)
		   functionDefinition: array second)
		  start: start end: end;
		  annotations: self flushAnnotations;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessOperationDefinition [

	self flushAnnotations.
	^ super accessOperationDefinition =>> [ :start :end :array |
	  (ViennaAccessOperationDefinitionNode
		   access: (ViennaNode label: 'Access' withAll: array first)
		   operationDefinition: array second)
		  start: start end: end;
		  annotations: self flushAnnotations;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessTypeDefinition [

	self flushAnnotations.
	^ super accessTypeDefinition =>> [ :start :end :array |
	  (ViennaAccessTypeDefinitionNode
		   access: (ViennaNode label: 'Access' withAll: array first)
		   typeDefinition: array second)
		  start: start end: end;
		  annotations: self flushAnnotations;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessValueDefinition [

	self flushAnnotations.
	^ super accessValueDefinition =>> [ :start :end :array |
	  (ViennaAccessValueDefinitionNode
		   access: (ViennaNode label: 'Access' withAll: array first)
		   valueDefinition: array second)
		  start: start end: end;
		  annotations: self flushAnnotations;
		  yourself ]
]

{ #category : #annotations }
ViennaVDMParser >> addAnnotation: aString [

	annotations add: aString.
	^ aString
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> alwaysStatement [

	^ super alwaysStatement =>> [ :start :end :pair |
	  (ViennaAlwaysStatementNode
		   entailingStatement: pair first
		   bodyStatement: pair second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> and: arg1 and: arg2 [

	^ ViennaAndNode expression: arg1 expression: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> anonymousField [
	^ super anonymousField
		=>> [ :start :end :typeNode | 
			{nil.
			false.
			(typeNode
				start: start end: end;
				yourself)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> apply: func args: args [

	^ ViennaApplyNode expression: func argumentExpressionList: args
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> assignStatement [

	^ super assignStatement ==> [ :pair |
	  ViennaAssignStatementNode
		  stateDesignator: pair first
		  expression: pair second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> assignmentDefinition [

	^ super assignmentDefinition =>> [ :start :end :array |
	  (ViennaAssignmentDefinitionNode
		   identifier: array first
		   type: array second
		   expression: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> basicType [

	^ super basicType =>> [ :start :end :ast |
	  (ViennaBasicTypeNode identifier: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> bindList [

	^ super bindList =>> [ :start :end :array |
	  (ViennaBindListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> blockStatement [

	^ super blockStatement ==> [ :array |
	  ViennaBlockStatementNode withAll: array first , array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> callStatement [

	^ super callStatement ==> [ :array |
	  ViennaCallStatementNode
		  name: array first
		  expressionList: array second ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> card: arg [

	^ ViennaSetCardinalityNode expression: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpression [

	^ super casesExpression ==> [ :triple |
	  ViennaCasesExpressionNode
		  expression: triple first
		  casesExpressionAlternatives: triple second
		  othersExpression: triple third ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternative [

	^ super casesExpressionAlternative ==> [ :pair |
	  ViennaCasesExpressionAlternativeNode
		  patternList: pair first
		  expression: pair second ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternatives [

	^ super casesExpressionAlternatives
	  ==> [ :array |
	  ViennaCasesExpressionAlternativesNode withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatement [

	^ super casesStatement ==> [ :array |
	  ViennaCasesStatementNode
		  expression: array first
		  casesStatementAlternatives: array second
		  othersStatement: array third ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatementAlternative [

	^ super casesStatementAlternative =>> [ :start :end :array |
	  (ViennaCasesStatementAlternativeNode
		   patternList: array first
		   statement: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatementAlternatives [

	^ super casesStatementAlternatives =>> [ :start :end :array |
	  (ViennaCasesStatementAlternativesNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> compositeType [

	^ super compositeType =>> [ :start :end :array |
	  (ViennaCompositeTypeNode name: array first fieldList: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> compositionExpression: expr1 and: expr2 [

	^ ViennaCompositionNode expression: expr1 expression: expr2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> conc: arg [

	^ ViennaDistributedSequenceConcatenationNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> concat: arg1 and: arg2 [

	^ ViennaSequenceConcatenateNode expression: arg1 expression: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> dclStatement [

	^ super dclStatement =>> [ :start :end :array |
	  (ViennaDclStatementNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> defExpression [

	^ super defExpression ==> [ :array |
	  ViennaDefExpressionNode
		  equalDefinitionList:
		  (ViennaEqualDefinitionListNode withAll: array first)
		  expression: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> defStatement [

	^ super defStatement ==> [ :pair |
	  ViennaDefStatementNode
		  equalDefinitionList: pair first
		  statement: pair second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> definitionBlock [

	^ super definitionBlock =>> [ :start :end :node |
	  (ViennaDefinitionBlockNode definition: node)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> diff: arg1 and: arg2 [

	^ ViennaSetDifferenceNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dinter: arg [

	^ ViennaDistributedSetIntersectionNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> div: arg1 and: arg2 [

	^ ViennaArithmeticIntegerDivisionNode
		  expression: arg1
		  expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> document [

	^ super document =>> [ :start :end :array |
	  (ViennaDocumentNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dom: arg [

	^ ViennaMapDomainNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dunion: arg [

	^ ViennaDistributedSetUnionNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> elems: arg [

	^ ViennaSequenceElementsNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equal: arg1 and: arg2 [

	^ ViennaEqualNode expression: arg1 expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinition [

	^ super equalDefinition =>> [ :start :end :array |
	  (ViennaEqualDefinitionNode
		   patternOrBind: array first
		   expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinitionList [

	^ super equalDefinitionList =>> [ :start :end :array |
	  (ViennaEqualDefinitionListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> equalityAbstractionField [
	^ super equalityAbstractionField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			{fieldName.
			true.
			fieldType} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equiv: arg1 and: arg2 [

	^ ViennaLogicalEquivalenceNode expression: arg1 expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> error [

	^ super error =>> [ :start :end :array |
	  (ViennaErrorNode
		   identifier: array first
		   expression: array second
		   expression: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> errorList [

	^ super errorList =>> [ :start :end :array |
	  (ViennaErrorListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> errorStatement [

	^ super errorStatement ==> [ :string | ViennaErrorStatementNode new ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> exceptions [

	^ super exceptions =>> [ :start :end :errorList |
	  (ViennaExceptionsNode errorList: errorList)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> exists1Expression [

	^ super exists1Expression ==> [ :array |
	  ViennaExists1ExpressionNode
		  bind: array first
		  expression: array second ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> existsExpression [

	^ super existsExpression ==> [ :array |
	  ViennaExistsExpressionNode
		  bindList: array first
		  expression: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> exitStatement [

	^ super exitStatement
	  ==> [ :expr | ViennaExitStatementNode expression: expr ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitFunctionDefinition [

	^ super explicitFunctionDefinition =>> [ :start :end :array |
	  (ViennaExplicitFunctionDefinitionNode
		   identifier: array first
		   typeVariableList: array second
		   type: array third
		   parametersList: array fifth
		   expression: array sixth
		   pre: array seventh
		   post: array eighth
		   measure: array ninth)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitOperationDefinition [

	^ super explicitOperationDefinition =>> [ :start :end :array |
	  (ViennaExplicitOperationDefinitionNode
		   identifier: array first
		   type: array second
		   parameters: array fourth
		   operationBody: array fifth
		   pre: array sixth
		   post: array seventh)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportDefinition [

	^ super exportDefinition =>> [ :start :end :moduleSignature |
	  (ViennaExportDefinitionNode exportModuleSignature: moduleSignature)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportFunctionsSignature [

	^ super exportFunctionsSignature =>> [ :start :end :array |
	  (ViennaExportFunctionsSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportModuleSignature [

	^ super exportModuleSignature =>> [ :start :end :array |
	  array = 'all'
		  ifTrue: [
			  ViennaExportModuleSignatureAllNode new
				  start: start end: end;
				  yourself ]
		  ifFalse: [
			  (ViennaExportModuleSignatureNode withAll: array)
				  start: start end: end;
				  yourself ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportOperationsSignature [

	^ super exportOperationsSignature =>> [ :start :end :array |
	  (ViennaExportOperationsSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportTypesSignature [

	^ super exportTypesSignature =>> [ :start :end :array |
	  (ViennaExportTypesSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportValuesSignature [

	^ super exportValuesSignature =>> [ :start :end :array |
	  (ViennaExportValuesSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions' }
ViennaVDMParser >> expression [
	^ super expression
		=>> [ :start :end :node | 
			node
				start: start end: end;
				yourself ]
]

{ #category : #'parsers-expressions' }
ViennaVDMParser >> expressionExceptEquality [
	^ super expressionExceptEquality
		=>> [ :start :end :node | 
			node
				start: start end: end;
				yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> expressionList [

	^ super expressionList
	  ==> [ :array | ViennaExpressionListNode withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> extendedExplicitFunctionDefinition [
	^ super extendedExplicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExtendedExplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> extendedExplicitOperationDefinition [
	^ super extendedExplicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExtendedExplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> externals [

	^ super externals =>> [ :start :end :array |
	  (ViennaExternalsNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> field [

	^ super field =>> [ :start :end :array |
	  (ViennaFieldNode
		   identifier: array first
		   equalityAbstraction: array second
		   type: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> fieldList [

	^ super fieldList =>> [ :start :end :array |
	  (ViennaFieldListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPattern [

	^ super fieldPattern =>> [ :start :end :array |
	  (ViennaFieldPatternNode
		   identifier: array first
		   pattern: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPatternList [

	^ super fieldPatternList =>> [ :start :end :array |
	  (ViennaFieldPatternListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> fieldReference: stateDesig with: field [

	^ ViennaFieldReferenceNode stateDesignator: stateDesig field: field
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> fieldSelect: record with: field [

	^ ViennaFieldSelectNode expression: record field: field
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> floor: arg [

	^ ViennaFloorNode expression: arg
]

{ #category : #annotations }
ViennaVDMParser >> flushAnnotations [

	| result |
	result := Array withAll: annotations.
	annotations removeAll.
	^ result
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> forallExpression [

	^ super forallExpression ==> [ :array |
	  ViennaForallExpressionNode
		  bindList: array first
		  expression: array second ]
]

{ #category : #parsing }
ViennaVDMParser >> format: aString [

	| ast |
	ast := self document end / self statement end / self expression end 
		       parse: aString.
	^ ast isPetit2Failure
		  ifTrue: [ ast ]
		  ifFalse: [ 
			  (self scanCommentsOn: aString)
				  inject: ast format
				  into: [ :source :posAndComment | 
					  posAndComment key
						  ifNil: [ posAndComment value , String cr , source ]
						  ifNotNil: [ 
							  | char count commentString index |
							  char := posAndComment key key.
							  count := posAndComment key value.
							  commentString := posAndComment value.
							  index := 0.
							  count timesRepeat: [ 
								  index := source indexOf: char startingAt: index + 1 ].
							  (source copyFrom: 1 to: index) , commentString
							  , (source copyFrom: index + 1 to: source size) ] ] ]
]

{ #category : #parsing }
ViennaVDMParser >> format: aString width: anInteger [

	| ast |
	ast := self parse: aString.
	^ ast isPetit2Failure
		  ifTrue: [ ast ]
		  ifFalse: [ 
			  (self scanCommentsOn: aString)
				  inject: (ast formatWidth: anInteger)
				  into: [ :source :posAndComment | 
					  posAndComment key
						  ifNil: [ posAndComment value , String cr , source ]
						  ifNotNil: [ 
							  | char count commentString index |
							  char := posAndComment key key.
							  count := posAndComment key value.
							  commentString := posAndComment value.
							  index := 0.
							  count timesRepeat: [ 
								  index := source indexOf: char startingAt: index + 1 ].
							  (source copyFrom: 1 to: index) , commentString
							  , (source copyFrom: index + 1 to: source size) ] ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> fraction: arg1 and: arg2 [

	^ ViennaArithmeticDivideNode expression: arg1 expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> functionDefinition [

	^ super functionDefinition =>> [ :start :end :body |
	  (ViennaFunctionDefinitionNode definition: body)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> functionDefinitions [
	^ super functionDefinitions
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionDefinitions'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionExport [

	^ super functionExport =>> [ :start :end :array |
	  (ViennaFunctionExportNode
		   nameList: array first
		   typeVariableList: array second
		   type: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionImport [

	^ super functionImport =>> [ :start :end :array |
	  (ViennaFunctionImportNode
		   name: array first
		   typeVariableList: array second
		   type: array third
		   rename: array fourth)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> functionTypeInstantiation: func args: args [

	^ ViennaFunctionTypeInstantiationNode
		  expression: func
		  functionTypeArgs: (ViennaFunctionTypeArgsNode withAll: args)
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greater: arg1 and: arg2 [

	^ ViennaGreaterThanNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greaterEq: arg1 and: arg2 [

	^ ViennaGreaterThanOrEqualNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> hd: arg [

	^ ViennaSequenceHeadNode expression: arg
]

{ #category : #'parsers-types' }
ViennaVDMParser >> identifiedField [
	^ super identifiedField
		==> [ :pair | 
			| fieldName fieldType |
			fieldName := pair first.
			fieldType := pair second.
			{fieldName.
			false.
			fieldType} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> identifierTypePairList [

	^ super identifierTypePairList =>> [ :start :end :array |
	  (ViennaIdentifierTypePairListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> identityStatement [

	^ super identityStatement =>> [ :start :end :ignore |
	  ViennaIdentityStatementNode new
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> ifExpression [

	^ super ifExpression ==> [ :array |
	  ViennaIfExpressionNode
		  conditionalExpressionList:
			  (ViennaConditionalExpressionListNode withAll:
				   (array first collect: [ :pair |
					    ViennaConditionalExpressionNode
						    condition: pair first
						    expression: pair second ]))
		  expression: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> ifStatement [

	^ super ifStatement =>> [ :start :end :array |
	  (ViennaIfStatementNode
		   conditionalStatementList:
			   (ViennaConditionalStatementListNode withAll:
					    (array first collect: [ :pair |
							     ViennaConditionalStatementNode
								     condition: pair first
								     statement: pair second ]))
		   statement: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> imp: arg1 and: arg2 [

	^ ViennaImplyNode expression: arg1 expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitFunctionDefinition [
	^ super implicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitOperationBody [

	^ super implicitOperationBody =>> [ :start :end :array |
	  (ViennaImplicitOperationBodyNode
		   externals: array first
		   pre: array second
		   post: array third
		   exceptions: array fourth)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitOperationDefinition [
	^ super implicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importDefinition [

	^ super importDefinition =>> [ :start :end :array |
	  (ViennaImportDefinitionNode
		   moduleIdentifier: array first
		   importModuleSignature: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importDefinitionList [

	^ super importDefinitionList =>> [ :start :end :array |
	  (ViennaImportDefinitionListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importFunctionsSignature [

	^ super importFunctionsSignature =>> [ :start :end :array |
	  (ViennaImportFunctionsSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importModuleSignature [

	^ super importModuleSignature =>> [ :start :end :array |
	  array = 'all'
		  ifTrue: [
			  ViennaImportModuleSignatureAllNode new
				  start: start end: end;
				  yourself ]
		  ifFalse: [
			  (ViennaImportModuleSignatureNode withAll: array)
				  start: start end: end;
				  yourself ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importOperationsSignature [

	^ super importOperationsSignature =>> [ :start :end :array |
	  (ViennaImportOperationsSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importTypesSignature [

	^ super importTypesSignature =>> [ :start :end :array |
	  (ViennaImportTypesSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importValuesSignature [

	^ super importValuesSignature =>> [ :start :end :array |
	  (ViennaImportValuesSignatureNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inSet: arg1 and: arg2 [

	^ ViennaInSetNode expression: arg1 expression: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> indexForLoop [

	^ super indexForLoop =>> [ :start :end :array |
	  (ViennaIndexForLoopNode
		   identifier: array first
		   startExpression: array second
		   endExpression: array third
		   stepExpression: array fourth
		   statement: array fifth)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inds: arg [

	^ ViennaSequenceIndicesNode expression: arg
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> initialisation [

	^ super initialisation =>> [ :start :end :invFunc |
	  (ViennaInitialisationNode invariantInitialFunction: invFunc)
		  start: start end: end;
		  yourself ]
]

{ #category : #initialization }
ViennaVDMParser >> initialize [

	super initialize.
	annotations := OrderedCollection new
]

{ #category : #'parsers-types' }
ViennaVDMParser >> inmapType [

	^ super inmapType =>> [ :start :end :array |
	  (ViennaInmapTypeNode
		   domainType: array first
		   rangeType: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inter: arg1 and: arg2 [

	^ ViennaSetIntersectionNode expression: arg1 expression: arg2
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> interface [

	^ super interface =>> [ :start :end :array |
	  (ViennaInterfaceNode
		   importDefinitionList: array first
		   exportDefinition: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> invariant [

	^ super invariant =>> [ :start :end :inv |
	  (ViennaInvariantNode invariantInitialFunction: inv)
		  start: start
		  end: end ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> invariantInitialFunction [

	^ super invariantInitialFunction =>> [ :start :end :array |
	  (ViennaInvariantInitialFunctionNode
		   pattern: array first
		   expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inverse: arg [

	^ ViennaMapInverseNode expression: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> iotaExpression [

	^ super iotaExpression ==> [ :array |
	  ViennaIotaExpressionNode bind: array first expression: array second ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isBasicExpression [

	^ super isBasicExpression ==> [ :array |
	  ViennaIsBasicExpressionNode
		  basicTypeName: array first
		  expression: array second ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isNameExpression [

	^ super isNameExpression ==> [ :array |
	  ViennaIsNameExpressionNode
		  name: array first
		  expression: array second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> isNotYetSpecified [

	^ super isNotYetSpecified =>> [ :start :end :ignore |
	  ViennaIsNotYetSpecifiedNode new
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> iterateExpression: expr1 and: expr2 [

	^ ViennaIterateNode expression: expr1 expression: expr2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> lambdaExpression [

	^ super lambdaExpression ==> [ :array |
	  ViennaLambdaExpressionNode
		  typeBindList: array first
		  expression: array second ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> len: arg [

	^ ViennaSequenceLengthNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> less: arg1 and: arg2 [

	^ ViennaLessThanNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> lessEq: arg1 and: arg2 [

	^ ViennaLessThanOrEqualNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letBeExpression [

	^ super letBeExpression ==> [ :array |
	  ViennaLetBeExpressionNode
		  multipleBind: array first
		  conditionExpression: array second
		  expression: array third ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> letBeStatement [

	^ super letBeStatement =>> [ :start :end :array |
	  (ViennaLetBeStatementNode
		   multipleBind: array first
		   conditionExpression: array second
		   statement: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letExpression [

	^ super letExpression ==> [ :array |
	  ViennaLetExpressionNode
		  localDefinitionList: array first
		  expression: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> letStatement [

	^ super letStatement =>> [ :start :end :pair |
	  (ViennaLetStatementNode
		   localDefinitionList: pair first
		   statement: pair second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinition [

	^ super localDefinition =>> [ :start :end :def |
	  (ViennaLocalDefinitionNode valueDefinitionOrFunctionDefinition: def)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinitionList [

	^ super localDefinitionList =>> [ :start :end :array |
	  (ViennaLocalDefinitionListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedBy: arg2 [

	^ ViennaMapDomainRestrictedByNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedTo: arg2 [

	^ ViennaMapDomainRestrictedToNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedBy: arg2 [

	^ ViennaMapRangeRestrictedByNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedTo: arg2 [

	^ ViennaMapRangeRestrictedToNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapComprehension [

	^ super mapComprehension ==> [ :array |
	  ViennaMapComprehensionNode
		  keyExpression: array first
		  valueExpression: array second
		  bindList: array third
		  suchthatExpression: array fourth ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapEnumeration [

	^ super mapEnumeration
	  ==> [ :array | ViennaMapEnumerationNode withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapEnumerationPattern [

	^ super mapEnumerationPattern =>> [ :start :end :array |
	  (ViennaMapEnumerationPatternNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapMunionPattern [

	^ super mapMunionPattern =>> [ :start :end :array |
	  (ViennaMapMunionPatternNode
		   pattern: array first
		   pattern: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> mapOrSequenceReference: stateDesig with: expr [

	^ ViennaMapOrSequenceReferenceNode
		  expression: stateDesig
		  argumentExpression: expr
]

{ #category : #'parsers-types' }
ViennaVDMParser >> mapType [

	^ super mapType =>> [ :start :end :array |
	  (ViennaMapTypeNode domainType: array first rangeType: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> maplet [

	^ super maplet ==> [ :array |
	  ViennaMapletNode
		  keyExpression: array first
		  valueExpression: array second ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapletList [

	^ super mapletList
	  ==> [ :array | ViennaMapletListNode withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapletPattern [

	^ super mapletPattern =>> [ :start :end :array |
	  (ViennaMapletPatternNode
		   keyPattern: array first
		   valuePattern: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> matchValue [

	^ super matchValue =>> [ :start :end :ast |
	  (ViennaMatchValueNode expression: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mconcat: arg1 and: arg2 [

	^ ViennaMapOrSequenceModifyNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> merge: arg [

	^ ViennaDistributedMapMergeNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> minus: arg1 and: arg2 [

	^ ViennaArithmeticMinusNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mod: arg1 and: arg2 [

	^ ViennaArithmeticModNode expression: arg1 expression: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> module [

	^ super module =>> [ :start :end :array |
	  (ViennaModuleNode
		   identifier: array first
		   interface: array second
		   moduleBody: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> moduleBody [

	^ super moduleBody =>> [ :start :end :array |
	  (ViennaModuleBodyNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mul: arg1 and: arg2 [

	^ ViennaArithmeticMultiplicationNode
		  expression: arg1
		  expression: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> multipleAssignStatement [

	^ super multipleAssignStatement =>> [ :start :end :array |
	  (ViennaMultipleAssignStatementNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSeqBind [

	^ super multipleSeqBind =>> [ :start :end :array |
	  (ViennaMultipleSeqBindNode
		   patternList: array first
		   expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSetBind [

	^ super multipleSetBind =>> [ :start :end :array |
	  (ViennaMultipleSetBindNode
		   patternList: array first
		   expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleTypeBind [

	^ super multipleTypeBind =>> [ :start :end :array |
	  (ViennaMultipleTypeBindNode
		   patternList: array first
		   type: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> munion: arg1 and: arg2 [

	^ ViennaMapMergeNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> name [

	^ super name ==> [ :array |
	  array isString
		  ifTrue: [ ViennaLocalNameNode identifier: array ]
		  ifFalse: [
			  ViennaGlobalNameNode
				  moduleIdentifier: array first
				  identifier: array second ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> nameList [

	^ super nameList =>> [ :start :end :array |
	  (ViennaNameListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> nondeterministicStatement [

	^ super nondeterministicStatement =>> [ :start :end :array |
	  (ViennaNondeterministicStatementNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> not: arg [

	^ ViennaNotNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notEqual: arg1 and: arg2 [

	^ ViennaNotEqualNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notInSet: arg1 and: arg2 [

	^ ViennaNotInSetNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> oldName [

	^ super oldName
	  ==> [ :string | ViennaOldNameNode identifier: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationBody [

	^ super operationBody =>> [ :start :end :body |
	  (ViennaOperationBodyNode statementOrIsNotYetSpecified: body)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationDefinition [

	^ super operationDefinition =>> [ :start :end :def |
	  (ViennaOperationDefinitionNode definition: def)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationDefinitions [
	^ super operationDefinitions
		=>> [ :start :end :array | 
			ViennaNode
				label: 'OperationDefinitions'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationExport [

	^ super operationExport =>> [ :start :end :array |
	  (ViennaOperationExportNode
		   nameList: array first
		   type: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationImport [

	^ super operationImport =>> [ :start :end :array |
	  (ViennaOperationImportNode
		   name: array first
		   type: array second
		   rename: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> operationType [

	^ super operationType =>> [ :start :end :array |
	  (ViennaOperationTypeNode
		   argumentType: array first
		   returnType: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> optionalType [

	^ super optionalType =>> [ :start :end :ast |
	  (ViennaOptionalTypeNode type: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> or: arg1 and: arg2 [

	^ ViennaOrNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> othersExpression [

	^ super othersExpression
	  ==> [ :expr | ViennaOthersExpressionNode expression: expr ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> othersStatement [

	^ super othersStatement =>> [ :start :end :bodyStatement |
	  (ViennaOthersStatementNode statement: bodyStatement)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameterTypes [

	^ super parameterTypes =>> [ :start :end :n |
	  (ViennaParameterTypesNode patternTypePairList: n)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameters [

	^ super parameters =>> [ :start :end :array |
	  (ViennaParametersNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parametersList [

	^ super parametersList =>> [ :start :end :array |
	  (ViennaParametersListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> partialFunctionType [

	^ super partialFunctionType =>> [ :start :end :array |
	  (ViennaPartialFunctionTypeNode
		   argumentType: array first
		   returnType: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternIdentifier [

	^ super patternIdentifier =>> [ :start :end :stringOrNil |
	  (ViennaPatternIdentifierNode identifier: stringOrNil)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternList [

	^ super patternList =>> [ :start :end :array |
	  (ViennaPatternListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> patternTypePairList [

	^ super patternTypePairList =>> [ :start :end :array |
	  (ViennaPatternTypePairListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> plus: arg1 and: arg2 [

	^ ViennaArithmeticPlusNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> power: arg [

	^ ViennaFinitePowerSetNode expression: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> preconditionExpression [

	^ super preconditionExpression
	  ==> [ :array | ViennaPreconditionExpressionNode withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> productType [

	^ super productType =>> [ :start :end :array |
	  (ViennaProductTypeNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> psubset: arg1 and: arg2 [

	^ ViennaProperSubsetNode expression: arg1 expression: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> quoteType [

	^ super quoteType =>> [ :start :end :string |
	  (ViennaQuoteTypeNode string: string)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> recordConstructor [

	^ super recordConstructor ==> [ :array |
	  ViennaRecordConstructorNode
		  name: array first
		  expressionList: array second ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> recordModifier [

	^ super recordModifier ==> [ :array |
	  ViennaRecordModifierNode
		  expression: array first
		  mapletList: array second ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> recordPattern [

	^ super recordPattern =>> [ :start :end :array |
	  (ViennaRecordPatternNode
		   name: array first
		   patternList: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> recordTypeDefinition [
	^ super recordTypeDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'RecordTypeDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> rem: arg1 and: arg2 [

	^ ViennaArithmeticRemNode expression: arg1 expression: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> resultExpression [

	^ super resultExpression
	  ==> [ :array | ViennaResultExpressionNode new ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> returnStatement [

	^ super returnStatement =>> [ :start :end :expr |
	  (ViennaReturnStatementNode expression: expr)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> reverse: arg [

	^ ViennaSequenceReverseNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> rng: arg [

	^ ViennaMapRangeNode expression: arg
]

{ #category : #parsing }
ViennaVDMParser >> scanCommentsOn: aStream [
	| sourceStream source |
	sourceStream := aStream asPetit2Stream.
	source := sourceStream contents.
	^ Array
		new: 16
		streamContents: [ :comments | 
			(self textLiteral / self characterLiteral
				/
					(super singleLineAnnotation trim not, comment ==> #second
						>=> [ :commentStream :continuation | 
							| commentString position |
							position := commentStream position.
							commentString := continuation value.
							commentString isPetit2Failure
								ifTrue: [ commentString ]
								ifFalse: [ | guard |
									[ position > 0 and: [ (source at: position) isSeparator ] ]
										whileTrue: [ position := position - 1 ].
									guard := position > 0
										ifTrue: [ | char |
											char := source at: position.
											char
												-> ((source copyFrom: 1 to: position) occurrencesOf: char) ].
									comments nextPut: guard -> commentString ] ]) / #any asPParser)
				starA end parse: sourceStream ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seq1Type [

	^ super seq1Type =>> [ :start :end :ast |
	  (ViennaSeq1TypeNode type: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqBind [

	^ super seqBind =>> [ :start :end :array |
	  (ViennaSeqBindNode pattern: array first expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqConcPattern [

	^ super seqConcPattern =>> [ :start :end :array |
	  (ViennaSeqConcPatternNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqEnumPattern [

	^ super seqEnumPattern =>> [ :start :end :array |
	  (ViennaSeqEnumPatternNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seqType [

	^ super seqType =>> [ :start :end :ast |
	  (ViennaSeqTypeNode type: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> sequenceComprehension [

	^ super sequenceComprehension ==> [ :array |
	  ViennaSequenceComprehensionNode
		  expression: array first
		  setSeqBind: array second
		  suchthatExpression: array third ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> sequenceEnumeration [

	^ super sequenceEnumeration
	  ==> [ :array | ViennaSequenceEnumerationNode expressionList: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> sequenceForLoop [

	^ super sequenceForLoop =>> [ :start :end :array |
	  (ViennaSequenceForLoopNode
		   patternOrBind: array first
		   expression: array second
		   statement: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> set1Type [

	^ super set1Type =>> [ :start :end :ast |
	  (ViennaSet1TypeNode type: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setBind [

	^ super setBind =>> [ :start :end :array |
	  (ViennaSetBindNode pattern: array first expression: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setComprehension [

	^ super setComprehension ==> [ :array |
	  ViennaSetComprehensionNode
		  expression: array first
		  bindList: array second
		  suchthatExpression: array third ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setEnumPattern [

	^ super setEnumPattern =>> [ :start :end :array |
	  (ViennaSetEnumPatternNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setEnumeration [

	^ super setEnumeration
	  ==> [ :array | ViennaSetEnumerationNode expressionList: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> setForLoop [

	^ super setForLoop =>> [ :start :end :array |
	  (ViennaSetForLoopNode
		   pattern: array first
		   expression: array second
		   statement: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setRangeExpression [

	^ super setRangeExpression ==> [ :array |
	  ViennaSetRangeExpressionNode
		  startExpression: array first
		  endExpression: array second ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> setType [

	^ super setType =>> [ :start :end :ast |
	  (ViennaSetTypeNode type: ast)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setUnionPattern [

	^ super setUnionPattern =>> [ :start :end :array |
	  (ViennaSetUnionPatternNode
		   pattern: array first
		   pattern: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-comments' }
ViennaVDMParser >> singleLineAnnotation [

	^ super singleLineAnnotation
	  ==> [ :string | self addAnnotation: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> stateDefinition [

	^ super stateDefinition =>> [ :start :end :array | 
	  ViennaNode
		  label: 'StateDefinition'
		  start: start
		  end: end
		  withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateField [

	^ super field =>> [ :start :end :array |
	  (ViennaFieldNode
		   identifier: array first
		   equalityAbstraction: array second
		   type: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateFieldList [

	^ super stateFieldList =>> [ :start :end :array |
	  (ViennaFieldListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> subsequence: sequence from: start to: end [

	^ ViennaSubsequenceNode
		  sequenceExpression: sequence
		  startExpression: start
		  endExpression: end
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> subset: arg1 and: arg2 [

	^ ViennaSubsetNode expression: arg1 expression: arg2
]

{ #category : #'parsers-literals' }
ViennaVDMParser >> symbolicLiteral [

	^ super symbolicLiteral flatten =>> [ :start :end :string |
	  (ViennaSymbolicLiteralNode string: string trim)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> tixeStatement [

	^ super tixeStatement =>> [ :start :end :pair |
	  (ViennaTixeStatementNode traps: pair first statement: pair second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> tl: arg [

	^ ViennaSequenceTailNode expression: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> tokenConstructor [

	^ super tokenConstructor
	  ==> [ :array | ViennaTokenConstructorNode expression: array first ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> totalFunctionType [

	^ super totalFunctionType =>> [ :start :end :array |
	  (ViennaTotalFunctionTypeNode
		   argumentType: array first
		   returnType: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> trapStatement [

	^ super trapStatement =>> [ :start :end :triple |
	  (ViennaTrapStatementNode
		   pattern: triple first
		   handlerStatement: triple second
		   statement: triple third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> traps [

	^ super traps =>> [ :start :end :array |
	  (ViennaTrapsNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> tupleConstructor [

	^ super tupleConstructor ==> [ :array |
	  ViennaTupleConstructorNode expressionList:
		  (ViennaExpressionListNode withAll: array) ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> tuplePattern [

	^ super tuplePattern =>> [ :start :end :array |
	  (ViennaTuplePatternNode patternList:
			   (ViennaPatternListNode withAll: array))
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> tupleSelect: tuple with: index [

	^ ViennaTupleSelectNode expression: tuple index: index
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBind [

	^ super typeBind =>> [ :start :end :array |
	  (ViennaTypeBindNode pattern: array first type: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBindList [

	^ super typeBindList =>> [ :start :end :array |
	  (ViennaTypeBindListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeDefinitions [
	^ super typeDefinitions
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeDefinitions'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> typeExport [

	^ super typeExport =>> [ :start :end :array |
	  array first isNil
		  ifTrue: [
			  (ViennaTypeNameExportNode name: array second)
				  start: start end: end;
				  yourself ]
		  ifFalse: [
			  (ViennaTypeStructExportNode name: array second)
				  start: start end: end;
				  yourself ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> typeImport [

	^ super typeImport =>> [ :start :end :array |
	  (ViennaTypeImportNode typeName: array first rename: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> typeJudgement [

	^ super typeJudgement ==> [ :array |
	  ViennaTypeJudgementNode expression: array first type: array second ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> typeName [

	^ super typeName =>> [ :start :end :array |
	  (ViennaTypeNameNode name: (array isString
				    ifTrue: [
					    (ViennaLocalNameNode identifier: array)
						    start: start end: end;
						    yourself ]
				    ifFalse: [
					    (ViennaGlobalNameNode
						     moduleIdentifier: array first
						     identifier: array second)
						    start: start end: end;
						    yourself ]))
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeSynonym [
	^ super typeSynonym
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeSynonym'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariable [

	^ super typeVariable =>> [ :start :end :string |
	  (ViennaTypeVariableNode string: string)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableIdentifier [

	^ super typeVariableIdentifier =>> [ :start :end :string |
	  (ViennaTypeVariableIdentifierNode string: string)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableList [

	^ super typeVariableList =>> [ :start :end :array |
	  (ViennaTypeVariableListNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> unaryMinus: arg [

	^ ViennaUnaryMinusNode expression: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> unaryPlus: arg [

	^ ViennaUnaryPlusNode expression: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> undefinedExpression [

	^ super undefinedExpression
	  ==> [ :array | ViennaUndefinedExpressionNode new ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> union: arg1 and: arg2 [

	^ ViennaSetUnionNode expression: arg1 expression: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unionType [

	^ super unionType =>> [ :start :end :array |
	  (ViennaUnionTypeNode withAll: array)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unitType [

	^ super unitType =>> [ :start :end :ignore |
	  ViennaUnitTypeNode new
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> valueDefinition [
	^ super valueDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> valueDefinitions [
	^ super valueDefinitions
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueDefinitions'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valueExport [

	^ super valueExport =>> [ :start :end :array |
	  (ViennaValueExportNode nameList: array first type: array second)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valueImport [

	^ super valueImport =>> [ :start :end :array |
	  (ViennaValueImportNode
		   name: array first
		   type: array second
		   rename: array third)
		  start: start end: end;
		  yourself ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> varInformation [
	^ super varInformation
		=>> [ :start :end :array | 
			ViennaNode
				label: 'VarInformation'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> whileLoop [

	^ super whileLoop =>> [ :start :end :pair |
	  (ViennaWhileLoopNode expression: pair first statement: pair second)
		  start: start end: end;
		  yourself ]
]

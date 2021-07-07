Class {
	#name : #ViennaVDMParser,
	#superclass : #ViennaVDMGrammar,
	#category : #'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> abs: arg [
	^ ViennaNode label: 'ArithmeticAbs' with: arg
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
	^ super accessFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessFunctionDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessOperationDefinition [
	^ super accessOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessOperationDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessTypeDefinition [
	^ super accessTypeDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessTypeDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> accessValueDefinition [
	^ super accessValueDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AccessValueDefinition'
				start: start
				end: end
				with: (ViennaNode label: 'Access' withAll: array first)
				with: array second ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> actExpression [
	^ super actExpression
		=>> [ :start :end :nameNode | 
			ViennaNode
				label: 'ActExpression'
				start: start
				end: end
				with: nameNode ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> activeExpression [
	^ super activeExpression
		=>> [ :start :end :nameNode | 
			ViennaNode
				label: 'ActiveExpression'
				start: start
				end: end
				with: nameNode ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> alwaysStatement [
	^ super alwaysStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'AlwaysStatement'
				start: start
				end: end
				withAll: pair ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> and: arg1 and: arg2 [
	^ ViennaNode label: 'And' with: arg1 with: arg2
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
	^ ViennaNode label: 'Apply' with: func with: args
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> assignStatement [
	^ super assignStatement ==> [ :pair | ViennaNode label: 'AssignStatement' withAll: pair ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> assignmentDefinition [
	^ super assignmentDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'AssignmentDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> basicType [
	^ super basicType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'BasicType'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> bindList [
	^ super bindList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'BindList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> blockStatement [
	^ super blockStatement ==> [ :array | ViennaNode label: 'BlockStatement' withAll: array first , array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> callStatement [
	^ super callStatement ==> [ :array | ViennaNode label: 'CallStatement' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> card: arg [
	^ ViennaNode label: 'SetCardinality' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpression [
	^ super casesExpression ==> [ :array | ViennaNode label: 'CasesExpression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternative [
	^ super casesExpressionAlternative ==> [ :array | ViennaNode label: 'CasesExpressionAlternative' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternatives [
	^ super casesExpressionAlternatives ==> [ :array | ViennaNode label: 'CasesExpressionAlternatives' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatement [
	^ super casesStatement ==> [ :array | ViennaNode label: 'CasesStatement' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatementAlternative [
	^ super casesStatementAlternative
		=>> [ :start :end :array | 
			ViennaNode
				label: 'CasesStatementAlternative'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatementAlternatives [
	^ super casesStatementAlternatives
		=>> [ :start :end :array | 
			ViennaNode
				label: 'CasesStatementAlternatives'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> compositeType [
	^ super compositeType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'CompositeType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> compositionExpression: expr1 and: expr2 [
	^ ViennaNode label: 'Composition' with: expr1 with: expr2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> conc: arg [
	^ ViennaNode label: 'DistributedSequenceConcatenation' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> concat: arg1 and: arg2 [
	^ ViennaNode label: 'SequenceConcatenate' with: arg1 with: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> dclStatement [
	^ super dclStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'DclStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> defExpression [
	^ super defExpression
		==> [ :array | 
			ViennaNode
				label: 'DefExpression'
				with: (ViennaNode label: 'EqualDefinitionList' withAll: array first)
				with: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> defStatement [
	^ super defStatement ==> [ :array | ViennaNode label: 'DefStatement' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> definitionBlock [
	^ super definitionBlock
		=>> [ :start :end :array | 
			ViennaNode
				label: 'DefinitionBlock'
				start: start
				end: end
				with: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> diff: arg1 and: arg2 [
	^ ViennaNode label: 'SetDifference' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dinter: arg [
	^ ViennaNode label: 'DistributedSetIntersection' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> div: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticIntegerDivision' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> document [
	^ super document
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Document'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dom: arg [
	^ ViennaNode label: 'MapDomain' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dunion: arg [
	^ ViennaNode label: 'DistributedSetUnion' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> elems: arg [
	^ ViennaNode label: 'SequenceElements' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> elseifExpression [
	^ super elseifExpression ==> [ :array | ViennaNode label: 'ElseifExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> elseifStatement [
	^ super elseifStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ElseifStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equal: arg1 and: arg2 [
	^ ViennaNode label: 'Equal' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinition [
	^ super equalDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'EqualDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinitionList [
	^ super equalDefinitionList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'EqualDefinitionList'
				start: start
				end: end
				withAll: array ]
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
	^ ViennaNode label: 'LogicalEquivalence' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> error [
	^ super error
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Error'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> errorList [
	^ super errorList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ErrorList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> errorStatement [
	^ super errorStatement ==> [ :string | ViennaNode label: 'ErrorStatement' ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> exceptions [
	^ super exceptions
		=>> [ :start :end :errorList | 
			ViennaNode
				label: 'Exceptions'
				start: start
				end: end
				with: errorList ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> exists1Expression [
	^ super exists1Expression ==> [ :array | ViennaNode label: 'Exists1Expression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> existsExpression [
	^ super existsExpression ==> [ :array | ViennaNode label: 'ExistsExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> exitStatement [
	^ super exitStatement ==> [ :expr | ViennaNode label: 'ExitStatement' with: expr ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitFunctionDefinition [
	^ super explicitFunctionDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExplicitFunctionDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitOperationDefinition [
	^ super explicitOperationDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExplicitOperationDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportDefinition [
	^ super exportDefinition
		=>> [ :start :end :moduleSignature | 
			ViennaNode
				label: 'ExportDefinition'
				start: start
				end: end
				with: moduleSignature ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportFunctionsSignature [
	^ super exportFunctionsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExportFunctionsSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportModuleSignature [
	^ super exportModuleSignature
		=>> [ :start :end :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ExportModuleSignatureAll' start: start end: end ]
				ifFalse: [ ViennaNode
						label: 'ExportModuleSignature'
						start: start
						end: end
						withAll: array ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportOperationsSignature [
	^ super exportOperationsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExportOperationsSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportTypesSignature [
	^ super exportTypesSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExportTypesSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportValuesSignature [
	^ super exportValuesSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ExportValuesSignature'
				start: start
				end: end
				withAll: array ]
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
	^ super expressionList ==> [ :array | ViennaNode label: 'ExpressionList' withAll: array ]
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
	^ super externals
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Externals'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> field [
	^ super field
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Field'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> fieldList [
	^ super fieldList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPattern [
	^ super fieldPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPatternList [
	^ super fieldPatternList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldPatternList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> fieldReference: stateDesig with: field [
	^ ViennaNode label: 'FieldReference' with: stateDesig with: field
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> fieldSelect: record with: field [
	^ ViennaNode label: 'FieldSelect' with: record with: field
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> finExpression [
	^ super finExpression ==> [ :nameNode | ViennaNode label: 'FinExpression' with: nameNode ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> floor: arg [
	^ ViennaNode label: 'Floor' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> forallExpression [
	^ super forallExpression ==> [ :array | ViennaNode label: 'ForallExpression' withAll: array ]
]

{ #category : #parsing }
ViennaVDMParser >> format: aString [
	| ast |
	ast := self document end / self statement end / self expression end parse: aString.
	^ ast isPetit2Failure
		ifTrue: [ ast ]
		ifFalse: [ (self scanCommentsOn: aString)
				inject: ast format
				into: [ :source :posAndComment | 
					posAndComment key
						ifNil: [ posAndComment value , String cr , source ]
						ifNotNil: [ | char count commentString index |
							char := posAndComment key key.
							count := posAndComment key value.
							commentString := posAndComment value.
							index := 0.
							count timesRepeat: [ index := source indexOf: char startingAt: index + 1 ].
							(source copyFrom: 1 to: index) , commentString
								, (source copyFrom: index + 1 to: source size) ] ] ]
]

{ #category : #parsing }
ViennaVDMParser >> format: aString width: anInteger [
	| ast |
	ast := self parse: aString.
	^ ast isPetit2Failure
		ifTrue: [ ast ]
		ifFalse: [ (self scanCommentsOn: aString)
				inject: (ast formatWidth: anInteger)
				into: [ :source :posAndComment | 
					posAndComment key
						ifNil: [ posAndComment value , String cr , source ]
						ifNotNil: [ | char count commentString index |
							char := posAndComment key key.
							count := posAndComment key value.
							commentString := posAndComment value.
							index := 0.
							count timesRepeat: [ index := source indexOf: char startingAt: index + 1 ].
							(source copyFrom: 1 to: index) , commentString
								, (source copyFrom: index + 1 to: source size) ] ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> fraction: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticDivide' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> functionDefinition [
	^ super functionDefinition
		=>> [ :start :end :body | 
			ViennaNode
				label: 'FunctionDefinition'
				start: start
				end: end
				with: body ]
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
	^ super functionExport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionExport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionImport [
	^ super functionImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FunctionImport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> functionTypeInstantiation: func args: args [
	^ ViennaNode label: 'FunctionTypeInstantiation' with: func with: (ViennaNode label: 'FunctionTypeArgs' withAll: args)
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greater: arg1 and: arg2 [
	^ ViennaNode label: 'GreaterThan' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greaterEq: arg1 and: arg2 [
	^ ViennaNode label: 'GreaterThanOrEqual' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> hd: arg [
	^ ViennaNode label: 'SequenceHead' with: arg
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
ViennaVDMParser >> identifierTypePair [
	^ super identifierTypePair
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'IdentifierTypePair'
				start: start
				end: end
				withAll: pair ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> identifierTypePairList [
	^ super identifierTypePairList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IdentifierTypePairList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> identityStatement [
	^ super identityStatement
		=>> [ :start :end :ignore | ViennaNode label: 'IdentityStatement' start: start end: end ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> ifExpression [
	^ super ifExpression
		==> [ :array | 
			ViennaNode
				label: 'IfExpression'
				with:
					(ViennaNode
						label: 'ConditionaExpressionList'
						withAll: (array first collect: [ :pair | ViennaNode label: 'ConditionalExpression' withAll: pair ]))
				with: array second ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> ifStatement [
	^ super ifStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IfStatement'
				start: start
				end: end
				with:
					(ViennaNode
						label: 'ConditionaStatementList'
						withAll: (array first collect: [ :pair | ViennaNode label: 'ConditionalStatement' withAll: pair ]))
				with: array second ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> imp: arg1 and: arg2 [
	^ ViennaNode label: 'Imply' with: arg1 with: arg2
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
	^ super implicitOperationBody
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImplicitOperationBody'
				start: start
				end: end
				withAll: array ]
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
	^ super importDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importDefinitionList [
	^ super importDefinitionList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportDefinitionList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importFunctionsSignature [
	^ super importFunctionsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportFunctionsSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importModuleSignature [
	^ super importModuleSignature
		=>> [ :start :end :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ImportModuleSignatureAll' start: start end: end ]
				ifFalse: [ ViennaNode
						label: 'ImportModuleSignature'
						start: start
						end: end
						withAll: array ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importOperationsSignature [
	^ super importOperationsSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportOperationsSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importTypesSignature [
	^ super importTypesSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportTypesSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importValuesSignature [
	^ super importValuesSignature
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ImportValuesSignature'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inSet: arg1 and: arg2 [
	^ ViennaNode label: 'InSet' with: arg1 with: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> indexForLoop [
	^ super indexForLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'IndexForLoop'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inds: arg [
	^ ViennaNode label: 'SequenceIndices' with: arg
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> initialisation [
	^ super initialisation
		=>> [ :start :end :invFunc | 
			ViennaNode
				label: 'Initialisation'
				start: start
				end: end
				with: invFunc ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> inmapType [
	^ super inmapType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'InmapType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inter: arg1 and: arg2 [
	^ ViennaNode label: 'SetIntersection' with: arg1 with: arg2
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> interface [
	^ super interface
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Interface'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> invariant [
	^ super invariant
		=>> [ :start :end :inv | 
			ViennaNode
				label: 'Invariant'
				start: start
				end: end
				with: inv ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> invariantInitialFunction [
	^ super invariantInitialFunction
		=>> [ :start :end :array | 
			ViennaNode
				label: 'InvariantInitialFunction'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inverse: arg [
	^ ViennaNode label: 'MapInverse' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> iotaExpression [
	^ super iotaExpression ==> [ :array | ViennaNode label: 'IotaExpression' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isBasicExpression [
	^ super isBasicExpression ==> [ :array | ViennaNode label: 'IsBasicExpression' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isNameExpression [
	^ super isNameExpression ==> [ :array | ViennaNode label: 'IsNameExpression' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> isNotYetSpecified [
	^ super isNotYetSpecified
		=>> [ :start :end :ignore | ViennaNode label: 'IsNotYetSpecified' start: start end: end ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> isSubclassResponsibility [
	^ super isSubclassResponsibility
		=>>
			[ :start :end :ignore | ViennaNode label: 'IsSubclassResponsibility' start: start end: end ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isofbaseclassExpression [
	^ super isofbaseclassExpression ==> [ :array | ViennaNode label: 'IsofbaseclassExpression' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> isofclassExpression [
	^ super isofclassExpression ==> [ :array | ViennaNode label: 'IsofclassExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> iterateExpression: expr1 and: expr2 [
	^ ViennaNode label: 'Iterate' with: expr1 with: expr2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> lambdaExpression [
	^ super lambdaExpression ==> [ :array | ViennaNode label: 'LambdaExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> len: arg [
	^ ViennaNode label: 'SequenceLength' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> less: arg1 and: arg2 [
	^ ViennaNode label: 'LessThan' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> lessEq: arg1 and: arg2 [
	^ ViennaNode label: 'LessThanOrEqual' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letBeExpression [
	^ super letBeExpression ==> [ :array | ViennaNode label: 'LetBeExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> letBeStatement [
	^ super letBeStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'LetBeStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letExpression [
	^ super letExpression ==> [ :array | ViennaNode label: 'LetExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> letStatement [
	^ super letStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'LetStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinition [
	^ super localDefinition
		=>> [ :start :end :def | 
			ViennaNode
				label: 'LocalDefinition'
				start: start
				end: end
				with: def ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinitionList [
	^ super localDefinitionList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'LocalDefinitionList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedBy: arg2 [
	^ ViennaNode label: 'MapDomainRestrictedBy' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedTo: arg2 [
	^ ViennaNode label: 'MapDomainRestrictedTo' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedBy: arg2 [
	^ ViennaNode label: 'MapRangeRestrictedBy' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedTo: arg2 [
	^ ViennaNode label: 'MapRangeRestrictedTo' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapComprehension [
	^ super mapComprehension ==> [ :array | ViennaNode label: 'MapComprehension' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapEnumeration [
	^ super mapEnumeration ==> [ :array | ViennaNode label: 'MapEnumeration' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapEnumerationPattern [
	^ super mapEnumerationPattern
		=>> [:start :end :array | 
			ViennaNode
				label: 'MapEnumerationPattern'
				 start: start end: end 
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapMunionPattern [
	^ super mapMunionPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapMunionPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> mapOrSequenceReference: stateDesig with: expr [
	^ ViennaNode label: 'MapOrSequenceReference' with: stateDesig with: expr
]

{ #category : #'parsers-types' }
ViennaVDMParser >> mapType [
	^ super mapType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> maplet [
	^ super maplet ==> [ :array | ViennaNode label: 'Maplet' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> mapletList [
	^ super mapletList ==> [ :array | ViennaNode label: 'MapletList' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapletPattern [
	^ super mapletPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MapletPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> matchValue [
	^ super matchValue
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'MatchValue'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mconcat: arg1 and: arg2 [
	^ ViennaNode label: 'MapOrSequenceModify' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> merge: arg [
	^ ViennaNode label: 'DistributedMapMerge' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> minus: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticMinus' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mod: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticMod' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> module [
	^ super module
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Module'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> moduleBody [
	^ super moduleBody
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ModuleBody'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mul: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticMultiplication' with: arg1 with: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> multipleAssignStatement [
	^ super multipleAssignStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleAssignStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSeqBind [
	^ super multipleSeqBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleSeqBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSetBind [
	^ super multipleSetBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleSetBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleTypeBind [
	^ super multipleTypeBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'MultipleTypeBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> munion: arg1 and: arg2 [
	^ ViennaNode label: 'MapMerge' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> name [
	^ super name
		==> [ :array | 
			array isString
				ifTrue: [ ViennaNode label: 'LocalName' with: array ]
				ifFalse: [ ViennaNode label: 'GlobalName' withAll: array ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> nameList [
	^ super nameList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'NameList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> narrowExpression [
	^ super narrowExpression ==> [ :array | ViennaNode label: 'NarrowExpression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> newExpression [
	^ super newExpression ==> [ :array | ViennaNode label: 'NewExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> nondeterministicStatement [
	^ super nondeterministicStatement
		=>> [ :start :end :array | 
			ViennaNode
				label: 'NondeterministicStatement'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> not: arg [
	^ ViennaNode label: 'Not' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notEqual: arg1 and: arg2 [
	^ ViennaNode label: 'NotEqual' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notInSet: arg1 and: arg2 [
	^ ViennaNode label: 'NotInSet' with: arg1 with: arg2
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> objectPattern [
	^ super objectPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ObjectPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> oldName [
	^ super oldName ==> [ :string | ViennaNode label: 'OldName' with: (string copyFrom: 1 to: string size - 1) ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationBody [
	^ super operationBody
		=>> [ :start :end :body | 
			ViennaNode
				label: 'OperationBody'
				start: start
				end: end
				with: body ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationDefinition [
	^ super operationDefinition
		=>> [ :start :end :def | 
			ViennaNode
				label: 'OperationDefinition'
				start: start
				end: end
				with: def ]
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
	^ super operationExport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'OperationExport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationImport [
	^ super operationImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'OperationImport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> operationType [
	^ super operationType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'OperationType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> optionalType [
	^ super optionalType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'OptionalType'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> or: arg1 and: arg2 [
	^ ViennaNode label: 'Or' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> othersExpression [
	^ super othersExpression ==> [ :expr | ViennaNode label: 'OthersExpression' with: expr ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> othersStatement [
	^ super othersStatement
		=>> [ :start :end :bodyStatement | 
			ViennaNode
				label: 'OthersStatement'
				start: start
				end: end
				with: bodyStatement ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameterTypes [
	^ super parameterTypes
		=>> [ :start :end :n | 
			ViennaNode
				label: 'ParameterTypes'
				start: start
				end: end
				with: n ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameters [
	^ super parameters
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Parameters'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parametersList [
	^ super parametersList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ParametersList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> partialFunctionType [
	^ super partialFunctionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PartialFunctionType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternIdentifier [
	^ super patternIdentifier
		=>> [ :start :end :stringOrNil | 
			ViennaNode
				label: 'PatternIdentifier'
				start: start
				end: end
				with: stringOrNil ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternList [
	^ super patternList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PatternList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> patternTypePairList [
	^ super patternTypePairList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'PatternTypePairList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> plus: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticPlus' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> power: arg [
	^ ViennaNode label: 'FinitePowerSet' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> preconditionExpression [
	^ super preconditionExpression ==> [ :array | ViennaNode label: 'PreconditionExpression' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> productType [
	^ super productType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ProductType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> psubset: arg1 and: arg2 [
	^ ViennaNode label: 'ProperSubset' with: arg1 with: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> quoteType [
	^ super quoteType
		=>> [ :start :end :string | 
			ViennaNode
				label: 'QuoteType'
				start: start
				end: end
				with: string ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> recordConstructor [
	^ super recordConstructor ==> [ :array | ViennaNode label: 'RecordConstructor' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> recordModifier [
	^ super recordModifier ==> [ :array | ViennaNode label: 'RecordModifier' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> recordPattern [
	^ super recordPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'RecordPattern'
				start: start
				end: end
				withAll: array ]
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
	^ ViennaNode label: 'ArithmeticRem' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> reqExpression [
	^ super reqExpression ==> [ :nameNode | ViennaNode label: 'ReqExpression' with: nameNode ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> resultExpression [
	^ super resultExpression ==> [ :array | ViennaNode label: 'ResultExpression' ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> returnStatement [
	^ super returnStatement
		=>> [ :start :end :expr | 
			ViennaNode
				label: 'ReturnStatement'
				start: start
				end: end
				with: expr ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> reverse: arg [
	^ ViennaNode label: 'SequenceReverse' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> rng: arg [
	^ ViennaNode label: 'MapRange' with: arg
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> samebaseclassExpression [
	^ super samebaseclassExpression ==> [ :array | ViennaNode label: 'SamebaseclassExpression' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> sameclassExpression [
	^ super sameclassExpression ==> [ :array | ViennaNode label: 'SameclassExpression' withAll: array ]
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
					(comment
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

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> selfExpression [
	^ super selfExpression ==> [ :array | ViennaNode label: 'SelfExpression' ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seq1Type [
	^ super seq1Type
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'Seq1Type'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqBind [
	^ super seqBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqConcPattern [
	^ super seqConcPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqConcPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqEnumPattern [
	^ super seqEnumPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SeqEnumPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seqType [
	^ super seqType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'SeqType'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> sequenceComprehension [
	^ super sequenceComprehension ==> [ :array | ViennaNode label: 'SequenceComprehension' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :array | ViennaNode label: 'SequenceEnumeration' with: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> sequenceForLoop [
	^ super sequenceForLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SequenceForLoop'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> set1Type [
	^ super set1Type
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'Set1Type'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setBind [
	^ super setBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setComprehension [
	^ super setComprehension ==> [ :array | ViennaNode label: 'SetComprehension' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setEnumPattern [
	^ super setEnumPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetEnumPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setEnumeration [
	^ super setEnumeration ==> [ :array | ViennaNode label: 'SetEnumeration' with: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> setForLoop [
	^ super setForLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetForLoop'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setRangeExpression [
	^ super setRangeExpression ==> [ :array | ViennaNode label: 'SetRangeExpression' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> setType [
	^ super setType
		=>> [ :start :end :ast | 
			ViennaNode
				label: 'SetType'
				start: start
				end: end
				with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setUnionPattern [
	^ super setUnionPattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'SetUnionPattern'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> stateDefinition [
	^ super stateDefinition
		=>> [ :start :end :array | 
			ViennaNode
				label: 'StateDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateField [
	^ super field
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Field'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateFieldList [
	^ super stateFieldList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'FieldList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> subsequence: sequence from: start to: end [
	^ ViennaNode
		label: 'Subsequence'
		with: sequence
		with: start
		with: end
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> subset: arg1 and: arg2 [
	^ ViennaNode label: 'Subset' with: arg1 with: arg2
]

{ #category : #'parsers-literals' }
ViennaVDMParser >> symbolicLiteral [
	^ super symbolicLiteral flatten
		=>> [ :start :end :string | 
			ViennaNode
				label: 'SymbolicLiteral'
				start: start
				end: end
				with: string trim ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> threadidExpression [
	^ super threadidExpression ==> [ :string | ViennaNode label: 'ThreadidExpression' ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> timeExpression [
	^ super timeExpression ==> [ :string | ViennaNode label: 'TimeExpression' ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> tixeStatement [
	^ super tixeStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'TixeStatement'
				start: start
				end: end
				withAll: pair ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> tl: arg [
	^ ViennaNode label: 'SequenceTail' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> tokenConstructor [
	^ super tokenConstructor ==> [ :array | ViennaNode label: 'TokenConstructor' with: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> totalFunctionType [
	^ super totalFunctionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TotalFunctionType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> trapStatement [
	^ super trapStatement
		=>> [ :start :end :pair | 
			ViennaNode
				label: 'TrapStatement'
				start: start
				end: end
				withAll: pair ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> traps [
	^ super traps
		=>> [ :start :end :array | 
			ViennaNode
				label: 'Traps'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> tupleConstructor [
	^ super tupleConstructor ==> [ :array | ViennaNode label: 'TupleConstructor' with: (ViennaNode label: 'ExpressionList' withAll: array) ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> tuplePattern [
	^ super tuplePattern
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TuplePattern'
				start: start
				end: end
				with: (ViennaNode label: 'PatternList' withAll: array) ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> tupleSelect: tuple with: index [
	^ ViennaNode label: 'TupleSelect' with: tuple with: index
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBind [
	^ super typeBind
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeBind'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBindList [
	^ super typeBindList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeBindList'
				start: start
				end: end
				withAll: array ]
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
	^ super typeExport
		=>> [ :start :end :array | 
			array first isNil
				ifTrue: [ ViennaNode
						label: 'TypeNameExport'
						start: start
						end: end
						with: array second ]
				ifFalse: [ ViennaNode
						label: 'TypeStructExport'
						start: start
						end: end
						with: array second ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> typeImport [
	^ super typeImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeImport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> typeJudgement [
	^ super typeJudgement ==> [ :array | ViennaNode label: 'TypeJudgement' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> typeName [
	^ super typeName
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeName'
				start: start
				end: end
				with:
					(array isString
						ifTrue: [ ViennaNode
								label: 'LocalName'
								start: start
								end: end
								with: array ]
						ifFalse: [ ViennaNode
								label: 'GlobalName'
								start: start
								end: end
								withAll: array ]) ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeSynonym [
	^ super typeSynonym
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeDefinition'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariable [
	^ super typeVariable
		=>> [ :start :end :string | 
			ViennaNode
				label: 'TypeVariable'
				start: start
				end: end
				with: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableIdentifier [
	^ super typeVariableIdentifier
		=>> [ :start :end :string | 
			ViennaNode
				label: 'TypeVariableIdentifier'
				start: start
				end: end
				with: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableList [
	^ super typeVariableList
		=>> [ :start :end :array | 
			ViennaNode
				label: 'TypeVariableList'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> unaryMinus: arg [
	^ ViennaNode label: 'UnaryMinus' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> unaryPlus: arg [
	^ ViennaNode label: 'UnaryPlus' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> undefinedExpression [
	^ super undefinedExpression ==> [ :array | ViennaNode label: 'UndefinedExpression' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> union: arg1 and: arg2 [
	^ ViennaNode label: 'SetUnion' with: arg1 with: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unionType [
	^ super unionType
		=>> [ :start :end :array | 
			ViennaNode
				label: 'UnionType'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unitType [
	^ super unitType
		=>> [ :start :end :ignore | ViennaNode label: 'UnitType' start: start end: end ]
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
	^ super valueExport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueExport'
				start: start
				end: end
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valueImport [
	^ super valueImport
		=>> [ :start :end :array | 
			ViennaNode
				label: 'ValueImport'
				start: start
				end: end
				withAll: array ]
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

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> waitingExpression [
	^ super waitingExpression ==> [ :nameNode | ViennaNode label: 'WaitingExpression' with: nameNode ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> whileLoop [
	^ super whileLoop
		=>> [ :start :end :array | 
			ViennaNode
				label: 'WhileLoop'
				start: start
				end: end
				withAll: array ]
]

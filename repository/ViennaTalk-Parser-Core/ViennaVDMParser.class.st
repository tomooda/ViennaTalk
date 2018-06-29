Class {
	#name : #ViennaVDMParser,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Parser-Core'
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
		==> [ :array | ViennaNode label: 'AccessValueDefinition' with: (ViennaNode label: 'Access' withAll: array first) with: array second ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> actExpression [
	^ super actExpression ==> [ :nameNode | ViennaNode label: 'ActExpression' with: nameNode ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> activeExpression [
	^ super activeExpression ==> [ :nameNode | ViennaNode label: 'ActiveExpression' with: nameNode ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> and: arg1 and: arg2 [
	^ ViennaNode label: 'And' with: arg1 with: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> anonymousField [
	^ super anonymousField
		==> [ :typeNode | 
			{nil.
			false.
			typeNode} ]
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
	^ super assignmentDefinition ==> [ :array | ViennaNode label: 'AssignmentDefinition' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> basicType [
	^ super basicType ==> [ :ast | ViennaNode label: 'BasicType' with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> bindList [
	^ super bindList ==> [ :array | ViennaNode label: 'BindList' withAll: array ]
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
	^ super casesStatementAlternative ==> [ :array | ViennaNode label: 'CasesStatementAlternative' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> casesStatementAlternatives [
	^ super casesStatementAlternatives ==> [ :array | ViennaNode label: 'CasesStatementAlternatives' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> compositeType [
	^ super compositeType ==> [ :array | ViennaNode label: 'CompositeType' withAll: array ]
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
	^ super dclStatement ==> [ :array | ViennaNode label: 'DclStatement' withAll: array ]
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
	^ super definitionBlock ==> [ :array | ViennaNode label: 'DefinitionBlock' with: array ]
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
	^ super document ==> [ :array | ViennaNode label: 'Document' withAll: array ]
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
	^ super elseifStatement ==> [ :array | ViennaNode label: 'ElseifStatement' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equal: arg1 and: arg2 [
	^ ViennaNode label: 'Equal' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinition [
	^ super equalDefinition ==> [ :array | ViennaNode label: 'EqualDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> equalDefinitionList [
	^ super equalDefinitionList ==> [ :array | ViennaNode label: 'EqualDefinitionList' withAll: array ]
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
	^ super error ==> [ :array | ViennaNode label: 'Error' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> errorList [
	^ super errorList ==> [ :array | ViennaNode label: 'ErrorList' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> exceptions [
	^ super exceptions ==> [ :errorList | ViennaNode label: 'Exceptions' with: errorList ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> exists1Expression [
	^ super exists1Expression ==> [ :array | ViennaNode label: 'Exists1Expression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> existsExpression [
	^ super existsExpression ==> [ :array | ViennaNode label: 'ExistsExpression' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitFunctionDefinition [
	^ super explicitFunctionDefinition ==> [ :array | ViennaNode label: 'ExplicitFunctionDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> explicitOperationDefinition [
	^ super explicitOperationDefinition ==> [ :array | ViennaNode label: 'ExplicitOperationDefinition' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportDefinition [
	^ super exportDefinition ==> [ :moduleSignature | ViennaNode label: 'ExportDefinition' with: moduleSignature ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportFunctionsSignature [
	^ super exportFunctionsSignature ==> [ :array | ViennaNode label: 'ExportFunctionsSignature' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportModuleSignature [
	^ super exportModuleSignature
		==> [ :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ExportModuleSignatrueAll' ]
				ifFalse: [ ViennaNode label: 'ExportModuleSignature' withAll: array ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> exportTypesSignature [
	^ super exportTypesSignature ==> [ :array | ViennaNode label: 'ExportTypesSignature' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> expressionList [
	^ super expressionList ==> [ :array | ViennaNode label: 'ExpressionList' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> extendedExplicitFunctionDefinition [
	^ super extendedExplicitFunctionDefinition
		==> [ :array | ViennaNode label: 'ExtendedExplicitFunctionDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> extendedExplicitOperationDefinition [
	^ super extendedExplicitOperationDefinition
		==> [ :array | ViennaNode label: 'ExtendedExplicitOperationDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> externals [
	^ super externals ==> [ :array | ViennaNode label: 'Externals' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> field [
	^ super field ==> [ :array | ViennaNode label: 'Field' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> fieldList [
	^ super fieldList ==> [ :array | ViennaNode label: 'FieldList' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPattern [
	^ super fieldPattern ==> [ :array | ViennaNode label: 'FieldPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPatternList [
	^ super fieldPatternList ==> [ :array | ViennaNode label: 'FieldPatternList' withAll: array ]
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
	^ ast isPetitFailure
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
	^ ast isPetitFailure
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
	^ super functionDefinition ==> [ :body | ViennaNode label: 'FunctionDefinition' with: body ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> functionDefinitions [
	^ super functionDefinitions ==> [ :array | ViennaNode label: 'FunctionDefinitions' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionExport [
	^ super functionExport ==> [ :array | ViennaNode label: 'FunctionExport' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionImport [
	^ super functionImport
		==> [ :array | 
			ViennaNode
				label: 'FunctionImport'
				withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionSignature [
	^ super functionSignature ==> [ :array | ViennaNode label: 'FunctionSignature' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> functionTypeInstantiation: func args: args [
	^ ViennaNode label: 'FunctionTypeInstantiation' with: func with: (ViennaNode label: 'FunctionTypeArgs' withAll: args)
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> functionsSignature [
	^ super functionsSignature ==> [ :array | ViennaNode label: 'FunctionsSignature' withAll: array ]
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
		==> [ :pair | ViennaNode label: 'IdentifierTypePair' withAll: pair ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> identifierTypePairList [
	^ super identifierTypePairList
		==> [ :array | ViennaNode label: 'IdentifierTypePairList' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> identityStatement [
	^ super identityStatement ==> [ :ignore | ViennaNode label: 'IdentityStatement' ]
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
		==> [ :array | 
			ViennaNode
				label: 'IfStatement'
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
	^ super implicitFunctionDefinition ==> [ :array | ViennaNode label: 'ImplicitFunctionDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitOperationBody [
	^ super implicitOperationBody ==> [ :array | ViennaNode label: 'ImplicitOperationBody' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitOperationDefinition [
	^ super implicitOperationDefinition ==> [ :array | ViennaNode label: 'ImplicitOperationDefinition' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importDefinition [
	^ super importDefinition ==> [ :array | ViennaNode label: 'ImportDefinition' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importDefinitionList [
	^ super importDefinitionList ==> [ :array | ViennaNode label: 'ImportDefinitionList' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importFunctionsSignature [
	^ super importFunctionsSignature ==> [ :array | ViennaNode label: 'ImportFunctionsSignature' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importModuleSignature [
	^ super importModuleSignature
		==> [ :array | 
			array = 'all'
				ifTrue: [ ViennaNode label: 'ImportModuleSignatureAll' ]
				ifFalse: [ ViennaNode label: 'ImportModuleSignature' withAll: array ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importOperationsSignature [
	^ super importOperationsSignature ==> [ :array | ViennaNode label: 'ImportOperationsSignature' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importTypesSignature [
	^ super importTypesSignature ==> [ :array | ViennaNode label: 'ImportTypesSignature' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> importValuesSignature [
	^ super importValuesSignature ==> [ :array | ViennaNode label: 'ImportValuesSignature' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inSet: arg1 and: arg2 [
	^ ViennaNode label: 'InSet' with: arg1 with: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> indexForLoop [
	^ super indexForLoop ==> [ :array | ViennaNode label: 'IndexForLoop' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inds: arg [
	^ ViennaNode label: 'SequenceIndices' with: arg
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> initialisation [
	^ super initialisation ==> [ :invFunc | ViennaNode label: 'Initialisation' with: invFunc ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> inmapType [
	^ super inmapType ==> [ :array | ViennaNode label: 'InmapType' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inter: arg1 and: arg2 [
	^ ViennaNode label: 'SetIntersection' with: arg1 with: arg2
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> interface [
	^ super interface ==> [ :array | ViennaNode label: 'Interface' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> invariant [
	^ super invariant ==> [ :inv | ViennaNode label: 'Invariant' with: inv ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> invariantInitialFunction [
	^ super invariantInitialFunction ==> [ :array | ViennaNode label: 'InvariantInitialFunction' withAll: array ]
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
	^ super isNotYetSpecified ==> [ :ignore | ViennaNode label: 'IsNotYetSpecified' ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> isSubclassResponsibility [
	^ super isSubclassResponsibility ==> [ :ignore | ViennaNode label: 'IsSubclassResponsibility' ]
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
	^ super letBeStatement ==> [ :array | ViennaNode label: 'LetBeStatement' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letExpression [
	^ super letExpression ==> [ :array | ViennaNode label: 'LetExpression' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> letStatement [
	^ super letStatement ==> [ :array | ViennaNode label: 'LetStatement' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinition [
	^ super localDefinition ==> [ :def | ViennaNode label: 'LocalDefinition' with: def ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> localDefinitionList [
	^ super localDefinitionList ==> [ :array | ViennaNode label: 'LocalDefinitionList' withAll: array ]
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
	^ super mapEnumerationPattern ==> [ :array | ViennaNode label: 'MapEnumerationPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapMunionPattern [
	^ super mapMunionPattern ==> [ :array | ViennaNode label: 'MapMunionPattern' withAll: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> mapOrSequenceReference: stateDesig with: expr [
	^ ViennaNode label: 'MapOrSequenceReference' with: stateDesig with: expr
]

{ #category : #'parsers-types' }
ViennaVDMParser >> mapType [
	^ super mapType ==> [ :array | ViennaNode label: 'MapType' withAll: array ]
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
	^ super mapletPattern ==> [ :array | ViennaNode label: 'MapletPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> matchValue [
	^ super matchValue ==> [ :ast | ViennaNode label: 'MatchValue' with: ast ]
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
	^ super module ==> [ :array | ViennaNode label: 'Module' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> moduleBody [
	^ super moduleBody ==> [ :array | ViennaNode label: 'ModuleBody' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mul: arg1 and: arg2 [
	^ ViennaNode label: 'ArithmeticMultiplication' with: arg1 with: arg2
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> multipleAssignStatement [
	^ super multipleAssignStatement ==> [ :array | ViennaNode label: 'MultipleAssignStatement' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSeqBind [
	^ super multipleSeqBind ==> [ :array | ViennaNode label: 'MultipleSeqBind' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleSetBind [
	^ super multipleSetBind ==> [ :array | ViennaNode label: 'MultipleSetBind' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> multipleTypeBind [
	^ super multipleTypeBind ==> [ :array | ViennaNode label: 'MultipleTypeBind' withAll: array ]
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
	^ super nameList ==> [ :array | ViennaNode label: 'NameList' withAll: array ]
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
	^ super nondeterministicStatement ==> [ :array | ViennaNode label: 'NondeterministicStatement' withAll: array ]
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
	^ super objectPattern ==> [ :array | ViennaNode label: 'ObjectPattern' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> oldName [
	^ super oldName ==> [ :string | ViennaNode label: 'OldName' with: (string copyFrom: 1 to: string size - 1) ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationBody [
	^ super operationBody ==> [ :body | ViennaNode label: 'OperationBody' with: body ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationDefinition [
	^ super operationDefinition ==> [ :def | ViennaNode label: 'OperationDefinition' with: def ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> operationDefinitions [
	^ super operationDefinitions ==> [ :array | ViennaNode label: 'OperationDefinitions' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationImport [
	^ super operationImport ==> [ :array | ViennaNode label: 'OperationImport' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationSignature [
	^ super operationSignature ==> [ :array | ViennaNode label: 'OperationSignature' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> operationType [
	^ super operationType ==> [ :array | ViennaNode label: 'OperationType' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> operationsSignature [
	^ super operationsSignature ==> [ :array | ViennaNode label: 'OperationsSignature' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> optionalType [
	^ super optionalType ==> [ :ast | ViennaNode label: 'OptionalType' with: ast ]
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
	^ super othersStatement ==> [ :bodyStatement | ViennaNode label: 'OthersStatement' with: bodyStatement ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameterTypes [
	^ super parameterTypes ==> [ :n | ViennaNode label: 'ParameterTypes' with: n ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parameters [
	^ super parameters ==> [ :array | ViennaNode label: 'Parameters' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> parametersList [
	^ super parametersList ==> [ :array | ViennaNode label: 'ParametersList' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> partialFunctionType [
	^ super partialFunctionType ==> [ :array | ViennaNode label: 'PartialFunctionType' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternIdentifier [
	^ super patternIdentifier ==> [ :stringOrNil | ViennaNode label: 'PatternIdentifier' with: stringOrNil ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> patternList [
	^ super patternList ==> [ :array | ViennaNode label: 'PatternList' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> patternTypePairList [
	^ super patternTypePairList
		==> [ :array | ViennaNode label: 'PatternTypePairList' withAll: array ]
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
	^ super productType ==> [ :array | ViennaNode label: 'ProductType' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> psubset: arg1 and: arg2 [
	^ ViennaNode label: 'ProperSubset' with: arg1 with: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> quoteType [
	^ super quoteType ==> [ :string | ViennaNode label: 'QuoteType' with: string ]
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
	^ super recordPattern ==> [ :array | ViennaNode label: 'RecordPattern' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> recordTypeDefinition [
	^ super recordTypeDefinition ==> [ :array | ViennaNode label: 'RecordTypeDefinition' withAll: array ]
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
	^ super returnStatement ==> [ :expr | ViennaNode label: 'ReturnStatement' with: expr ]
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
	sourceStream := aStream asPetitStream.
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
							commentString isPetitFailure
								ifTrue: [ commentString ]
								ifFalse: [ 
									| guard |
									[ position > 0 and: [ (source at: position) isSeparator ] ] whileTrue: [ position := position - 1 ].
									guard := position > 0
										ifTrue: [ 
											| char |
											char := source at: position.
											char -> ((source copyFrom: 1 to: position) occurrencesOf: char) ].
									comments nextPut: guard -> commentString ] ]) / #any asParser) star end parse: sourceStream ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> selfExpression [
	^ super selfExpression ==> [ :array | ViennaNode label: 'SelfExpression' ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seq1Type [
	^ super seq1Type ==> [ :ast | ViennaNode label: 'Seq1Type' with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqBind [
	^ super seqBind ==> [ :array | ViennaNode label: 'SeqBind' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqConcPattern [
	^ super seqConcPattern ==> [ :array | ViennaNode label: 'SeqConcPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqEnumPattern [
	^ super seqEnumPattern ==> [ :array | ViennaNode label: 'SeqEnumPattern' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> seqType [
	^ super seqType ==> [ :ast | ViennaNode label: 'SeqType' with: ast ]
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
	^ super sequenceForLoop ==> [ :array | ViennaNode label: 'SequenceForLoop' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> set1Type [
	^ super set1Type ==> [ :ast | ViennaNode label: 'Set1Type' with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setBind [
	^ super setBind ==> [ :array | ViennaNode label: 'SetBind' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setComprehension [
	^ super setComprehension ==> [ :array | ViennaNode label: 'SetComprehension' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setEnumPattern [
	^ super setEnumPattern ==> [ :array | ViennaNode label: 'SetEnumPattern' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setEnumeration [
	^ super setEnumeration ==> [ :array | ViennaNode label: 'SetEnumeration' with: array ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> setForLoop [
	^ super setForLoop ==> [ :array | ViennaNode label: 'SetForLoop' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setRangeExpression [
	^ super setRangeExpression ==> [ :array | ViennaNode label: 'SetRangeExpression' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> setType [
	^ super setType ==> [ :ast | ViennaNode label: 'SetType' with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> setUnionPattern [
	^ super setUnionPattern ==> [ :array | ViennaNode label: 'SetUnionPattern' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> stateDefinition [
	^ super stateDefinition ==> [ :array | ViennaNode label: 'StateDefinition' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateField [
	^ super field ==> [ :array | ViennaNode label: 'Field' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> stateFieldList [
	^ super stateFieldList ==> [ :array | ViennaNode label: 'FieldList' withAll: array ]
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
	^ super symbolicLiteral flatten ==> [ :string | ViennaNode label: 'SymbolicLiteral' with: string trim ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> threadidExpression [
	^ super threadidExpression ==> [ :string | ViennaNode label: 'ThreadidExpression' ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> timeExpression [
	^ super timeExpression ==> [ :string | ViennaNode label: 'TimeExpression' ]
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
	^ super totalFunctionType ==> [ :array | ViennaNode label: 'TotalFunctionType' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> tupleConstructor [
	^ super tupleConstructor ==> [ :array | ViennaNode label: 'TupleConstructor' with: (ViennaNode label: 'ExpressionList' withAll: array) ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> tuplePattern [
	^ super tuplePattern ==> [ :array | ViennaNode label: 'TuplePattern' with: (ViennaNode label: 'PatternList' withAll: array) ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> tupleSelect: tuple with: index [
	^ ViennaNode label: 'TupleSelect' with: tuple with: index
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBind [
	^ super typeBind ==> [ :array | ViennaNode label: 'TypeBind' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> typeBindList [
	^ super typeBindList ==> [ :array | ViennaNode label: 'TypeBindList' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeDefinitions [
	^ super typeDefinitions ==> [ :array | ViennaNode label: 'TypeDefinitions' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> typeExport [
	^ super typeExport
		==> [ :array | 
			array first isNil
				ifTrue: [ ViennaNode label: 'TypeNameExport' with: array second  ]
				ifFalse: [ ViennaNode label: 'TypeStructExport' with: array second  ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> typeImport [
	^ super typeImport ==> [ :array | ViennaNode label: 'TypeImport' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> typeJudgement [
	^ super typeJudgement ==> [ :array | ViennaNode label: 'TypeJudgement' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> typeName [
	^ super typeName
		==> [ :array | 
			ViennaNode
				label: 'TypeName'
				with:
					(array isString
						ifTrue: [ ViennaNode label: 'LocalName' with: array ]
						ifFalse: [ ViennaNode label: 'GlobalName' withAll: array ]) ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeSynonym [
	^ super typeSynonym ==> [ :array | ViennaNode label: 'TypeDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariable [
	^ super typeVariable ==> [ :string | ViennaNode label: 'TypeVariable' with: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableIdentifier [
	^ super typeVariableIdentifier ==> [ :string | ViennaNode label: 'TypeVariableIdentifier' with: string ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> typeVariableList [
	^ super typeVariableList ==> [ :array | ViennaNode label: 'TypeVariableList' withAll: array ]
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
	^ super unionType ==> [ :array | ViennaNode label: 'UnionType' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unitType [
	^ super unitType ==> [ :ignore | ViennaNode label: 'UnitType' ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> valueDefinition [
	^ super valueDefinition ==> [ :array | ViennaNode label: 'ValueDefinition' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> valueDefinitions [
	^ super valueDefinitions ==> [ :array | ViennaNode label: 'ValueDefinitions' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valueImport [
	^ super valueImport ==> [ :array | ViennaNode label: 'ValueImport' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valueSignature [
	^ super valueSignature ==> [ :array | ViennaNode label: 'ValueSignature' withAll: array ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMParser >> valuesSignature [
	^ super valuesSignature ==> [ :array | ViennaNode label: 'ValuesSignature' withAll: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> varInformation [
	^ super varInformation ==> [ :array | ViennaNode label: 'VarInformation' withAll: array ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> waitingExpression [
	^ super waitingExpression ==> [ :nameNode | ViennaNode label: 'WaitingExpression' with: nameNode ]
]

{ #category : #'parsers-statements' }
ViennaVDMParser >> whileLoop [
	^ super whileLoop ==> [ :array | ViennaNode label: 'WhileLoop' withAll: array ]
]

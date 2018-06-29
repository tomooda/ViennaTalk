Class {
	#name : #ViennaVDMParser,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> abs: arg [
	^ ViennaNode label: 'AbsoluteValue' with: arg
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

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> apply: func args: args [
	^ ViennaNode label: 'Apply' with: func with: args
]

{ #category : #'parsers-types' }
ViennaVDMParser >> basicType [
	^ super basicType ==> [ :ast | ViennaNode label: 'BasicType' with: ast ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> bindList [
	^ super bindList ==> [ :array | ViennaNode label: 'BindList' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> card: arg [
	^ ViennaNode label: 'Card' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpression [
	^ super casesExpression ==> [ :array | ViennaNode label: 'CasesExpression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternative [
	^ super casesExpressionAlternative ==> [ :array | ViennaNode label: 'CaseExpressionAlternative' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> casesExpressionAlternatives [
	^ super casesExpressionAlternatives ==> [ :array | ViennaNode label: 'CaseExpressionAlternatives' withAll: array ]
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
	^ ViennaNode label: 'DistributedConcatenation' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> concat: arg1 and: arg2 [
	^ ViennaNode label: 'Concatenation' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> defExpression [
	^ super defExpression ==> [ :array | ViennaNode label: 'DefExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> diff: arg1 and: arg2 [
	^ ViennaNode label: 'SetDifference' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dinter: arg [
	^ ViennaNode label: 'DistributedIntersection' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> div: arg1 and: arg2 [
	^ ViennaNode label: 'IntegerDivision' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dom: arg [
	^ ViennaNode label: 'Domain' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> dunion: arg [
	^ ViennaNode label: 'DistributedUnion' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> elems: arg [
	^ ViennaNode label: 'Elements' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equal: arg1 and: arg2 [
	^ ViennaNode label: 'Equality' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> equiv: arg1 and: arg2 [
	^ ViennaNode label: 'Biimplication' with: arg1 with: arg2
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
ViennaVDMParser >> extendedExplicitFunctionDefinition [
	^ super extendedExplicitFunctionDefinition
		==> [ :array | ViennaNode label: 'ExtendedExplicitFunctionDefinition' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPattern [
	^ super fieldPattern ==> [ :array | ViennaNode label: 'FieldPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> fieldPatternList [
	^ super fieldPattern ==> [ :array | ViennaNode label: 'FieldPatternList' withAll: array ]
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

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> fraction: arg1 and: arg2 [
	^ ViennaNode label: 'Division' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> functionTypeInstantiation: func args: args [
	^ ViennaNode label: 'FunctionTypeInstantiation' with: func with: args
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greater: arg1 and: arg2 [
	^ ViennaNode label: 'GreaterThan' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> greaterEq: arg1 and: arg2 [
	^ ViennaNode label: 'GreaterOrEqual' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> hd: arg [
	^ ViennaNode label: 'Head' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> ifExpression [
	^ super ifExpression ==> [ :array | ViennaNode label: 'IfExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> imp: arg1 and: arg2 [
	^ ViennaNode label: 'Implication' with: arg1 with: arg2
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> implicitFunctionDefinition [
	^ super implicitFunctionDefinition ==> [ :array | ViennaNode label: 'ImplicitFunctionDefinition' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inSet: arg1 and: arg2 [
	^ ViennaNode label: 'Membership' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inds: arg [
	^ ViennaNode label: 'Indexes' with: arg
]

{ #category : #'parsers-types' }
ViennaVDMParser >> inmapType [
	^ super inmapType ==> [ :array | ViennaNode label: 'InmapType' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> inter: arg1 and: arg2 [
	^ ViennaNode label: 'Intersection' with: arg1 with: arg2
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
	^ ViennaNode label: 'IterateExpression' with: expr1 with: expr2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> lambdaExpression [
	^ super lambdaExpression ==> [ :array | ViennaNode label: 'LambdaExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> len: arg [
	^ ViennaNode label: 'Length' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> less: arg1 and: arg2 [
	^ ViennaNode label: 'LessThan' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> lessEq: arg1 and: arg2 [
	^ ViennaNode label: 'LessOrEqual' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letBeExpression [
	^ super letBeExpression ==> [ :array | ViennaNode label: 'LetBeExpression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> letExpression [
	^ super letExpression ==> [ :array | ViennaNode label: 'LetExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedBy: arg2 [
	^ ViennaNode label: 'DomainRestrictedBy' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 domainRestrictedTo: arg2 [
	^ ViennaNode label: 'DomainRestrictedTo' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedBy: arg2 [
	^ ViennaNode label: 'RangeRestrictedBy' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> map: arg1 rangeRestrictedTo: arg2 [
	^ ViennaNode label: 'RangeRestrictedTo' with: arg1 with: arg2
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
	^ super mapEnumerationPattern ==> [ :array | ViennaNode label: 'MapEnumerationPattern' with: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> mapMunionPattern [
	^ super mapMunionPattern ==> [ :array | ViennaNode label: 'MapMunionPattern' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> mapType [
	^ super mapType ==> [ :array | ViennaNode label: 'MapType' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> maplet [
	^ super maplet ==> [ :array | ViennaNode label: 'Maplet' withAll: array ]
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
	^ ViennaNode label: 'Override' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> merge: arg [
	^ ViennaNode label: 'DistributedMerge' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> minus: arg1 and: arg2 [
	^ ViennaNode label: 'Difference' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mod: arg1 and: arg2 [
	^ ViennaNode label: 'Modulus' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> mul: arg1 and: arg2 [
	^ ViennaNode label: 'Product' with: arg1 with: arg2
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
	^ ViennaNode label: 'Merge' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> name [
	^ super name
		==> [ :array | 
			array isString
				ifTrue: [ ViennaNode label: 'LocalName' with: array ]
				ifFalse: [ ViennaNode label: 'GlobalName' withAll: array ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> narrowExpression [
	^ super narrowExpression ==> [ :array | ViennaNode label: 'NarrowExpression' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> newExpression [
	^ super newExpression ==> [ :array | ViennaNode label: 'NewExpression' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> not: arg [
	^ ViennaNode label: 'Negation' with: arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notEqual: arg1 and: arg2 [
	^ ViennaNode label: 'Inequality' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> notInSet: arg1 and: arg2 [
	^ ViennaNode label: 'NotMembership' with: arg1 with: arg2
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> objectPattern [
	^ super objectPattern ==> [ :array | ViennaNode label: 'ObjectPattern' withAll: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> oldName [
	^ super oldName ==> [ :string | ViennaNode label: 'OldName' with: (string copyFrom: 1 to: string size - 1) ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> optionalType [
	^ super optionalType ==> [ :ast | ViennaNode label: 'OptionalType' with: ast ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> or: arg1 and: arg2 [
	^ ViennaNode label: 'Disjunction' with: arg1 with: arg2
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

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> plus: arg1 and: arg2 [
	^ ViennaNode label: 'Sum' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> power: arg [
	^ ViennaNode label: 'PowerSet' with: arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> preconditionExpression [
	^ super preconditionExpression ==> [ :array | ViennaNode label: 'PreconditionExpression' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> productType [
	^ super productType ==> [ :array | ViennaNode label: 'ProductType' with: array ]
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
ViennaVDMParser >> recordModifier [
	^ super recordModifier ==> [ :array | ViennaNode label: 'RecordModifier' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> recordPattern [
	^ super recordPattern ==> [ :array | ViennaNode label: 'RecordPattern' withAll: array ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> rem: arg1 and: arg2 [
	^ ViennaNode label: 'Remainder' with: arg1 with: arg2
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> reqExpression [
	^ super reqExpression ==> [ :nameNode | ViennaNode label: 'ReqExpression' with: nameNode ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> resultExpression [
	^ super recordModifier ==> [ :array | ViennaNode label: 'ResultExpression' ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMParser >> rng: arg [
	^ ViennaNode label: 'Range' with: arg
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> samebaseclassExpression [
	^ super samebaseclassExpression ==> [ :array | ViennaNode label: 'SamebaseclassExpression' withAll: array ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> sameclassExpression [
	^ super sameclassExpression ==> [ :array | ViennaNode label: 'SameclassExpression' withAll: array ]
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
ViennaVDMParser >> seqConcPattern [
	^ super seqConcPattern ==> [ :array | ViennaNode label: 'SeqConcPattern' withAll: array ]
]

{ #category : #'parsers-patterns' }
ViennaVDMParser >> seqEnumPattern [
	^ super seqEnumPattern ==> [ :array | ViennaNode label: 'SeqEnumPattern' with: array ]
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
	^ super setEnumPattern ==> [ :array | ViennaNode label: 'SetEnumPattern' with: array ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMParser >> setEnumeration [
	^ super setEnumeration ==> [ :array | ViennaNode label: 'SetEnumeration' with: array ]
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
	^ super symbolicLiteral ==> [ :string | ViennaNode label: 'SymbolicLiteral' with: string ]
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
	^ ViennaNode label: 'Tail' with: arg
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

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMParser >> typeJudgement [
	^ super typeJudgement ==> [ :array | ViennaNode label: 'TypeJudgement' withAll: array ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> typeName [
	^ super typeName ==> [ :ast | ViennaNode label: 'TypeName' with: ast ]
]

{ #category : #'parsers-types' }
ViennaVDMParser >> typeVariable [
	^ super typeVariable ==> [ :string | ViennaNode label: 'TypeVariable' with: string ]
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
	^ ViennaNode label: 'Union' with: arg1 with: arg2
]

{ #category : #'parsers-types' }
ViennaVDMParser >> unionType [
	^ super unionType ==> [ :array | ViennaNode label: 'UnionType' with: array ]
]

{ #category : #'parsers-definitions' }
ViennaVDMParser >> valueDefinition [
	^ super valueDefinition ==> [ :array | ViennaNode label: 'ValueDefinition' withAll: array ]
]

{ #category : #'parsers-expressions-threads' }
ViennaVDMParser >> waitingExpression [
	^ super waitingExpression ==> [ :nameNode | ViennaNode label: 'WaitingExpression' with: nameNode ]
]

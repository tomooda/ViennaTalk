Class {
	#name : #ViennaSyntaxTemplate,
	#superclass : #Object,
	#instVars : [
		'candidates'
	],
	#classInstVars : [
		'current'
	],
	#category : 'ViennaTalk-Browser-Core'
}

{ #category : #'sole instance' }
ViennaSyntaxTemplate class >> current [
	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
ViennaSyntaxTemplate >> at: aString ifAbsent: errorBlock [
	| index |
	index := candidates indexOf: aString asString.
	index = 0
		ifTrue: [ 
			| base |
			base := 'template' , aString asString capitalized.
			candidates := (self class allSelectors
				select: [ :selector | selector size >= base size and: [ (selector copyFrom: 1 to: base size) = base ] ])
				asSortedCollection asArray collect: [ :selector | self perform: selector ].
			index := candidates size ].
	index = 0
		ifTrue: [ ^ errorBlock value ].
	index := index \\ candidates size + 1.
	^ candidates at: index
]

{ #category : #'initialize-release' }
ViennaSyntaxTemplate >> initialize [
	super initialize.
	candidates := Array new
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateAbs [
	^ 'abs '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateAbs1 [
	^ 'abs REAL_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateBest [
	^ 'be st '
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateBool [
	^ 'bool'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateCard [
	^ 'card '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateCard1 [
	^ 'card SET_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateCases [
	^ 'cases '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateCases1 [
	^ 'cases EXPRESSION:
    PATTERN1, PATTERN2 -> EXPRESSION_OR_STATEMENT1,
    PATTERN3 -> EXPRESSION_OR_STATEMENT2,
    others -> EXPRESSION_OR_STATEMENT3
end'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateCompose [
	^ 'compose CONSTRUCTOR of
            FIELD1 : TYPE1
            FIELD2 :- TYPE2
            TYPE3
        end'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateCompose1 [
	^ 'compose CONSTRUCTOR of FIELD1 : TYPE1 FIELD2 :- TYPE2 TYPE3 end'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateCompose2 [
	^ 'compose CONSTRUCTOR of
    FIELD1 : TYPE1 -- named field
    FIELD2 :- TYPE2 -- equality abstracted named field
    TYPE3 -- anonymous field
end'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateConc [
	^ 'conc '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateConc1 [
	^ 'conc SEQ_OF_SEQ_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDef [
	^ 'def '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDef1 [
	^ 'def
    PATTERN1 = EXPRESSION1;
    PATTERN2 : TYPE  = EXPRESSION2;
    PATTERN3 in set EXPRESSION3 = EXPRESSION4;
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDef2 [
	^ 'def
    PATTERN = EXPRESSION
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDef3 [
	^ 'def
    PATTERN : TYPE  = EXPRESSION
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDef4 [
	^ 'def
    PATTERN in set EXPRESSION1 = EXPRESSION2
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDinter [
	^ 'dinter '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDinter1 [
	^ 'dinter SET_OF_SET_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDom [
	^ 'dom '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDom1 [
	^ 'dom SET_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDunion [
	^ 'dunion '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateDunion1 [
	^ 'dunion SET_OF_SET_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElems [
	^ 'elems '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElems1 [
	^ 'elems SEQ_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElse [
	^ 'else '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElse1 [
	^ 'else EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElseif [
	^ 'elseif '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElseif1 [
	^ 'elseif BOOL_EXPRESSION then EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateElseif2 [
	^ 'elseif BOOL_EXPRESSION 
    then EXPRESSION_OR_STATEMENT1
else EXPRESSION_OR_STATEMENT2'
]

{ #category : #'templates-interfaces' }
ViennaSyntaxTemplate >> templateExports1 [
	^ 'exports all'
]

{ #category : #'templates-interfaces' }
ViennaSyntaxTemplate >> templateExports2 [
	^ 'exports
    types TYPE;
    values CONSTANT : TYPE;
    functions FUNCTION : ARG_TYPE -> RET_TYPE;
    operations OPERATION : ARG_TYPE ==> RET_TYPE;'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateFloor [
	^ 'abs '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateFloor1 [
	^ 'abs REAL_EXPRESSION'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions [
	^ 'functions
    '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions1 [
	^ 'functions
    FUNCTION : ARG_TYPE -> RET_TYPE
    FUNCTION(ARG) == EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions2 [
	^ 'functions
    FUNCTION : ARG_TYPE -> RET_TYPE
    FUNCTION(ARG) == EXPRESSION
    pre BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions3 [
	^ 'functions
    FUNCTION : ARG_TYPE -> RET_TYPE
    FUNCTION(ARG) == EXPRESSION
    post BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions4 [
	^ 'functions
    FUNCTION : ARG_TYPE -> RET_TYPE
    FUNCTION(ARG) == EXPRESSION
    pre BOOL_EXPRESSION
    post BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateFunctions5 [
	^ 'functions
    FUNCTION : ARG_TYPE -> RET_TYPE
    FUNCTION(ARG) == EXPRESSION
    pre BOOL_EXPRESSION
    post BOOL_EXPRESSION
    measure MEASURE_FUNCTION;'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateHd [
	^ 'hd '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateHd1 [
	^ 'hd SEQ1_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateIf [
	^ 'if '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateIf1 [
	^ 'if BOOL_EXPRESSION then EXPRESSION_OR_STATEMENT1 else EXPRESSION_OR_STATEMENT2'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateIf2 [
	^ 'if BOOL_EXPRESSION
then EXPRESSION_OR_STATEMENT1
else EXPRESSION_OR_STATEMENT2'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateIf3 [
	^ 'if BOOL_EXPRESSION1
    then EXPRESSION_OR_STATEMENT1
elseif BOOL_EXPRESSION2
    then EXPRESSION_OR_STATEMENT2
else EXPRESSION_OR_STATEMENT3'
]

{ #category : #'templates-statement' }
ViennaSyntaxTemplate >> templateIfStatement [
	^ 'if BOOL_EXPRESSION then STATEMENT'
]

{ #category : #'templates-interfaces' }
ViennaSyntaxTemplate >> templateImports1 [
	^ 'imports from MODULE all'
]

{ #category : #'templates-interfaces' }
ViennaSyntaxTemplate >> templateImports2 [
	^ 'imports
    from MODULE1 types TYPE renamed TYPE;,
    from MODULE2
        values VALUE renamed VALUE;
        functions
            FUNCTION1: ARG_TYPE -> RET_TYPE renamed FUNCTION;
            FUNCTION2 renamed FUNCTION2;
        operations
            OPERATION1 : ARG_TYPE ==> RET_TYPE renamed OPERATION1;
            OPERATION2 renamed OPERATION2;'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateInds [
	^ 'inds '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateInds1 [
	^ 'inds SEQ_EXPRESSION'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateInmap [
	^ 'inmap TYPE1 to TYPE2'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateInt [
	^ 'int'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateInv [
	^ 'inv '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateInv1 [
	^ 'inv PATTERN == BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateInv2 [
	^ 'inv IDENTIFIER == BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateInv3 [
	^ 'inv mk_RECORD(IDENTIFIER1, IDENTIFIER2) == BOOL_EXPRESSION;'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateInverse [
	^ 'inverse '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateInverse1 [
	^ 'inverse MAP_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLen [
	^ 'len '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLen1 [
	^ 'len SEQ_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLet [
	^ 'let '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLet1 [
	^ 'let
    IDENTIFIER1 : TYPE1 = EXPRESSION1,
    IDENTIFIER2  = EXPRESSION2
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLetbe1 [
	^ 'let
    PATTERN1, PATTERN2 in set EXPRESSION
be st BOOL_EXPRESSION
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateLetbe2 [
	^ 'let
    PATTERN1, PATTERN2 : TYPE
be st BOOL_EXPRESSION
in EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateMap [
	^ 'map TYPE1 to TYPE2'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateMerge [
	^ 'merge '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateMerge1 [
	^ 'merge SET_OF_MAP_EXPRESSION'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateModule [
	^ 'module '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateModule1 [
	^ 'module MODULE
-- imports
exports all
definitions
-- types
-- values
-- functions
-- state
-- operations
end MODULE'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateModule2 [
	^ 'module MODULE
imports
    from MODULE1 types TYPE renamed TYPE;,
    from MODULE2
        values VALUE renamed VALUE;
        functions
            FUNCTION1: ARG_TYPE -> RET_TYPE renamed FUNCTION;
            FUNCTION2 renamed FUNCTION2;
        operations
            OPERATION1 : ARG_TYPE ==> RET_TYPE renamed OPERATION1;
            OPERATION2 renamed OPERATION2;
exports all
definitions
end MODULE'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateModule3 [
	^ 'module MODULE
exports
    types TYPE;
    values CONSTANT : TYPE;
    functions FUNCTION : ARG_TYPE -> RET_TYPE;
    operations OPERATION : ARG_TYPE ==> RET_TYPE;
definitions
end MODULE'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateModule4 [
	^ 'module MODULE
imports
    from MODULE1 types TYPE renamed TYPE;,
    from MODULE2
        values VALUE renamed VALUE;
        functions
            FUNCTION1: ARG_TYPE -> RET_TYPE renamed FUNCTION;
            FUNCTION2 renamed FUNCTION2;
        operations
            OPERATION1 : ARG_TYPE ==> RET_TYPE renamed OPERATION1;
            OPERATION2 renamed OPERATION2;
exports
    types TYPE;
    values CONSTANT : TYPE;
    functions FUNCTION : ARG_TYPE -> RET_TYPE;
    operations OPERATION : ARG_TYPE ==> RET_TYPE;
definitions
end MODULE'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateNat [
	^ 'nat'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateNat1 [
	^ 'nat1'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateNot [
	^ 'not '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateNot1 [
	^ 'not BOOL_EXPRESSION'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateOperations [
	^ 'operations
    '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateOperations1 [
	^ 'operations
    OPERATION : ARG_TYPE ==> RET_TYPE
    OPERATION(ARG) == STATEMENT;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateOperations2 [
	^ 'operations
    OPERATION : ARG_TYPE ==> RET_TYPE
    OPERATION(ARG) ==
        (STATEMENT1;
        STATEMENT2)
  pre BOOL_EXPRESSION
  post BOOL_EXPRESSION;'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateOthers [
	^ 'others -> '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateOthers1 [
	^ 'others -> EXPRESSION_OR_STATEMENT
end'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templatePower [
	^ 'power '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templatePower1 [
	^ 'power SET_EXPRESSION'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateReal [
	^ 'real'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateReverse [
	^ 'reverse '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateReverse1 [
	^ 'reverse SEQ_EXPRESSION'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateRng [
	^ 'rng '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateRng1 [
	^ 'rng SET_EXPRESSION'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateSeq [
	^ 'seq of TYPE'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateSeq1 [
	^ 'seq1 of TYPE'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateSet [
	^ 'set of TYPE'
]

{ #category : #'templates-types' }
ViennaSyntaxTemplate >> templateSet1 [
	^ 'set1 of TYPE'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateState [
	^ 'state '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateState1 [
	^ 'state STATE of
    VARIABLE1 : TYPE1
    VARIABLE2 : TYPE2
inv PATTERN2 == BOOL_EXPRESSION
init PATTERN1 == PATTERN1 = mk_STATE(EXPRESSION1, EXPRESSION2)
end'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateState2 [
	^ 'state STATE of
    VARIABLE1 : TYPE1
    VARIABLE2 : TYPE2
init PATTERN1 == PATTERN1 = mk_STATE(EXPRESSION1, EXPRESSION2)
end
'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateThen [
	^ 'then '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateThen1 [
	^ 'then EXPRESSION_OR_STATEMENT'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateThen2 [
	^ 'then EXPRESSION_OR_STATEMENT1 else EXPRESSION_OR_STATEMENT2'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateThen3 [
	^ 'then EXPRESSION_OR_STATEMENT1 
elseif BOOL_EXPRESSION
    then EXPRESSION_OR_STATEMENT2
else EXPRESSION_OR_STATEMENT3'
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateTl [
	^ 'tl '
]

{ #category : #'templates-expressions' }
ViennaSyntaxTemplate >> templateTl1 [
	^ 'tl SEQ1_EXPRESSION'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateTypes [
	^ 'types
    '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateTypes1 [
	^ 'types
    TYPE1 = TYPE2;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateTypes2 [
	^ 'types
    TYPE1 = TYPE2 inv PATTERN == BOOLEAN_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateTypes3 [
	^ 'types
     CONSTRUCTOR :: FIELD1 : TYPE1 FIELD2 :- TYPE2 TYPE3;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateTypes4 [
	^ 'types
     CONSTRUCTOR :: FIELD1 : TYPE1 FIELD2 :- TYPE2 TYPE3
        inv PATTERN == BOOL_EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateValues [
	^ 'values
    '
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateValues1 [
	^ 'values
    PATTERN:TYPE = EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateValues2 [
	^ 'values
    PATTERN = EXPRESSION;'
]

{ #category : #'templates-definitions' }
ViennaSyntaxTemplate >> templateValues3 [
	^ 'values
    IDENTIFIER = EXPRESSION;'
]

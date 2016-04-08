templates-definitions
templateOperations2
	^ 'operations
    OPERATION : ARG_TYPE ==> RET_TYPE
    OPERATION(ARG) ==
        (STATEMENT1;
        STATEMENT2)
  pre BOOL_EXPRESSION
  post BOOL_EXPRESSION;'
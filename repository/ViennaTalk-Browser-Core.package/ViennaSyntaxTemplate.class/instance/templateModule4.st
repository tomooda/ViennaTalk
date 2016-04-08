templates-definitions
templateModule4
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
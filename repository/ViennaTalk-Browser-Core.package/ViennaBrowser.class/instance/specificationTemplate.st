code pane
specificationTemplate
	^ 'module <module name>
exports all
definitions
types
	<typename> = <type expression>;
values
	<constant> = <expression>;
functions
	<funcname> : <arg type> -> <return type>
	<funcname>(<arg>) == <expression>
	pre <precondition>
	post <postcondition>;
state <State> of
	<varname> : <type expression>
init s == s = mk_<State>(<initial value>)
end
operations
	<operation name> : <arg type> ==> <return type or ()>
	<operation name>(<arg>) == <statement>
	pre <precondition>
	post <postcondition>;
end <module name>
'
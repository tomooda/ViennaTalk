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
	pre <boolean expression>
	post <boolean expression>;
state <State> of
	<varname> : <type expression>
init s == s = mk_<State>(<initial value>)
inv mk_<State>(<varname>) == <boolean expression>
end
operations
	<operation name> : <arg type> ==> <return type or ()>
	<operation name>(<arg>) == <statement>
	pre <boolean expression>
	post <boolean expression>;
end <module name>
' asText makeAllColor: Color gray
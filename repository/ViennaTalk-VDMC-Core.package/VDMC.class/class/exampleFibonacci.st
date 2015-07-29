examples
exampleFibonacci
	"VDMC exampleFibonacci"

	| vdmc |
	vdmc := VDMC on: ViennaClient default.
	vdmc
		specification:
			'
state State of
	n1 : nat
	n2 : nat
	init s == s = mk_State(0, 1)
end
operations
	next : () ==> nat
	next() == (dcl n : nat := n1 + n2; n1 := n2; n2 := n; return n);'.
	^ (Array streamContents: [ :stream | 10 timesRepeat: [ stream nextPut: (vdmc evaluate: 'next()') ] ]) inspect; yourself
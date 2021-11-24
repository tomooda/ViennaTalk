Extension { #name : #DebugSession }

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
DebugSession >> asViennaDebugSession [

	^ (ViennaDebugSession
		   named: self name
		   on: self interruptedProcess
		   startedAt: self interruptedContext)
			exception: self exception;
		  errorWasInUIProcess: self errorWasInUIProcess;
		  yourself
]

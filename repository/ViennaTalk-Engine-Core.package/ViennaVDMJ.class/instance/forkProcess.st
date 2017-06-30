private
forkProcess
	^ OSSUnixSubprocess new
		command: self javaPath;
		arguments:
			{'-Dfile.encoding=whatever'.
			'-Xss2m'.
			'-jar'.
			(self json4vdmjPath fullName convertToEncoding: 'utf-8')};
		defaultWriteStreamCreationBlock: [ OSSVMProcess vmProcess systemAccessor makeNonBlockingPipe ];
		redirectStdout;
		redirectStderr;
		defaultReadStreamCreationBlock: [ OSSVMProcess vmProcess systemAccessor makeBlockingPipe ];
		redirectStdin;
		run;
		yourself
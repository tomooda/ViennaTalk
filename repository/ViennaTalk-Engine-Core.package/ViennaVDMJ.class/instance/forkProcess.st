private
forkProcess
	^ OSSUnixSubprocess new
		command: self javaPath;
		arguments:
			{'-Dfile.encoding=whatever'.
			'-Xss2m'.
			'-jar'.
			(self json4vdmjPath fullName convertToEncoding: 'utf-8')};
		redirectStdout;
		redirectStderr;
		redirectStdin;
		run;
		yourself
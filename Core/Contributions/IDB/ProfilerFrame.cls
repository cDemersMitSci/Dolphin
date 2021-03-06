"Filed out from Dolphin Smalltalk 7"!

Object subclass: #ProfilerFrame
	instanceVariableNames: 'compiledCode methodClass receiverClass selector ip isBlock'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ProfilerFrame guid: (GUID fromString: '{425d0eae-542e-11d3-998b-d5ca2c3c1d61}')!
ProfilerFrame comment: 'See [DolphinImageFolder]/Idb/Documentation for details

(C) 2005 Ian Bartholomew
ian@idb.me.uk
Public Domain Freeware'!
!ProfilerFrame categoriesForClass!IDB Goodies! !
!ProfilerFrame methodsFor!

coloredSource
	"Answer a RichText containing the colored source for the receivers compiledCode"

	^compiledCode getSource!

compiledCode
	^compiledCode!

disassemblySelectionLine
	"Answer the selectionLine for the ip in the receivers *disassembled* source"

	^compiledCode byteCodeDispatcherClass indexOfIP: (compiledCode byteCodeDispatcher prevIP: ip)
		in: compiledCode!

disassemblySource
	"Answer the disassembled source code for the receiver. We need more information than 
	the straight disassembly, such as statement numbers and source code"

	| inStream outStream textMap text |
	textMap := compiledCode textMap.
	inStream := compiledCode disassembly readStream.
	outStream := String writeStream.
	[inStream atEnd] whileFalse: 
			[| line thisIP |
			line := inStream nextLine trimBlanks.
			"D5 fix - ignore extra data in disassembly"
			(thisIP := Integer readFrom: line readStream) = 0 
				ifFalse: 
					[| index |
					index := 1.
					[index <= textMap size and: [(textMap at: index) key < thisIP]] whileTrue: [index := index + 1].
					outStream
						nextPut: $(;
						print: index;
						nextPut: $);
						space;
						nextPutAll: line;
						cr]].
	outStream cr.
	text := compiledCode getSource.
	textMap keysAndValuesDo: 
			[:index :each | 
			outStream
				nextPut: $(;
				print: index;
				nextPut: $);
				space;
				nextPutAll: (text copyFrom: each value start to: each value stop);
				cr].
	^outStream contents!

doClassAndSelectorMatch: aCompiledMethod 
	"Answers true if the class and selector of the receiver match aCompiledMethod.
	Done this way as it it a lot quicker than comparing compiledMethods"

	^self isCompiledExpression not 
		and: [aCompiledMethod methodClass == methodClass and: [aCompiledMethod selector == selector]]!

icon
	"Answer the icon for the frame's object"

	^receiverClass instanceClass icon!

ip
	"Answer the value of the receiver's instance variable ip.
	This method was automatically generated, but may be modified."

	^ip!

isCompiledExpression
	"Answers true if the compiledCode for this frame is part of a CompiledExpression"

	^compiledCode isKindOf: CompiledExpression!

isInSystemPackage
	"Answers true if the compiledCode for the receiver is not part of the system (Dolphin) package.
	Check for instances of CompiledExpression first as we want those. Used by the
	Dolphin filter in the browser"

	^self isCompiledExpression not 
		and: [compiledCode owningPackage notNil and: [compiledCode owningPackage isSystemPackage]]!

isSameFrameAs: aStackFrame 
	"Answers true if the receiver represents the same evaluation point as anIProfilerSampleFrame.
	CompiledCode>>= causes quite a performance hit so only use it for blocks. Note that
	we base the comparison on the receiverClass and not the methodClass"

	isBlock 
		ifTrue: [compiledCode = aStackFrame method ifFalse: [^false]]
		ifFalse: 
			[(receiverClass = aStackFrame receiver class and: [selector = aStackFrame method selector]) 
				ifFalse: [^false]].
	^ip = aStackFrame ip!

methodClass
	"Answer the value of the receiver's instance variable methodClass.
	This method was automatically generated, but may be modified."

	^methodClass!

printOn: aStream 
	"Add a description of the receiver onto aStream"

	isBlock ifTrue: [aStream nextPutAll: '[] in '].
	aStream print: receiverClass.
	receiverClass == methodClass 
		ifFalse: 
			[aStream
				space;
				nextPut: $(;
				print: methodClass;
				nextPut: $)].
	aStream
		space;
		nextPutAll: selector!

profilerIconIndex
	"Answer the icon index for the frame's object"

	^self icon imageIndex!

selectionRange
	"Answer the selectionRange for the ip in the receivers source"

	| previousIP textMap index |
	previousIP := compiledCode byteCodeDispatcher prevIP: ip.
	textMap := compiledCode textMap.
	index := 1.
	[index <= textMap size and: [(textMap at: index) key < previousIP]] whileTrue: [index := index + 1].
	^(textMap at: index ifAbsent: [^0 to: 0]) value!

selector
	"Answer the value of the receiver's instance variable selector.
	This method was automatically generated, but may be modified."

	^selector!

selectorDescription
	"Answer a description of the compiled code. We use this as the comparison operator
	for compiledCode is quite slow and it is quicker (when building Sets for example) to use
	this description and then collect the actual compiled code later"

	^methodClass -> selector!

setFrame: aStackFrame 
	"Initialize the receiver from aStackFrame"

	compiledCode := aStackFrame method.
	methodClass := compiledCode methodClass.
	receiverClass := aStackFrame receiver class.
	selector := compiledCode selector.
	ip := aStackFrame ip.
	isBlock := aStackFrame isKindOf: BlockFrame.
	^self! !
!ProfilerFrame categoriesFor: #coloredSource!displaying!public! !
!ProfilerFrame categoriesFor: #compiledCode!accessing!public! !
!ProfilerFrame categoriesFor: #disassemblySelectionLine!displaying!public! !
!ProfilerFrame categoriesFor: #disassemblySource!displaying!public! !
!ProfilerFrame categoriesFor: #doClassAndSelectorMatch:!public!testing! !
!ProfilerFrame categoriesFor: #icon!accessing!public! !
!ProfilerFrame categoriesFor: #ip!accessing!public! !
!ProfilerFrame categoriesFor: #isCompiledExpression!public!testing! !
!ProfilerFrame categoriesFor: #isInSystemPackage!public!testing! !
!ProfilerFrame categoriesFor: #isSameFrameAs:!public!testing! !
!ProfilerFrame categoriesFor: #methodClass!accessing!public! !
!ProfilerFrame categoriesFor: #printOn:!ANSI protocols-Object!protocols-Object!public! !
!ProfilerFrame categoriesFor: #profilerIconIndex!accessing!public! !
!ProfilerFrame categoriesFor: #selectionRange!displaying!public! !
!ProfilerFrame categoriesFor: #selector!accessing!public! !
!ProfilerFrame categoriesFor: #selectorDescription!accessing!public! !
!ProfilerFrame categoriesFor: #setFrame:!initializing!public! !

!ProfilerFrame class methodsFor!

frame: aStackFrame 
	"Answer an instance of the receiver initialized from aStackFrame, which may be a StackFrame
	instance or an instance of one of its subclasses"

	^super new setFrame: aStackFrame!

new
	"Should only create a new instance using #frame:"

	^self shouldNotImplement! !
!ProfilerFrame class categoriesFor: #frame:!instance creation!public! !
!ProfilerFrame class categoriesFor: #new!instance creation!protocols-instantiator!protocols-Object class!public! !


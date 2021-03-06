"Filed out from Dolphin Smalltalk 7"!

ExternalAddress variableByteSubclass: #BSTR
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BSTR guid: (GUID fromString: '{87b4c519-026e-11d3-9fd7-00a0cc3e4a32}')!
BSTR isIndirection: true!
BSTR comment: 'BSTR is an external structure to represent the OLE Automation string type of the same name.

BSTR is defined as:
	typedef OLECHAR FAR* BSTR;
That is, it is a pointer to a Unicode character string (although it cannot be used interchangeably with the latter - see below). 
As the underlying BSTR type is actually a pointer we define it here as a subclass of ExternalAddress, rather than try to squeeze it into the ExternalStructure hierarchy.

BSTRs are both null-terminated AND counted. They store their length as a 32-bit integer in the location immediately preceding the data of the string. BSTRs may also contain embedded nulls, which are included in the reported size, although the terminating null is not. Furthermore a BSTR may (validly) be null, in which case it behaves as if it were an empty string, as per the OLE Automation convention. It is worth noting that VB will usually pass a NULL pointer in place of the empty string.

BSTRs are stored in memory managed by the OLE Automation Library, which enables ownership to be passed from one function to another:  (down in the depths of OLEAut32.DLL the SysXXX functions map onto the services of the COM task memory allocator). Where a function is expecting a BSTR argument, then a BSTR allocated with SysAllocString must be passed rather than an ordinary Unicode string. The BSTR class can be used to create suitable parameters from other Smalltalk <readableString> classes.

BSTRs use finalization to safely manage the sys. alloc''d string, but they may be explicitly free''d too.'!
!BSTR categoriesForClass!External-Data-Unstructured! !
!BSTR methodsFor!

asBSTR
	"Answer the receiver converted to an AX Automation string."

	^self!

asString
	"Answer a byte string representation of the receiver."

	| buf size bytes |
	(size := self size) == 0 ifTrue: [^''].
	buf := String new: size + size.
	bytes := KernelLibrary default
				wideCharToMultiByte: 0
				dwFlags: 0
				lpWideCharStr: self
				cchWideChar: size
				lpMultiByteStr: buf
				cchMultiByte: buf size
				lpDefaultChar: nil
				lpUsedDefaultChar: nil.
	bytes == 0 ifTrue: [^KernelLibrary default systemError].
	buf resize: bytes.
	^buf!

asUnicodeString
	"Answer a UnicodeString composed of the characters of the receiver, or
	the empty string if the receiver is a null pointer (by convention a null BSTR 
	is treated the same as an empty string)."

	^UnicodeString fromAddress: self length: self size!

at: anInteger
	"Answer the character at index, anInteger, in the receiver."

	| index |
	index := anInteger+anInteger.
	^Character value: (super at: index) * 256 + (super at: index-1)!

at: anInteger put: aCharacter
	"Replace the character at index, anInteger, in the receiver with aCharacter."

	^super at: anInteger+anInteger-1 put: aCharacter!

attach: newValue
	"Private - Set the receiver to be a reference to the <bstr>, newValue.
	Answer the receiver."

	^super value: newValue!

basicFree
	"Private - Free the receiver's external resources."

	OLEAutLibrary default sysFreeString: self.
	self basicUIntPtrAtOffset: 0 put: 0!

byteSize
	"Answer the size in bytes of the string pointed at by the receiver, including any
	embedded nulls, but excluding the terminating null."
	
	^OLEAutLibrary default sysStringByteLen: self!

copy
	"Answer an <Object> which is a copy of the receiver (by default a copy which shares the receiver's 
	instance variables). This may be reimplemented to return a deep copy, or some other 
	form of copy (e.g. a 2-level copy, or, for an identify object, the same object), whatever
	is appropriate for the receiver."

	^self deepCopy!

deepCopy
	"Answer a 'deep copy' of the receiver. The 'deep copy' is a clone of the receiver,
	sharing only those parts which cannot be copied (e.g. classes, nil, true, false, 
	SmallIntegers, Symbols, Characters, etc).
	Implementation Note: Override #deepCopy rather than #_deepCopy: because this
	is a byte object and the sole purpose of which is to act as a reference to another
	object, and there is no point copying its body."

	^OLEAutLibrary default sysAllocString: self!

displayOn: aStream
	"Append a developer friendly textual representation of the receiver to aStream."

	aStream 
		nextPutAll: self asString!

free
	"Private - Frees the receiver's external resources by releasing the interface."

	self asInteger == 0
		ifFalse: [self basicFree].
	self beUnfinalizable!

onStartup
	"Private - The system is starting. Modify the state of the receiver to account for the fact
	than any external memory allocated for the receiver during the previous session is no 
	longer accessible."

	self beUnfinalizable.
	super value: 0!

printOn: aStream
	"Append a developer friendly textual representation of the receiver to aStream."

	aStream 
		basicPrint: self;
		nextPut: $(;
		print: self asUnicodeString;
		nextPut: $)!

size
	"Answer the number of characters (including any embedded nulls, but excluding the 
	terminating null) in the receiver. If the receiver is a null pointer, then the answer will
	be zero."
	
	^OLEAutLibrary default sysStringLen: self!

value
	"Answer the receiver's value as a Smalltalk <String>."

	^self asString!

value: newValue
	"Set the contents of the receiver to be a BSTR (String) representation of the 
	representation of the specified object. If the argument is itself a BSTR, then a copy
	is taken. Answer the receiver."

	| bstr |
	newValue isInteger 
		ifTrue: [bstr := self class fromAddress: newValue]
		ifFalse: [
			bstr := newValue asBSTR.
			bstr == newValue ifTrue: [bstr := bstr copy]].
	super value: (bstr beUnfinalizable; yourself)! !
!BSTR categoriesFor: #asBSTR!converting!public! !
!BSTR categoriesFor: #asString!converting!public! !
!BSTR categoriesFor: #asUnicodeString!converting!public! !
!BSTR categoriesFor: #at:!accessing!public! !
!BSTR categoriesFor: #at:put:!accessing!public! !
!BSTR categoriesFor: #attach:!accessing!private! !
!BSTR categoriesFor: #basicFree!private!realizing/unrealizing! !
!BSTR categoriesFor: #byteSize!accessing!public! !
!BSTR categoriesFor: #copy!copying!public! !
!BSTR categoriesFor: #deepCopy!copying!public! !
!BSTR categoriesFor: #displayOn:!printing!public! !
!BSTR categoriesFor: #free!private!realizing/unrealizing! !
!BSTR categoriesFor: #onStartup!event handling!private! !
!BSTR categoriesFor: #printOn:!development!printing!public! !
!BSTR categoriesFor: #size!accessing!public! !
!BSTR categoriesFor: #value!accessing!public! !
!BSTR categoriesFor: #value:!accessing!public! !

!BSTR class methodsFor!

basicNew
	^self newFixed: 4!

clear: anExternalAddress
	OLEAutLibrary default sysFreeString: (anExternalAddress dwordAtOffset: 0)!

fromInteger: anAddress
	"Answer a new instance of the receiver that points at a copy of the 
	BSTR at the address, anInteger.
	Implementation Note: Override to answer a BSTR regardless of
	whether anAddress is null, since null is a valid BSTR value,
	also we must take a copy to avoid ownership problems."

	^anAddress isNull 
		ifTrue: [self new]
		ifFalse: [ | answer |
			answer := OLEAutLibrary default sysAllocString: anAddress.
			answer isNull 
				ifTrue: [OutOfMemoryError signal]
				ifFalse: [answer beFinalizable; yourself]]!

fromString: aString 
	"Answer a new instance of the receiver with the same contents as aString."

	| wstr |
	wstr := aString asUnicodeString.
	wstr size == 0 ifTrue: [^self new].
	^self fromInteger: wstr yourAddress!

icon
	"Answers an Icon that can be used to represent this class"

	^String icon!

initialize
	"Private - Initialize the receiver.
	Register with session events to clean up instances on startup.
	
		BSTR initialize
	"

	SessionManager current 
		when: #sessionStarted send: #onStartup to: self!

new
	"Answer a new instance of the receiver of the initially holding a null pointer."

	^(self basicNew)
		beFinalizable;
		yourself!

newBuffer
	"Answer a new instance containing its own buffer (in this case the buffer
	is just for a pointer)."

	^self new
!

onStartup
	"Private - Notify all the receiver's sub-instances of system startup."

	self primAllInstances do: [:i | i onStartup]!

uninitialize
	"Private - Uninitialize the receiver immediately prior to its removal from the system."

	VMLibrary default registryAt: #BSTR put: nil.
	SessionManager current removeEventsTriggeredFor: self! !
!BSTR class categoriesFor: #basicNew!instance creation!private! !
!BSTR class categoriesFor: #clear:!public!realizing/unrealizing! !
!BSTR class categoriesFor: #fromInteger:!instance creation!public! !
!BSTR class categoriesFor: #fromString:!instance creation!public! !
!BSTR class categoriesFor: #icon!constants!public! !
!BSTR class categoriesFor: #initialize!development!initializing!private! !
!BSTR class categoriesFor: #new!instance creation!public! !
!BSTR class categoriesFor: #newBuffer!instance creation!public! !
!BSTR class categoriesFor: #onStartup!event handling!private! !
!BSTR class categoriesFor: #uninitialize!class hierarchy-removing!private! !


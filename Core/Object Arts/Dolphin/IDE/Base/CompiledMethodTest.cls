"Filed out from Dolphin Smalltalk 7"!

DolphinTest subclass: #CompiledMethodTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CompiledMethodTest guid: (GUID fromString: '{32df31e4-99ba-44fb-aaac-99e5dfe82c94}')!
CompiledMethodTest comment: 'This is the unit test for the class CompiledMethod. Unit tests are a good way to exercise the functionality of your system in a repeatable and automatic manner. They are therefore recommended if you plan to release anything. For more information, see: 
	- http://www.c2.com/cgi/wiki?UnitTest
	- http://minnow.cc.gatech.edu/squeak/1547
	- the sunit class category'!
!CompiledMethodTest categoriesForClass!Tests-Kernel-Methods! !
!CompiledMethodTest methodsFor!

returnPlusOne: anInteger
	^anInteger + 1.!

returnTrue
	^true!

testIsQuick
	| method |
	method := self class compiledMethodAt: #returnTrue.
	self assert: method extraIndex = 2.
	method := self class compiledMethodAt: #returnPlusOne:.
	self deny: method extraIndex = 5!

testValueWithReceiverArguments
	| method value |
	method := self class compiledMethodAt: #returnTrue.
	self should: [method value: nil withArguments: #()] raise: Error.
	value := method value: self withArguments: #().
	self assert: value = true.
	method := self class compiledMethodAt: #returnPlusOne:.
	value := method value: self withArguments: #(1).
	self assert: value = 2! !
!CompiledMethodTest categoriesFor: #returnPlusOne:!examples!public! !
!CompiledMethodTest categoriesFor: #returnTrue!examples!public! !
!CompiledMethodTest categoriesFor: #testIsQuick!public!testing / testing! !
!CompiledMethodTest categoriesFor: #testValueWithReceiverArguments!public!testing / evaluating! !


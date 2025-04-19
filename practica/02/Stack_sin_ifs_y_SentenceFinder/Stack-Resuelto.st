!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:15:56'!
isEmpty

	^ elements isEmpty.! !

!OOStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:30:55'!
isNotEmpty

	^ self isEmpty not.! !

!OOStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:10:49'!
size

	^ elements size! !

!OOStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:11:26'!
top
	
	^ self state top.! !


!OOStack methodsFor: 'initialization' stamp: 'MN 4/18/2025 15:10:32'!
initialize

	elements := OrderedCollection new.! !


!OOStack methodsFor: 'accessing' stamp: 'MN 4/18/2025 15:10:04'!
pop
	| topElement |
	
	topElement := self top.
	elements removeFirst.
	
	^ topElement 
! !

!OOStack methodsFor: 'accessing' stamp: 'MN 4/18/2025 15:10:21'!
push: anObject

	elements addFirst: anObject.! !


!OOStack methodsFor: 'private state' stamp: 'MN 4/18/2025 15:24:52'!
state

	^ OOStackState stateFor: self! !

!OOStack methodsFor: 'private state' stamp: 'MN 4/18/2025 15:19:16'!
topWhenEmpty
	
	self error: self class stackEmptyErrorDescription ! !

!OOStack methodsFor: 'private state' stamp: 'MN 4/18/2025 15:19:56'!
topWhenNotEmpty

	^ elements first.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'initialization' stamp: 'MN 4/18/2025 15:13:43'!
initializeFor: aStack

	stack := aStack.! !


!OOStackState methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:15:31'!
top
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'instance creation' stamp: 'MN 4/18/2025 15:12:19'!
newFor: aStack

	^ self new initializeFor: aStack.! !

!OOStackState class methodsFor: 'instance creation' stamp: 'MN 4/18/2025 15:28:50'!
stateFor: aStack
	| stateSubclass |
	
	stateSubclass := self subclasses detect: [ :eachStateSubclass |
		eachStateSubclass canHandle: aStack.
	].

	^ stateSubclass newFor: aStack.! !


!OOStackState class methodsFor: 'handling stacks' stamp: 'MN 4/18/2025 15:29:26'!
canHandle: aStack
	
	self subclassResponsibility! !


!classDefinition: #OOEmptyStack category: #'Stack-Exercise'!
OOStackState subclass: #OOEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOEmptyStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:17:02'!
top
	
	^ stack topWhenEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOEmptyStack class' category: #'Stack-Exercise'!
OOEmptyStack class
	instanceVariableNames: ''!

!OOEmptyStack class methodsFor: 'handling stacks' stamp: 'MN 4/18/2025 15:29:50'!
canHandle: aStack

	^ aStack isEmpty.! !


!classDefinition: #OONotEmptyStack category: #'Stack-Exercise'!
OOStackState subclass: #OONotEmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONotEmptyStack methodsFor: 'inspection' stamp: 'MN 4/18/2025 15:18:36'!
top
	
	^ stack topWhenNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONotEmptyStack class' category: #'Stack-Exercise'!
OONotEmptyStack class
	instanceVariableNames: ''!

!OONotEmptyStack class methodsFor: 'handling stacks' stamp: 'MN 4/18/2025 15:30:01'!
canHandle: aStack

	^ aStack isNotEmpty.! !

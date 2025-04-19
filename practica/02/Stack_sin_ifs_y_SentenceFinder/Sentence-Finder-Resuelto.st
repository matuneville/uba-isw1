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


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'testing functionalities' stamp: 'MN 4/19/2025 11:44:56'!
test01noFoundResultsOnEmptyStack

	| emptySet |
	
	emptySet := Set new.
	
	self
		shouldStackWith: emptySet
		andPrefix: 'ab'
		findSentences: emptySet! !

!SentenceFinderByPrefixTest methodsFor: 'testing functionalities' stamp: 'MN 4/19/2025 11:32:40'!
test02aWordShouldBePrefixOfTheSameUniqueSentence
	
	| sentences |
	
	sentences := Set with: 'hello_world!!'.
	
	self 
		shouldStackWith: sentences
		andPrefix: sentences anyOne
		findSentences: sentences! !

!SentenceFinderByPrefixTest methodsFor: 'testing functionalities' stamp: 'MN 4/19/2025 11:34:14'!
test03allSentencesWithSamePrefix
	
	| sentences |
	
	sentences := Set
		with: 'holaa !!'
		with: 'hola mundoooo'
		with: 'hola querido'
		with: 'holaaaa, como andas?'.
	
	self
		shouldStackWith: sentences
		andPrefix: 'hola'
		findSentences: sentences.! !

!SentenceFinderByPrefixTest methodsFor: 'testing functionalities' stamp: 'MN 4/19/2025 11:33:08'!
test04findingIsCaseSensitive

	| sentencesToAdd sentencesToFind prefix |
		
	sentencesToFind := Set
		with: 'pescando_Pescados'
		with: 'pescando_Pescados...'
		with: 'pescando_Peces porque...'
		with: 'pescando_Pernos de metal del agua'.
		
	"le agrego oraciones que no deben ser encontradas"
	sentencesToAdd := sentencesToFind copy.
	sentencesToAdd 
		add: 'Pescando_Pescados';
		add: 'peScando_Pescados mientras...';
		add: 'pescando peces es...'.
	
	prefix := 'pescando_Pe'.
	
	self
		shouldStackWith: sentencesToAdd
		andPrefix: prefix
		findSentences: sentencesToFind.! !

!SentenceFinderByPrefixTest methodsFor: 'testing functionalities' stamp: 'MN 4/19/2025 11:46:47'!
test07noFoundResultsOnStackWithoutCoincides
	| sentences emptySet |
	
	sentences := Set
		with: 'aaa'
		with: 'b'
		with: 'cccc'
		with: 'dd'
		with: 'eeeee'.
	
	emptySet := Set new.
	
	self
		shouldStackWith: sentences
		andPrefix: 'f'
		findSentences: emptySet! !


!SentenceFinderByPrefixTest methodsFor: 'should be' stamp: 'MN 4/19/2025 10:44:20'!
shouldStackWith: aSetOfSentencesToAdd andPrefix: aPrefix findSentences: aSetOfSentencesToBeFound
	
	| stack sentenceFinder foundSentencesWithPrefix |
	
	stack := OOStack new.
	
	aSetOfSentencesToAdd do: [ :eachSentence |
		stack push: eachSentence 
	].
	
	sentenceFinder := SentenceFinderByPrefix
		newWith: stack
		and: aPrefix.
	
	foundSentencesWithPrefix := sentenceFinder find.

	self assert: foundSentencesWithPrefix = aSetOfSentencesToBeFound.! !


!SentenceFinderByPrefixTest methodsFor: 'testing stack not changed' stamp: 'MN 4/19/2025 13:45:15'!
test08stackRemainTheSameAfterFinding
	| stack sentenceFinder elementsBeforeFinding elementsAfterFinding |
	
	stack := OOStack new.
	stack push: 'aa'; push: 'bbb'; push: 'cccc'; push: 'bb'; push: 'b'.
	
	sentenceFinder := SentenceFinderByPrefix newWith: stack and: 'bb'.
	
	elementsBeforeFinding := sentenceFinder elementsCopyOfStack .
	
	sentenceFinder find.
	
	elementsAfterFinding := sentenceFinder elementsCopyOfStack.
	
	self assert: elementsBeforeFinding = elementsAfterFinding.! !


!SentenceFinderByPrefixTest methodsFor: 'testing errors' stamp: 'MN 4/19/2025 11:31:24'!
test05emptyPrefixRaisesError

	self
		should: [
			SentenceFinderByPrefix
			newWith: (OOStack new)
			and: ''
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: SentenceFinderByPrefix emptyPrefixErrorDescription
		]
	
	 
	! !

!SentenceFinderByPrefixTest methodsFor: 'testing errors' stamp: 'MN 4/19/2025 11:33:47'!
test06prefixWithSpacesRaisesError

	self
		should: [
			SentenceFinderByPrefix
			newWith: (OOStack new)
			and: 'ab cd ef'
		]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: SentenceFinderByPrefix prefixContainsSpacesErrorDescription 
		]
	
	 
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'elements'
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


!OOStack methodsFor: 'testing' stamp: 'MN 4/19/2025 13:44:25'!
elementsCopy
	^ elements copy! !


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


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'MN 4/18/2025 21:17:06'!
initializeWith: aStack and: aPrefix

	stack := aStack.
	prefix := aPrefix.! !


!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'MN 4/19/2025 13:32:59'!
addResultsIn: aSet andAppendStackElementsIn: anOrderedCollection

	[stack isNotEmpty] whileTrue: [
		| currentStackTop |
		
		currentStackTop := stack pop.
		
		(currentStackTop beginsWith: prefix) ifTrue: [
			aSet add: currentStackTop.
		].
		
		anOrderedCollection add: currentStackTop.
	].! !

!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'MN 4/19/2025 13:32:47'!
findResultsAndReturnStackElementsReversed: aSet

	| stackElementsReversed |
	
	stackElementsReversed := OrderedCollection new.
	
	self addResultsIn: aSet andAppendStackElementsIn: stackElementsReversed.

	^ stackElementsReversed.! !

!SentenceFinderByPrefix methodsFor: 'finding - private' stamp: 'MN 4/19/2025 13:24:17'!
recreateOriginalStack: stackElementsReversed

	stackElementsReversed reverseDo: [ :eachElement |
		stack push: eachElement
	].! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'MN 4/19/2025 13:46:09'!
elementsCopyOfStack
	^ stack elementsCopy.! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'MN 4/19/2025 13:46:52'!
find

	| foundResults stackElementsReversed |
	
	foundResults := Set new.
	
	stackElementsReversed := self findResultsAndReturnStackElementsReversed: foundResults.
	
	self recreateOriginalStack: stackElementsReversed.
	
	^ foundResults.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'MN 4/19/2025 11:06:49'!
newWith: aStack and: aPrefix
	
	self assertPrefixNotEmpty: aPrefix.
	self assertPrefixHasNoSpaces: aPrefix.
	
	^ self new initializeWith: aStack and: aPrefix.! !


!SentenceFinderByPrefix class methodsFor: 'error handling' stamp: 'MN 4/19/2025 11:05:39'!
emptyPrefixErrorDescription
	^ 'Prefix cannot be empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'error handling' stamp: 'MN 4/19/2025 11:06:13'!
prefixContainsSpacesErrorDescription
	^ 'Prefix cannot contain spaces!!'! !


!SentenceFinderByPrefix class methodsFor: 'assetions' stamp: 'MN 4/19/2025 11:23:27'!
assertPrefixHasNoSpaces: aPrefix
	(aPrefix includes: $ ) ifTrue: [
		self error: self prefixContainsSpacesErrorDescription.
	].! !

!SentenceFinderByPrefix class methodsFor: 'assetions' stamp: 'MN 4/19/2025 11:22:40'!
assertPrefixHasSpaces: aPrefix
	(aPrefix isEmpty) ifTrue: [
		self error: self prefixContainsSpacesErrorDescription.
	].! !

!SentenceFinderByPrefix class methodsFor: 'assetions' stamp: 'MN 4/19/2025 11:22:10'!
assertPrefixNotEmpty: aPrefix
	(aPrefix isEmpty) ifTrue: [
		self error: self emptyPrefixErrorDescription.
	].! !

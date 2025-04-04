!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias 4/3/2025 20:39:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	self addingCustomerNamed: 'John Lennon' shouldNotTakeMoreThan: 50! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias 4/3/2025 20:39:36'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	self removingExistingCustomerNamed: 'Paul McCartney' shouldNotTakeMoreThan: 100
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias 4/3/2025 22:40:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self removeCustomerAfterAddAndSuspend: false

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias 4/3/2025 22:41:14'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	self removeCustomerAfterAddAndSuspend: true.


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Matias 4/3/2025 20:06:59'!
test07CanNotSuspendAnInvalidCustomer
	
	self cannotSuspendCustomer: 'George Harrison' afterAddingCustomer: 'John Lennon'
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'test_helpers_07_08' stamp: 'Matias 4/3/2025 20:33:59'!
addCustomer: aCustomerToAdd suspendCustomer: aCustomerToSuspend suspendAddedCustomer: addedCustomerMustBeSuspended
	
	| customerBook |
			
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: aCustomerToAdd.
	
	addedCustomerMustBeSuspended ifTrue: [customerBook suspendCustomerNamed: aCustomerToAdd].
	
	[ customerBook suspendCustomerNamed: aCustomerToSuspend. 
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: aCustomerToAdd) ]
	! !

!CustomerBookTest methodsFor: 'test_helpers_07_08' stamp: 'Matias 4/3/2025 20:30:07'!
cannotSuspendAlreadySuspendedCustomer: aCustomerToAddAndSuspend

	self addCustomer: aCustomerToAddAndSuspend suspendCustomer: aCustomerToAddAndSuspend suspendAddedCustomer: true! !

!CustomerBookTest methodsFor: 'test_helpers_07_08' stamp: 'Matias 4/3/2025 20:29:45'!
cannotSuspendCustomer: aCustomerToSuspend afterAddingCustomer: aCustomerToAdd
	
	self addCustomer: aCustomerToAdd suspendCustomer: aCustomerToSuspend suspendAddedCustomer: false! !


!CustomerBookTest methodsFor: 'test_helpers_01_02' stamp: 'Matias 4/3/2025 22:22:13'!
addOrRemoveToTest: addOrRemove customerNamed: aCustomer withTime: timeLimit
	
	| customerBook millisecondsBeforeRunning millisecondsAfterRunning actionAdd actionRemove finalAction|
	
	customerBook := CustomerBook new.
	
	addOrRemove = 'remove' ifTrue: [
		customerBook addCustomerNamed: aCustomer 
	].

	actionAdd := [customerBook addCustomerNamed: aCustomer].
	actionRemove := [customerBook removeCustomerNamed: aCustomer ].
	
	finalAction := addOrRemove = 'add' ifTrue: actionAdd ifFalse: actionRemove.
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	finalAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimit * millisecond)! !

!CustomerBookTest methodsFor: 'test_helpers_01_02' stamp: 'Matias 4/3/2025 22:21:19'!
addingCustomerNamed: aCustomerToAdd shouldNotTakeMoreThan: timeLimit
	self addOrRemoveToTest: 'add' customerNamed: aCustomerToAdd withTime: timeLimit! !

!CustomerBookTest methodsFor: 'test_helpers_01_02' stamp: 'Matias 4/3/2025 22:21:37'!
removingExistingCustomerNamed: aCustomerToAddAndRemove shouldNotTakeMoreThan: timeLimit
	self addOrRemoveToTest: 'remove' customerNamed: aCustomerToAddAndRemove withTime: timeLimit! !


!CustomerBookTest methodsFor: 'test_helpers_05_06' stamp: 'Matias 4/3/2025 22:41:48'!
removeCustomerAfterAddAndSuspend: aBoolean
	| customerBook paulMcCartney numberOfCustomersExpected numberOfSuspendedCustomersExpected finalAssert |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	numberOfSuspendedCustomersExpected := 1.
	numberOfCustomersExpected := 1.
	
	finalAssert := [self assert: (customerBook includesCustomerNamed: 'Paul McCartney')].
	
	aBoolean ifTrue: [
		customerBook removeCustomerNamed: paulMcCartney.
		numberOfSuspendedCustomersExpected := 0.
		numberOfCustomersExpected := 0.
		finalAssert := [ self deny: (customerBook includesCustomerNamed: 'Paul McCartney') ].
	].
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomersExpected equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomersExpected equals: customerBook numberOfCustomers.
	finalAssert value.! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !

!CustomerBook methodsFor: 'testing' stamp: 'Matias 4/3/2025 17:08:27'!
method: methodToTest shouldNotTakeMoreTimeThan: timeLimit
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	self methodToTest value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (timeLimit * millisecond)! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'Matias 4/3/2025 15:32:23'!
removeCustomerNamed: aName 

	| resultOfRemoval collectionsToCheck|
	
	collectionsToCheck := Array with: active with: suspended.
	
	collectionsToCheck do: [:eachCollection |
		resultOfRemoval := self removeCustomerNamed: aName from: eachCollection.

		resultOfRemoval ifNotNil: [
			^resultOfRemoval
		].
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'Matias 4/3/2025 10:00:10'!
removeCustomerNamed: aName from: aCollection
	
	1 to: aCollection size do: [:index |
		| nameAtIndex |
		nameAtIndex := aCollection at: index.
		
		"Chequeo si el nombre que busco es igual al leido"
		aName = nameAtIndex ifTrue: [
			"Si es igual, remuevo"
			aCollection removeAt: index.
			^ aName 
		] 
	].

	^nil! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !

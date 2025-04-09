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

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:22:09'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: 'John Lennon'] takeLessTimeThat: 50*millisecond.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:22:56'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self should: [customerBook removeCustomerNamed: paulMcCartney] takeLessTimeThat: 100*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:40:26'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self
		should: [ customerBook addCustomerNamed: ''.]
		raise: Error
		assert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:40:10'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		should: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		raise: NotFound 
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:55:17'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self
		should: customerBook
		haveANumberOfActiveCustomersOf: 0
		andANumberOfSuspendedCustomersOf: 1.

	self assert: (customerBook includesCustomerNamed: paulMcCartney).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:55:26'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self
		should: customerBook
		haveANumberOfActiveCustomersOf: 0
		andANumberOfSuspendedCustomersOf: 0.
		
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:43:41'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self
		should:[ customerBook suspendCustomerNamed: 'George Harrison' ]
		raise: CantSuspend 
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MN 4/9/2025 15:44:24'!
test08CanNotSuspendAnAlreadySuspendedCustomer
		
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self
		should:[ customerBook suspendCustomerNamed: johnLennon ]
		raise: CantSuspend 
		assert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'asserts' stamp: 'MN 4/9/2025 15:54:58'!
should: aCustomerBook haveANumberOfActiveCustomersOf: activeCustomers andANumberOfSuspendedCustomersOf: suspendedCustomers .
	
	self assert: activeCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: activeCustomers + suspendedCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MN 4/9/2025 15:42:31'!
should: aCodeBlockThatShouldFail raise: anExceptionType assert: aCodeBlockToVerificate 
	"Block1 ON Error DO Block2
		===
	TRY:
		Block1
	CATCH Error:
		Block2 
	
	El primer bloque debería fallar. Si falla, entonces chequea si se da la excepción del parámetro, y,
	en se caso, chequea el bloque de verificación para ver que esté todo bien.
	
	El self fail sirve para que, si el bloque que debía fallar NO falla, entonces falla el test, ya que
	no ocurrió lo esperado. También falla el test si no vale el bloque de verificación"
	
	[aCodeBlockThatShouldFail value.
	self fail]
		on: anExceptionType 
		do: aCodeBlockToVerificate! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MN 4/9/2025 15:21:35'!
should: aCodeBlockToTime takeLessTimeThat: aTimeLimit
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aCodeBlockToTime value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < aTimeLimit.! !


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

!CustomerBook methodsFor: 'customer management' stamp: 'MN 4/6/2025 20:33:55'!
removeCustomerNamed: aName 

	^ self removeCustomerNamed: aName from: active ifAbsentThen: [
		self removeCustomerNamed: aName from: suspended ifAbsentThen: [
			^ NotFound signal.
		].
	].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MN 4/6/2025 20:35:48'!
removeCustomerNamed: aName from: aCollection ifAbsentThen: aClosure 
	
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

	^aClosure value! !

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

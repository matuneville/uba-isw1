!classDefinition: #CreditCardTest category: 'TusLibros-com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:51:16'!
test01CardNumberMustBe16DigitsLong
		
	self
		should: [CreditCard withNumber: 1234 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be 16 digits long'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:51:16'!
test02CardNumberMustBeInteger
	
	self
		should: [ CreditCard withNumber: 'pepe' ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be integer'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:51:16'!
test03CardNumberMustBeStrictlyPositive

	self
		should: [ CreditCard withNumber: -111111111111111 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be strictly positive'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:51:16'!
test04ExpirationDateIsBeforeCurrentDate
	
	self
		should: [ CreditCard withNumber: -111111111111111 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be strictly positive'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:56:58'!
test05OwnerNameMustBeString

	self
		should: [ CreditCard withNumber: 1111111111111111 ownerName: 1213 expirationDate: 01/24 ]
		raise: Error - MessageNotUnderstood 
		description: 'Owner name must be string'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 19:57:02'!
test06OwnerNameMustBeMax30CharactersLong

	self
		should: [ CreditCard
			withNumber: 1111111111111111
			ownerName: 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'
			expirationDate: 01/24 ]
		raise: Error - MessageNotUnderstood 
		description: 'Owner name must be max 30 characters long'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 20:11:29'!
test07ExpirationDateMustBeGregorian

	self
		should: [ CreditCard
			withNumber: 1111111111111111
			ownerName: 'JOHN DOE'
			expirationDate: 'pepe']
		raise: Error - MessageNotUnderstood 
		description: 'Expiration date must be gregorian'.

	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'n 6/13/2025 20:39:36'!
test08ExpirationDateMustBeAfterCurrentDate

	self
		should: [ CreditCard
			withNumber: 1111111111111111
			ownerName: 'JOHN DOE'
			expirationDate: (GregorianMonthOfYear yearNumber: 2025 monthNumber: 02)
			]
		raise: Error
		description: 'Expiration date must be after current date'

	 ! !


!classDefinition: #TusLibrosTest category: 'TusLibros-com'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 09:42:45'!
bookA

	^ 'Book A'! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 09:42:51'!
bookB

	^ 'Book B'! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 10:38:21'!
bookC

	^ 'Book C'! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 09:43:01'!
catalogueWithBookA

	^ Set with: self bookA.! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 10:43:20'!
catalogueWithBookAandB

	^ Set with: self bookA with: self bookB.! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/17/2025 10:43:29'!
catalogueWithBookAandBandC
	
	^ Set with: self bookA with: self bookB with: self bookC.! !


!classDefinition: #CashierTest category: 'TusLibros-com'!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:42:45'!
test01TotalCheckoutPriceIsPriceAndSingleUnitOfUniqueBookOfCart

	self
		assertTotalCheckoutPriceIs: 15
		afterDoingForCart: [:aCart |
			aCart add: self bookA totalUnits: 1. 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:58'!
test02TotalCheckoutPriceIsProductOfPriceAndManyUnitsOfUniqueBookOfCart

	self
		assertTotalCheckoutPriceIs: (3*15)
		afterDoingForCart: [:aCart |
			aCart add: self bookA totalUnits: 3. 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:44:39'!
test03TotalCheckoutPriceIsSumOfPricesOfManyUnitsOfManyBooksOfCart

	self
		assertTotalCheckoutPriceIs: (3*15 + (5*10))
		afterDoingForCart: [:aCart |
			aCart add: self bookA totalUnits: 3.
			aCart add: self bookB totalUnits: 5.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 10:40:59'!
test04CannotCheckoutCartWithoutBooks

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self catalogueWithBookAandB .
	
	priceList := self priceListForBookAandB.
	
	cashier := Cashier newWith: priceList.
		
	self
		should: [ cashier checkout: cart with: self creditCard ]
		raise: Error
		description: 'Cannot checkout shopping cart without books.'! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 10:40:59'!
test05CannotCheckoutCartWithExpiredCreditCard

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self catalogueWithBookAandB.
	cart add: self bookA totalUnits: 3.
	
	priceList := self priceListForBookAandB.
	
	cashier := Cashier newWith: priceList.
	cashier setCurrentDate: (GregorianMonthOfYear marchOf: (GregorianYear number: 2027)).
		
	self
		should: [ cashier checkout: cart with: self creditCard ]
		raise: Error
		withExceptionDo: [:error |
			self assert: error messageText equals: 'Credit card is expired.'.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/17/2025 10:46:20'!
test06CannotCheckoutCartWithBooksThatAreNotInThePriceList

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self catalogueWithBookAandBandC.
	cart add: self bookC totalUnits: 3.
	
	priceList := self priceListForBookAandB.
	
	cashier := Cashier newWith: priceList.
		
	self
		should: [ cashier checkout: cart with: self creditCard ]
		raise: Error
		withExceptionDo: [:error |
			self assert: error messageText equals: 'Book is not in the price list'.
		]! !


!CashierTest methodsFor: 'creation' stamp: 'MN 6/17/2025 09:42:51'!
createPairsOfBooksAndPrices

	^ Array
			with: self bookA
			with: 15
			with: self bookB
			with: 10! !

!CashierTest methodsFor: 'creation' stamp: 'MN 6/17/2025 09:43:18'!
creditCard

	^ CreditCard
		withNumber: 1111222233334444
		ownerName: 'ALAN KAY'
		expirationDate: (GregorianMonthOfYear februaryOf: (GregorianYear number: 2027))! !

!CashierTest methodsFor: 'creation' stamp: 'MN 6/17/2025 10:40:59'!
priceListForBookAandB

	^ Dictionary newFromPairs: self createPairsOfBooksAndPrices! !


!CashierTest methodsFor: 'assertions' stamp: 'MN 6/17/2025 10:40:59'!
assertTotalCheckoutPriceIs: aTotalPrice afterDoingForCart: aBlock

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self catalogueWithBookAandB .
	aBlock value: cart.
	
	priceList := self priceListForBookAandB.
	
	cashier := Cashier newWith: priceList.
	
	self assert: (cashier totalCheckoutPrice: cart) equals: aTotalPrice.! !


!classDefinition: #ShoppingCartTest category: 'TusLibros-com'!
TusLibrosTest subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test01ShoppingCartShouldStartEmpty

	| cart |
	
	cart := ShoppingCart newWith: self catalogueWithBookA.
	
	self assert: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test02ShoppingCartWithOneBookIsNotEmpty

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self catalogueWithBookA.
	bookA := self bookA.
	
	aCart add: bookA totalUnits: 1.
	
	self deny: aCart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test03BookOfShoppingCartWithOneBookCanBeQueried

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self catalogueWithBookA.
	bookA := self bookA.
	
	aCart add: bookA totalUnits: 1.
	
	self assert: (aCart hasBook: bookA totalUnits: 1)! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:08'!
test04BooksOfShoppingCartWithManyBooksCanBeQueried

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: self catalogueWithBookAandB.
	bookA := self bookA.
	bookB := self bookB.
	
	aCart add: bookA totalUnits: 2.
	aCart add: bookB totalUnits: 3.
	
	self assert: (aCart hasBook: bookA totalUnits: 2).
	self assert: (aCart hasBook: bookB totalUnits: 3).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:08'!
test05CanRemoveBooksFromShoppingCart

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: self catalogueWithBookAandB.
	bookA := self bookA.
	bookB := self bookB.
	
	aCart add: bookA totalUnits: 1.
	aCart remove: bookA totalUnits: 1.
	
	aCart add: bookB totalUnits: 3.
	aCart remove: bookB totalUnits: 2.
	
	self assert: (aCart hasBook: bookB totalUnits: 1).
	self deny: (aCart hasBook: bookA).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test06OnlyCanAddBooksFromCatalogueToShoppingCart

	| aCart bookB |
	
	aCart := ShoppingCart newWith: self catalogueWithBookA.
	
	bookB := self bookB.
		
	self
		should: [ 	aCart add: bookB totalUnits: 1 ]
		raise: Error
		withMessageText: 'Only can add books from catalogue'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test07CannotRemoveUnexistentBooksFromShoppingCart

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self catalogueWithBookA.
	
	bookA := self bookA.
		
	aCart add: bookA totalUnits: 2.
	
	self
		should: [ aCart remove: bookA totalUnits: 3 ]
		raise: Error
		withMessageText: 'Cannot remove unexistent books'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/17/2025 09:43:01'!
test08CannotAddZeroOrNegativeNumberOfBooks

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self catalogueWithBookA.
	
	bookA := self bookA.
	
	self
		should: [ aCart add: bookA totalUnits: -2. ]
		raise: Error
		withMessageText: 'Cannot add 0 or negative number of books'.! !



!classDefinition: #Cashier category: 'TusLibros-com'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList currentDate totalPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!Cashier methodsFor: 'assertions' stamp: 'MN 6/15/2025 22:33:52'!
assertCartIsNotEmpty: aShoppingCart

	^ aShoppingCart isEmpty ifTrue:[
		self error: 'Cannot checkout shopping cart without books.'
	]! !

!Cashier methodsFor: 'assertions' stamp: 'MN 6/16/2025 11:14:03'!
assertCreditCardIsValid: aCreditCard

	^ (aCreditCard isExpiredFor: currentDate) ifTrue:[
		self error: 'Credit card is expired.'
	]! !


!Cashier methodsFor: 'checkout' stamp: 'MN 6/17/2025 10:33:33'!
checkout: aShoppingCart with: aCreditCard 
	
	totalPrice := 0.

	self assertCartIsNotEmpty: aShoppingCart.
	self assertCreditCardIsValid: aCreditCard.

	^ self totalCheckoutPrice: aShoppingCart.! !

!Cashier methodsFor: 'checkout' stamp: 'MN 6/17/2025 10:45:56'!
priceFor: aBook

	^ priceList
		at: aBook
		ifAbsent:[
			self error: 'Book is not in the price list'.
		]! !

!Cashier methodsFor: 'checkout' stamp: 'MN 6/17/2025 10:45:56'!
sumPriceOf: aBook

	| bookPrice |
	
	bookPrice := self priceFor: aBook.
	
	totalPrice := totalPrice + bookPrice.! !

!Cashier methodsFor: 'checkout' stamp: 'MN 6/17/2025 10:33:23'!
totalCheckoutPrice: aShoppingCart

	aShoppingCart totalPriceFor: self.
	
	^ totalPrice.! !


!Cashier methodsFor: 'date' stamp: 'MN 6/16/2025 11:06:47'!
setCurrentDate: aGregorianMonthOfYear

	currentDate := aGregorianMonthOfYear.! !


!Cashier methodsFor: 'initialization' stamp: 'MN 6/17/2025 10:36:43'!
initializeWith: aPriceList
	
	totalPrice := 0.
	priceList := aPriceList.
	currentDate := GregorianMonthOfYear current.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MN 6/15/2025 21:25:09'!
newWith: aPriceList

	^ self new initializeWith: aPriceList.! !


!classDefinition: #CreditCard category: 'TusLibros-com'!
Object subclass: #CreditCard
	instanceVariableNames: 'number ownerName expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CreditCard methodsFor: 'testing' stamp: 'n 6/13/2025 20:46:28'!
isExpired

	^ expirationDate < GregorianMonthOfYear current

! !

!CreditCard methodsFor: 'testing' stamp: 'MN 6/16/2025 11:02:39'!
isExpiredFor: aGregorianDate

	^ expirationDate < aGregorianDate

! !


!CreditCard methodsFor: 'initialization' stamp: 'n 6/13/2025 20:43:45'!
initializeWithNumber: aNumber ownerName: aName expirationDate: aDate.

	number := aNumber.
	ownerName := aName.
	expirationDate := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-com'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'n 6/13/2025 20:42:04'!
withNumber: aNumber ownerName: aName expirationDate: aDate
	
	self assertCardNumberIsInteger: aNumber.
	self assertCardNumberIsStrictlyPositive: aNumber.
	self assertCardNumberIs16DigitsLong: aNumber.
	
	self assertOwnerNameIsString: aName.
	self assertOwnerNameIsMax30CharsLong: aName.
	
	self assertExpirationDateIsGregorianDate: aDate.
	self assertExpirationDateIsafterCurrentDate: aDate.

	^self new initializeWithNumber: aNumber ownerName: aName expirationDate: aDate.! !


!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 19:36:08'!
assertCardNumberIs16DigitsLong: aNumber

	^ aNumber asString size = 16 ifFalse:[
		self error: 'Credit card number must be 16 digits long'.
	]! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 19:34:18'!
assertCardNumberIsInteger: aNumber 
	aNumber isInteger ifFalse: [
		self error: 'Credit card number must be integer'.
	].! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 19:38:13'!
assertCardNumberIsStrictlyPositive: aNumber 
	aNumber strictlyPositive ifFalse: [
		self error: 'Credit card number must be strictly positive'.
	].! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 20:31:45'!
assertExpirationDateIsGregorianDate: aDate

	aDate class = GregorianMonthOfYear ifFalse:[
		self error: 'Expiration date must be gregorian'.
	]! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 20:40:38'!
assertExpirationDateIsafterCurrentDate: aDate

	aDate < GregorianMonthOfYear current ifTrue:[
		self error: 'Expiration date must be after current date'.
	]! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 19:57:37'!
assertOwnerNameIsMax30CharsLong: aName

	^ aName size <= 30 ifFalse:[
		self error: 'Owner name must be max 30 characters long'.
	]! !

!CreditCard class methodsFor: 'assertions' stamp: 'n 6/13/2025 19:53:01'!
assertOwnerNameIsString: aName

	^ aName isString ifFalse: [
		self error: 'Owner name must be string'.
	]! !


!classDefinition: #ShoppingCart category: 'TusLibros-com'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!ShoppingCart methodsFor: 'testing' stamp: 'MN 6/12/2025 11:24:32'!
hasBook: aBook 

	^ books includes: aBook.! !

!ShoppingCart methodsFor: 'testing' stamp: 'MN 6/12/2025 11:05:57'!
hasBook: aBook totalUnits: anAmount 
	
	^ (books occurrencesOf: aBook) = anAmount! !

!ShoppingCart methodsFor: 'testing' stamp: 'MN 6/12/2025 10:29:35'!
isEmpty
	
	^ books isEmpty.! !


!ShoppingCart methodsFor: 'initialization' stamp: 'MN 6/12/2025 11:04:24'!
initialize
	books := Bag new.! !

!ShoppingCart methodsFor: 'initialization' stamp: 'MN 6/12/2025 13:03:50'!
initializeNewWith: aCatalogue 

	catalogue := aCatalogue.! !


!ShoppingCart methodsFor: 'removing' stamp: 'MN 6/12/2025 13:21:26'!
remove: aBook totalUnits: anAmount 
	
	anAmount timesRepeat: [
		books
			remove: aBook
			ifAbsent: [ self error: 'Cannot remove unexistent books' ].
	].! !


!ShoppingCart methodsFor: 'adding' stamp: 'MN 6/15/2025 20:36:04'!
add: aBook totalUnits: anAmount

	self assertBookIsInCatalogue: aBook.
	self assertStrictlyPositiveNumberOfBooks: anAmount.
		
	books add: aBook withOccurrences: anAmount ! !


!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/12/2025 13:16:23'!
assertBookIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse:[ self errorOnlyCanAddBooksFromCatalogue ]! !

!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/15/2025 20:37:01'!
assertStrictlyPositiveNumberOfBooks: anAmount

	^ anAmount strictlyPositive ifFalse:[ self errorCannotAddZeroOrNegativeNumberOfBooks. ]! !

!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/15/2025 20:36:35'!
errorCannotAddZeroOrNegativeNumberOfBooks

	^ self error: 'Cannot add 0 or negative number of books'! !

!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/12/2025 13:16:41'!
errorOnlyCanAddBooksFromCatalogue

	^ self error: 'Only can add books from catalogue'! !


!ShoppingCart methodsFor: 'total price' stamp: 'MN 6/17/2025 10:32:55'!
totalPriceFor: aCashier
	
	books do: [:eachBook |
		aCashier sumPriceOf: eachBook.	
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros-com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'MN 6/12/2025 13:03:40'!
newWith: aCatalogue 

	^self new initializeNewWith: aCatalogue ! !

!classDefinition: #CashierTest category: 'TusLibros-com'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsCreator creditBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CashierTest methodsFor: 'tests' stamp: 'MN 6/20/2025 12:01:48'!
errorMessageMPFailure

	^ 'Error: Could not credit from card'! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:30:36'!
test01TotalCheckoutPriceIsPriceAndSingleUnitOfUniqueBookOfCart

	self
		assertTotalCheckoutPriceIs: 15
		afterDoingForCart: [:aCart |
			aCart add: testObjectsCreator bookA totalUnits: 1. 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:32:00'!
test02TotalCheckoutPriceIsProductOfPriceAndManyUnitsOfUniqueBookOfCart

	self
		assertTotalCheckoutPriceIs: (3*15)
		afterDoingForCart: [:aCart |
			aCart add: testObjectsCreator bookA totalUnits: 3. 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:32:10'!
test03TotalCheckoutPriceIsSumOfPricesOfManyUnitsOfManyBooksOfCart

	self
		assertTotalCheckoutPriceIs: (3*15 + (5*10))
		afterDoingForCart: [:aCart |
			aCart add: testObjectsCreator bookA totalUnits: 3.
			aCart add: testObjectsCreator bookB totalUnits: 5.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:32'!
test04CannotCheckoutCartWithoutBooks

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	
	priceList := testObjectsCreator priceListForBookAandB.
	
	cashier := Cashier newWithPrices: priceList andMP: self.
		
	self
		should: [ cashier checkout: cart with: testObjectsCreator creditCard ]
		raise: Error
		description: 'Cannot checkout shopping cart without books.'! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:32'!
test05CannotCheckoutCartWithExpiredCreditCard

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	cart add: testObjectsCreator bookA totalUnits: 3.
	
	priceList := testObjectsCreator priceListForBookAandB.
	
	cashier := Cashier newWithPrices: priceList andMP: self.
	cashier setCurrentDate: (GregorianMonthOfYear marchOf: (GregorianYear number: 2027)).
		
	self
		should: [ cashier checkout: cart with: testObjectsCreator creditCard ]
		raise: Error
		withExceptionDo: [:error |
			self assert: error messageText equals: 'Credit card is expired.'.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:32'!
test06CannotCheckoutCartWithBooksThatAreNotInThePriceList

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandBandC.
	cart add: testObjectsCreator bookC totalUnits: 3.
	
	priceList := testObjectsCreator priceListForBookAandB.
	
	cashier := Cashier newWithPrices: priceList andMP: self.
		
	self
		should: [ cashier checkout: cart with: testObjectsCreator creditCard ]
		raise: Error
		withExceptionDo: [:error |
			self assert: error messageText equals: 'Book is not in the price list'.
		]! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:32'!
test07CanCheckoutWhenSuccessfullyCreditedWithMP

	| cashier cart creditedAmount creditedCard creditCard |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	cart add: testObjectsCreator bookB totalUnits: 3.
	
	cashier := Cashier
		newWithPrices: testObjectsCreator priceListForBookAandB
		andMP: self.
		
	creditBehaviour := [:aCreditAmount :aCreditCard |
		creditedAmount := aCreditAmount.
		creditedCard := aCreditCard.
	].

	creditCard := testObjectsCreator creditCard.
		
	self assert: (cashier checkout: cart with: creditCard) equals: creditedAmount.
	self assert: creditCard equals: creditedCard.! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:32'!
test08CannotCheckoutWhenFailureCreditedWithMP

	| cashier cart creditCard |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	cart add: testObjectsCreator bookB totalUnits: 3.
	
	cashier := Cashier
		newWithPrices: testObjectsCreator priceListForBookAandB
		andMP: self.
		
	creditBehaviour := [:aCreditAmount :aCreditCard |
		self error: self errorMessageMPFailure.
	].

	creditCard := testObjectsCreator creditCard.
	
	self
		should: [ cashier checkout: cart with: creditCard ]
		raise: Error
		withExceptionDo: [:error |
			self assert: error messageText equals: self errorMessageMPFailure.
		]
		
! !


!CashierTest methodsFor: 'setup' stamp: 'MN 6/20/2025 11:30:16'!
setUp

	testObjectsCreator := TestObjectsCreator new.! !


!CashierTest methodsFor: 'assertions' stamp: 'MN 6/21/2025 14:29:32'!
assertTotalCheckoutPriceIs: aTotalPrice afterDoingForCart: aBlock

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	aBlock value: cart.
	
	priceList := testObjectsCreator priceListForBookAandB.
	
	cashier := Cashier newWithPrices: priceList andMP: self.
	
	self assert: (cashier totalCheckoutPrice: cart) equals: aTotalPrice.! !


!CashierTest methodsFor: 'merchand processor protocol' stamp: 'MN 6/20/2025 11:58:24'!
credit: aTotalPrice from: aCreditCard 
	creditBehaviour value: aTotalPrice value: aCreditCard.! !


!classDefinition: #CreditCardTest category: 'TusLibros-com'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'testObjectsCreator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test01CardNumberMustBe16DigitsLong
		
	self
		should: [CreditCard withNumber: 1234 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be 16 digits long'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test02CardNumberMustBeInteger
	
	self
		should: [ CreditCard withNumber: 'pepe' ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be integer'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test03CardNumberMustBeStrictlyPositive

	self
		should: [ CreditCard withNumber: -111111111111111 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be strictly positive'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test04ExpirationDateIsBeforeCurrentDate
	
	self
		should: [ CreditCard withNumber: -111111111111111 ownerName: 'JOHN DOE' expirationDate: 01/26 ]
		raise: Error - MessageNotUnderstood 
		description: 'Credit card number must be strictly positive'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test05OwnerNameMustBeString

	self
		should: [ CreditCard withNumber: 1111111111111111 ownerName: 1213 expirationDate: 01/24 ]
		raise: Error - MessageNotUnderstood 
		description: 'Owner name must be string'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test06OwnerNameMustBeMax30CharactersLong

	self
		should: [ CreditCard
			withNumber: 1111111111111111
			ownerName: 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'
			expirationDate: 01/24 ]
		raise: Error - MessageNotUnderstood 
		description: 'Owner name must be max 30 characters long'.
	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
test07ExpirationDateMustBeGregorian

	self
		should: [ CreditCard
			withNumber: 1111111111111111
			ownerName: 'JOHN DOE'
			expirationDate: 'pepe']
		raise: Error - MessageNotUnderstood 
		description: 'Expiration date must be gregorian'.

	 ! !

!CreditCardTest methodsFor: 'tests' stamp: 'MN 6/21/2025 14:29:40'!
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


!classDefinition: #ShoppingCartTest category: 'TusLibros-com'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: 'testObjectsCreator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:17'!
test01ShoppingCartShouldStartEmpty

	| cart |
	
	cart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	
	self assert: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:23'!
test02ShoppingCartWithOneBookIsNotEmpty

	| aCart bookA |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	bookA := testObjectsCreator bookA.
	
	aCart add: bookA totalUnits: 1.
	
	self deny: aCart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:31'!
test03BookOfShoppingCartWithOneBookCanBeQueried

	| aCart bookA |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	bookA := testObjectsCreator bookA.
	
	aCart add: bookA totalUnits: 1.
	
	self assert: (aCart hasBook: bookA totalUnits: 1)! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:40'!
test04BooksOfShoppingCartWithManyBooksCanBeQueried

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	bookA := testObjectsCreator bookA.
	bookB := testObjectsCreator bookB.
	
	aCart add: bookA totalUnits: 2.
	aCart add: bookB totalUnits: 3.
	
	self assert: (aCart hasBook: bookA totalUnits: 2).
	self assert: (aCart hasBook: bookB totalUnits: 3).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:44'!
test05CanRemoveBooksFromShoppingCart

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookAandB.
	bookA := testObjectsCreator bookA.
	bookB := testObjectsCreator bookB.
	
	aCart add: bookA totalUnits: 1.
	aCart remove: bookA totalUnits: 1.
	
	aCart add: bookB totalUnits: 3.
	aCart remove: bookB totalUnits: 2.
	
	self assert: (aCart hasBook: bookB totalUnits: 1).
	self deny: (aCart hasBook: bookA).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:52'!
test06OnlyCanAddBooksFromCatalogueToShoppingCart

	| aCart bookB |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	
	bookB := testObjectsCreator bookB.
		
	self
		should: [ 	aCart add: bookB totalUnits: 1 ]
		raise: Error
		withMessageText: 'Only can add books from catalogue'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:56'!
test07CannotRemoveUnexistentBooksFromShoppingCart

	| aCart bookA |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	
	bookA := testObjectsCreator bookA.
		
	aCart add: bookA totalUnits: 2.
	
	self
		should: [ aCart remove: bookA totalUnits: 3 ]
		raise: Error
		withMessageText: 'Cannot remove unexistent books'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/20/2025 11:34:59'!
test08CannotAddZeroOrNegativeNumberOfBooks

	| aCart bookA |
	
	aCart := ShoppingCart newWith: testObjectsCreator catalogueWithBookA.
	
	bookA := testObjectsCreator bookA.
	
	self
		should: [ aCart add: bookA totalUnits: -2. ]
		raise: Error
		withMessageText: 'Cannot add 0 or negative number of books'.! !


!ShoppingCartTest methodsFor: 'setup' stamp: 'MN 6/20/2025 11:33:55'!
setUp

	testObjectsCreator := TestObjectsCreator new.! !


!classDefinition: #TusLibrosInterfaceTest category: 'TusLibros-com'!
TestCase subclass: #TusLibrosInterfaceTest
	instanceVariableNames: 'testObjectsCreator authBehaviour creditBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!TusLibrosInterfaceTest methodsFor: 'setup' stamp: 'MN 6/21/2025 14:55:07'!
setUp 

	testObjectsCreator := TestObjectsCreator new.
! !


!TusLibrosInterfaceTest methodsFor: 'auth and MP protocols' stamp: 'MN 6/21/2025 15:06:21'!
credit: aTotalPrice from: aCreditCard 
	creditBehaviour value: aTotalPrice value: aCreditCard.! !

!TusLibrosInterfaceTest methodsFor: 'auth and MP protocols' stamp: 'MN 6/21/2025 14:37:38'!
logInUsername: aUsername withPassword: aPassword
	^authBehaviour value: aUsername value: aPassword! !


!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'MN 6/21/2025 15:07:18'!
test01NewCartIsCreatedEmpty

	| tusLibrosInterface cartId |
	
	tusLibrosInterface := TusLibrosInterface withAuthenticator: self andMP: self.
	
	authBehaviour := [:aUsername :aPassword | true].
	
	cartId := tusLibrosInterface
		createCartFor: #user
		pass: #password
		catalog: testObjectsCreator catalogueWithBookAandB.
	
	self assert: (tusLibrosInterface listCartId: cartId) isEmpty.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'MN 6/21/2025 15:07:18'!
test02InterfaceListANonEmptyCartCorrectly

	| tusLibrosInterface cartId |
	
	tusLibrosInterface := TusLibrosInterface withAuthenticator: self andMP: self.
	
	authBehaviour := [:aUsername :aPassword | true].
	
	cartId := tusLibrosInterface
		createCartFor: #user
		pass: #password
		catalog: testObjectsCreator catalogueWithBookAandB.
	
	tusLibrosInterface
		add: testObjectsCreator bookA
		totalUnits: 3
		toCartWithId:cartId.
	
	self assert: ((tusLibrosInterface listCartId: cartId) occurrencesOf: testObjectsCreator bookA ) equals: 3.
	
	
	
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'MN 6/21/2025 15:07:18'!
test03CantCreateACartForAnInvalidUser

	| tusLibrosInterface cartId |
	
	tusLibrosInterface := TusLibrosInterface withAuthenticator: self andMP: self.
	
	authBehaviour := [:aUsername :aPassword | false].
	
	self 
		should: [cartId := tusLibrosInterface
			createCartFor: #InvalidUser
			pass: #password
			catalog: testObjectsCreator catalogueWithBookAandB.
		]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: TusLibrosInterface invalidUsernameErrorMessage.
		]
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'MN 6/21/2025 15:07:18'!
test04UserThatNeverBoughtAnythingHasNoPurchases

	| tusLibrosInterface|
	
	tusLibrosInterface := TusLibrosInterface withAuthenticator: self andMP: self.
	
	self assert: (tusLibrosInterface listPurchasesFor: #anUserID) isEmpty.
	! !

!TusLibrosInterfaceTest methodsFor: 'tests' stamp: 'MN 6/21/2025 15:11:08'!
test05UserThatDidBuyBooksHasItInThePurchases

	| tusLibrosInterface cartId|
	
	tusLibrosInterface := TusLibrosInterface withAuthenticator: self andMP: self.
	
	authBehaviour := [:aUsername :aPassword | true].
	creditBehaviour := [:aCreditAmount :aCreditCard | ].
	
	cartId := tusLibrosInterface
		createCartFor: #user
		pass: #password
		catalog: testObjectsCreator catalogueWithBookAandB.
	
	tusLibrosInterface
		add: testObjectsCreator bookA
		totalUnits: 3
		toCartWithId: cartId.
	
	tusLibrosInterface
		checkoutCartWithId: cartId
		withCashier: (testObjectsCreator cashierWithMP: self)
		andCreditCard: testObjectsCreator creditCard.
		
	self assert: ((tusLibrosInterface listCartId: cartId) occurrencesOf: testObjectsCreator bookA ) equals: 3.
	self assert: ((tusLibrosInterface listPurchasesFor: #user) occurrencesOf: testObjectsCreator bookA ) equals: 3.
	! !


!classDefinition: #Cashier category: 'TusLibros-com'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList currentDate totalPrice merchantProcessor'
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


!Cashier methodsFor: 'checkout' stamp: 'MN 6/20/2025 11:57:15'!
checkout: aShoppingCart with: aCreditCard 
	
	totalPrice := 0.

	self assertCartIsNotEmpty: aShoppingCart.
	self assertCreditCardIsValid: aCreditCard.
	
	self totalCheckoutPrice: aShoppingCart.
	
	merchantProcessor credit: totalPrice from: aCreditCard.
	
	^ totalPrice ! !

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


!Cashier methodsFor: 'initialization' stamp: 'MN 6/20/2025 11:47:36'!
initializeWithPrices: aPriceList andMP: aMerchantProcessor
	
	totalPrice := 0.
	priceList := aPriceList.
	merchantProcessor := aMerchantProcessor.
	currentDate := GregorianMonthOfYear current.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MN 6/20/2025 11:48:08'!
newWithPrices: aPriceList andMP: aMerchantProcessor 

	^ self new initializeWithPrices: aPriceList andMP: aMerchantProcessor.! !


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


!ShoppingCart methodsFor: 'accessing' stamp: 'MN 6/21/2025 14:44:04'!
listBooks
	^ books copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros-com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'MN 6/12/2025 13:03:40'!
newWith: aCatalogue 

	^self new initializeNewWith: aCatalogue ! !


!classDefinition: #TestObjectsCreator category: 'TusLibros-com'!
Object subclass: #TestObjectsCreator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:26:43'!
bookA

	^ 'Book A'! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:27:42'!
bookB

	^ 'Book B'! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:27:45'!
bookC

	^ 'Book C'! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/21/2025 15:04:27'!
cashierWithMP: anMP

	^ Cashier
		newWithPrices: self priceListForBookAandB
		andMP: anMP! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:27:50'!
catalogueWithBookA

	^ Set with: self bookA.! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:27:53'!
catalogueWithBookAandB

	^ Set with: self bookA with: self bookB.! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:27:57'!
catalogueWithBookAandBandC
	
	^ Set with: self bookA with: self bookB with: self bookC.! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/21/2025 14:29:40'!
creditCard

	^ CreditCard
		withNumber: 1111222233334444
		ownerName: 'ALAN KAY'
		expirationDate: (GregorianMonthOfYear februaryOf: (GregorianYear number: 2027))! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:29:12'!
pairsOfBooksAndPrices

	^ Array
			with: self bookA
			with: 15
			with: self bookB
			with: 10! !

!TestObjectsCreator methodsFor: 'as yet unclassified' stamp: 'MN 6/20/2025 11:29:23'!
priceListForBookAandB

	^ Dictionary newFromPairs: self pairsOfBooksAndPrices! !


!classDefinition: #TusLibrosInterface category: 'TusLibros-com'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'cartsById userLogInfoDictionary auth merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!TusLibrosInterface methodsFor: 'initialize' stamp: 'MMP 6/17/2025 20:38:00'!
initializeWithAuth: anAuth andMP: aMerchantProcessor

	cartsById := Dictionary new.
	auth := anAuth.
	merchantProcessor := aMerchantProcessor. 
! !


!TusLibrosInterface methodsFor: 'private' stamp: 'MMP 6/17/2025 20:06:08'!
nextCartId
	^ 1! !


!TusLibrosInterface methodsFor: 'carts' stamp: 'MN 6/21/2025 14:53:54'!
add: aBookToAdd totalUnits: anAmount toCartWithId: cartId 
	(self cartWithId: cartId) add: aBookToAdd totalUnits: anAmount.
	
	! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'MN 6/21/2025 14:53:54'!
cartWithId: cartId

	^ cartsById at:cartId! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'MN 6/21/2025 14:37:02'!
createCartFor: aUsername pass: aPassword catalog: aCatalog
	
	| newId |
	
	(auth logInUsername: aUsername withPassword: aPassword) ifFalse: [^self error: self class invalidUsernameErrorMessage]. 
	
	newId := self nextCartId.
	
	cartsById
		at: newId
		put: (ShoppingCart newWith: aCatalog).
		
	^ newId.
		
	! !

!TusLibrosInterface methodsFor: 'carts' stamp: 'MN 6/21/2025 14:53:54'!
listCartId: cartId 
	^ (self cartWithId: cartId) listBooks.! !


!TusLibrosInterface methodsFor: 'purchases' stamp: 'MMP 6/17/2025 20:50:28'!
listPurchasesFor: anUserID

	^OrderedCollection new.! !


!TusLibrosInterface methodsFor: 'checkout' stamp: 'MN 6/21/2025 15:08:42'!
checkoutCartWithId: cartId withCashier: aCashier andCreditCard: aCreditCard 
	
	aCashier checkout: (self cartWithId: cartId) with: aCreditCard.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: 'TusLibros-com'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'error messages' stamp: 'MMP 6/17/2025 20:23:45'!
invalidUsernameErrorMessage

	^'Username is invalid'! !


!TusLibrosInterface class methodsFor: 'instance creation' stamp: 'MN 6/21/2025 15:07:18'!
withAuthenticator: anAuth andMP: aMerchantProcessor

	^self new initializeWithAuth: anAuth andMP: aMerchantProcessor. ! !

!classDefinition: #TusLibrosTest category: #'TusLibros-com'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:11:20'!
createBookA

	^ 'Book A'! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:11:28'!
createBookB

	^ 'Book B'! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:11:33'!
createCatalogueWithBookA

	^ Set with: self createBookA.! !

!TusLibrosTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:11:36'!
createCatalogueWithBookAandB

	^ Set with: self createBookA with: self createBookB.! !


!classDefinition: #CashierTest category: #'TusLibros-com'!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!CashierTest methodsFor: 'tests' stamp: 'MN 6/15/2025 22:36:22'!
test01TotalCheckoutPriceIsPriceAndSingleUnitOfUniqueBookOfCart

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self createCatalogueWithBookA.
	cart add: (self createBookA) totalUnits: 1.
	
	priceList := self createPriceList.
	
	cashier := Cashier newWith: priceList.
	
	self assert: (cashier checkout: cart with: nil) equals: 15.! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/15/2025 22:36:22'!
test02TotalCheckoutPriceIsProductOfPriceAndManyUnitsOfUniqueBookOfCart

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self createCatalogueWithBookA.
	cart add: (self createBookA) totalUnits: 3.
	
	priceList := self createPriceList.
	
	cashier := Cashier newWith: priceList.
	
	self assert: (cashier checkout: cart with: nil) equals: (3 * 15).! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/15/2025 22:36:22'!
test03TotalCheckoutPriceIsSumOfPricesOfManyUnitsOfManyBooksOfCart

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self createCatalogueWithBookAandB .
	cart add: (self createBookA) totalUnits: 3.
	cart add: (self createBookB) totalUnits: 5.
	
	priceList := self createPriceList.
	
	cashier := Cashier newWith: priceList.
	
	self assert: (cashier checkout: cart with: nil) equals: (3 * 15 + (5 * 10)).! !

!CashierTest methodsFor: 'tests' stamp: 'MN 6/15/2025 22:36:22'!
test04CannotCheckoutCartWithoutBooks

	| priceList cashier cart |
		
	cart := ShoppingCart newWith: self createCatalogueWithBookAandB .
	
	priceList := self createPriceList.
	
	cashier := Cashier newWith: priceList.
		
	self
		should: [ cashier checkout: cart with: nil ]
		raise: Error
		description: 'Cannot checkout shopping cart without books.'! !


!CashierTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:42:28'!
createPairsOfBooksAndPrices

	^ Array
			with: self createBookA
			with: 15
			with: self createBookB
			with: 10! !

!CashierTest methodsFor: 'creation' stamp: 'MN 6/15/2025 21:42:21'!
createPriceList

	^ Dictionary newFromPairs: self createPairsOfBooksAndPrices! !


!classDefinition: #ShoppingCartTest category: #'TusLibros-com'!
TusLibrosTest subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:06:25'!
test01ShoppingCartShouldStartEmpty

	| cart |
	
	cart := ShoppingCart newWith: self createCatalogueWithBookA.
	
	self assert: cart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:15:12'!
test02ShoppingCartWithOneBookIsNotEmpty

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookA.
	bookA := self createBookA.
	
	aCart add: bookA totalUnits: 1.
	
	self deny: aCart isEmpty! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:15:07'!
test03BookOfShoppingCartWithOneBookCanBeQueried

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookA.
	bookA := self createBookA.
	
	aCart add: bookA totalUnits: 1.
	
	self assert: (aCart hasBook: bookA totalUnits: 1)! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:15:02'!
test04BooksOfShoppingCartWithManyBooksCanBeQueried

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookAandB.
	bookA := self createBookA.
	bookB := self createBookB.
	
	aCart add: bookA totalUnits: 2.
	aCart add: bookB totalUnits: 3.
	
	self assert: (aCart hasBook: bookA totalUnits: 2).
	self assert: (aCart hasBook: bookB totalUnits: 3).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:14:50'!
test05CanRemoveBooksFromShoppingCart

	| aCart bookA bookB |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookAandB.
	bookA := self createBookA.
	bookB := self createBookB.
	
	aCart add: bookA totalUnits: 1.
	aCart remove: bookA totalUnits: 1.
	
	aCart add: bookB totalUnits: 3.
	aCart remove: bookB totalUnits: 2.
	
	self assert: (aCart hasBook: bookB totalUnits: 1).
	self deny: (aCart hasBook: bookA).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:16:54'!
test06OnlyCanAddBooksFromCatalogueToShoppingCart

	| aCart bookB |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookA.
	
	bookB := self createBookB.
		
	self
		should: [ 	aCart add: bookB totalUnits: 1 ]
		raise: Error
		withMessageText: 'Only can add books from catalogue'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/12/2025 13:21:19'!
test07CannotRemoveUnexistentBooksFromShoppingCart

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookA.
	
	bookA := self createBookA.
		
	aCart add: bookA totalUnits: 2.
	
	self
		should: [ aCart remove: bookA totalUnits: 3 ]
		raise: Error
		withMessageText: 'Cannot remove unexistent books'.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'MN 6/15/2025 20:35:10'!
test08CannotAddZeroOrNegativeNumberOfBooks

	| aCart bookA |
	
	aCart := ShoppingCart newWith: self createCatalogueWithBookA.
	
	bookA := self createBookA.
	
	self
		should: [ aCart add: bookA totalUnits: -2. ]
		raise: Error
		withMessageText: 'Cannot add 0 or negative number of books'.! !



!classDefinition: #Cashier category: #'TusLibros-com'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-com'!

!Cashier methodsFor: 'assertions' stamp: 'MN 6/15/2025 22:33:52'!
assertCartIsNotEmpty: aShoppingCart

	^ aShoppingCart isEmpty ifTrue:[
		self error: 'Cannot checkout shopping cart without books.'
	]! !


!Cashier methodsFor: 'checkout' stamp: 'MN 6/15/2025 22:36:22'!
checkout: aShoppingCart with: aCreditCard 

	self assertCartIsNotEmpty: aShoppingCart.

	^ aShoppingCart calculateTotalPriceWith: priceList. ! !


!Cashier methodsFor: 'initialization' stamp: 'MN 6/15/2025 21:25:25'!
initializeWith: aPriceList

	priceList := aPriceList.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-com'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'MN 6/15/2025 21:25:09'!
newWith: aPriceList

	^ self new initializeWith: aPriceList.! !


!classDefinition: #ShoppingCart category: #'TusLibros-com'!
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


!ShoppingCart methodsFor: 'total price' stamp: 'MN 6/15/2025 22:33:09'!
calculateTotalPriceWith: aPriceList

	^ books sum: [:eachBook | (aPriceList at: eachBook)]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'MN 6/12/2025 13:03:40'!
newWith: aCatalogue 

	^self new initializeNewWith: aCatalogue ! !

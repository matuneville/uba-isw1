!classDefinition: #ShoppingCartTest category: 'TusLibros-com'!
TestCase subclass: #ShoppingCartTest
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


!ShoppingCartTest methodsFor: 'creation' stamp: 'MN 6/12/2025 13:06:11'!
createBookA

	^ #ABook! !

!ShoppingCartTest methodsFor: 'creation' stamp: 'MN 6/12/2025 13:06:14'!
createBookB

	^ #anotherBook! !

!ShoppingCartTest methodsFor: 'creation' stamp: 'MN 6/12/2025 13:06:06'!
createCatalogueWithBookA

	^ Set with: self createBookA.! !

!ShoppingCartTest methodsFor: 'creation' stamp: 'MN 6/12/2025 13:10:46'!
createCatalogueWithBookAandB

	^ Set with: self createBookA with: self createBookB.! !


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


!ShoppingCart methodsFor: 'accessing' stamp: 'MN 6/12/2025 13:00:45'!
list

	! !


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


!ShoppingCart methodsFor: 'adding' stamp: 'MN 6/12/2025 13:15:48'!
add: aBook totalUnits: anAmount

	self assertBookIsInCatalogue: aBook.
		
	books add: aBook withOccurrences: anAmount ! !


!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/12/2025 13:16:23'!
assertBookIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse:[ self errorOnlyCanAddBooksFromCatalogue ]! !

!ShoppingCart methodsFor: 'assertions and errors' stamp: 'MN 6/12/2025 13:16:41'!
errorOnlyCanAddBooksFromCatalogue

	^ self error: 'Only can add books from catalogue'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros-com'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'MN 6/12/2025 13:03:40'!
newWith: aCatalogue 

	^self new initializeNewWith: aCatalogue ! !

!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MN 5/29/2025 15:41:43'!
value
	^ value! !

!AccountTransaction methodsFor: 'value' stamp: 'MN 5/29/2025 15:34:40'!
valueFor: anAccount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MN 5/29/2025 15:21:23'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'MN 5/29/2025 15:35:26'!
valueFor: anAccount

	^ anAccount depositBalanceValueOf: value! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'MN 5/29/2025 15:35:43'!
valueFor: anAccount

	^ anAccount withdrawalBalanceValueOf: value! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'MN 5/29/2025 16:06:28'!
balance
	^accounts sum: [:eachAccount | eachAccount balance ] ifEmpty: [0].! !


!Portfolio methodsFor: 'initialization' stamp: 'MN 5/29/2025 15:51:58'!
initializeNewFor: aCollectionOfAccounts 
	
	accounts := aCollectionOfAccounts.! !


!Portfolio methodsFor: 'modifying' stamp: 'MN 5/29/2025 20:09:06'!
addAccount: anAccount 
	
	self assertCantAddAlreadyPresentAccount: anAccount.
	
	accounts add: anAccount.! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 5/29/2025 20:09:06'!
assertCantAddAlreadyPresentAccount: anAccount

	^ (accounts includes: anAccount) ifTrue: [
		self error: 'Portfolios cannot be added accounts that they already have'.
	]! !


!Portfolio methodsFor: 'testing' stamp: 'MN 5/29/2025 19:29:26'!
hasAnyAccount
	^ accounts isEmpty not.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'MN 5/29/2025 19:44:25'!
assertNoDuplicates: aCollectionOfAccounts

	| hasNoDuplicateAccounts |
	
	hasNoDuplicateAccounts := aCollectionOfAccounts allSatisfy: [:eachAccount |
		(aCollectionOfAccounts occurrencesOf: eachAccount) = 1
	].
	hasNoDuplicateAccounts ifFalse: [
		self error: 'Portfolios cannot have duplicate accounts'.
	]! !

!Portfolio class methodsFor: 'instance creation' stamp: 'MN 5/29/2025 19:43:55'!
newFor: aCollectionOfAccounts
	
	self assertNoDuplicates: aCollectionOfAccounts.

	^ self new initializeNewFor: aCollectionOfAccounts ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MN 5/29/2025 15:36:54'!
balance

	^transactions sum: [ :aTransaction | aTransaction valueFor: self ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MN 5/29/2025 15:36:21'!
depositBalanceValueOf: aDepositValue

	^ aDepositValue ! !

!ReceptiveAccount methodsFor: 'balance' stamp: 'MN 5/29/2025 15:36:39'!
withdrawalBalanceValueOf: aWithdrawalValue

	^ 0-aWithdrawalValue ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 15:55:17'!
test01PortofolioWithoutAccountsHas0Balance
	| portfolio emptyCollection |
	
	emptyCollection := OrderedCollection new.
	
	portfolio := Portfolio newFor: emptyCollection.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 15:51:01'!
test02PortofolioWithOneAccountHasItsOnlyAccountBalanceAsBalance
	| portfolio receptiveAccount collectionOfAccounts |

	receptiveAccount := ReceptiveAccount new.
	collectionOfAccounts := OrderedCollection with: receptiveAccount.
	
	portfolio := Portfolio newFor: collectionOfAccounts.
	
	Deposit register: 100 on: receptiveAccount.
	Withdraw register: 25 on: receptiveAccount.
	
	self assert: portfolio balance equals: 75.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 16:06:09'!
test03PortofolioWithManyAccountHasItsAccountsBalanceSumAsBalance
	| portfolio receptiveAccountOne receptiveAccountTwo receptiveAccountThree collectionOfAccounts |

	receptiveAccountOne := ReceptiveAccount new.
	receptiveAccountTwo := ReceptiveAccount new.
	receptiveAccountThree := ReceptiveAccount new.
	
	collectionOfAccounts := OrderedCollection
		with: receptiveAccountOne
		with: receptiveAccountTwo
		with: receptiveAccountThree.
	
	portfolio := Portfolio newFor: collectionOfAccounts.
	
	Deposit register: 100 on: receptiveAccountOne.
	Withdraw register: 25 on: receptiveAccountOne.
	"Balance 75"
	
	Withdraw register: 25 on: receptiveAccountTwo.
	"Balance -25"
	
	Deposit register: 67 on: receptiveAccountThree.
	"Balance 67"
	
	self assert: portfolio balance equals: (75 - 25 + 67).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 19:58:06'!
test04PortofolioCanStartWithoutAccountsAndThenAddThemAccounts
	| portfolio receptiveAccount emptyCollection |

	receptiveAccount := ReceptiveAccount new.
	emptyCollection := OrderedCollection new.
	
	portfolio := Portfolio newFor: emptyCollection.
	
	portfolio addAccount: receptiveAccount.
	
	self assert: portfolio hasAnyAccount! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 19:44:28'!
test05PortofolioCantBeCreatedWithRepeatedAccounts
	| portfolio receptiveAccount aCollectionOfAccounts |

	receptiveAccount := ReceptiveAccount new.
	
	aCollectionOfAccounts := OrderedCollection
		with: receptiveAccount
		with: receptiveAccount.
		
	self
		should: [ portfolio := Portfolio newFor: aCollectionOfAccounts. ]
		raise: Error
		withMessageText: 'Portfolios cannot have duplicate accounts'.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 20:02:21'!
test06DuplicateAccountsCantBeAddedToPortfolios
	| portfolio receptiveAccount aCollectionOfAccounts |

	receptiveAccount := ReceptiveAccount new.
	
	aCollectionOfAccounts := OrderedCollection
		with: receptiveAccount.
	
	portfolio := Portfolio newFor: aCollectionOfAccounts.
		
	self
		should: [ portfolio addAccount: receptiveAccount. ]
		raise: Error
		withMessageText: 'Portfolios cannot be added accounts that they already have'.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MN 5/29/2025 20:14:05'!
test07PortfoliosCanBeAddedToPortfolio
	| portfolio anotherPortfolio collectionOfPortfolios |

	anotherPortfolio := Portfolio newFor: (OrderedCollection new).
	collectionOfPortfolios := OrderedCollection with: anotherPortfolio.
	
	portfolio := Portfolio newFor: collectionOfPortfolios.
	
	self assert: portfolio hasAnyAccount.! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:07:53'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:07:57'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:01'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:26'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:08:12'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

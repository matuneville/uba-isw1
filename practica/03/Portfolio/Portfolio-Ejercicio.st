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
	instanceVariableNames: 'accounts portfolios parent treeRoots'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'MN 5/31/2025 10:25:23'!
balance

	^ (accounts sum: [:eachAccount | eachAccount balance ] ifEmpty: [0]) +
	(portfolios sum: [:eachAccount | eachAccount balance ] ifEmpty: [0]).! !


!Portfolio methodsFor: 'initialization' stamp: 'MN 6/3/2025 15:21:10'!
initialize
	accounts := Set new.
	portfolios := Set new.
	parent := nil.
	treeRoots := Set new.! !

!Portfolio methodsFor: 'initialization' stamp: 'MN 5/29/2025 15:51:58'!
initializeNewFor: aCollectionOfAccounts 
	
	accounts := aCollectionOfAccounts.! !


!Portfolio methodsFor: 'modifying' stamp: 'MN 5/31/2025 15:41:57'!
addAccount: anAccount 
	
	self assertCantAddAccountAlreadyPresentInTree: anAccount.
		
	accounts add: anAccount.! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 6/3/2025 15:27:40'!
addPortfolio: aPortfolio
	
	self ensureThereIsNoChildrenFrom: aPortfolio.
	
	portfolios add: aPortfolio.

	self addTreeRootsFor: aPortfolio.

! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 6/3/2025 15:21:10'!
addTreeParents: aPortfolio 
	treeRoots addAll: aPortfolio.! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 6/3/2025 15:21:10'!
addTreeRootsFor: aPortfolio

	^ (treeRoots isEmpty) ifTrue:[
		aPortfolio addTreeParents: (Set with: self).
	] ifFalse: [
		aPortfolio addTreeParents: treeRoots.
	]! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 6/3/2025 15:27:20'!
ensureThereIsNoChildrenFrom: aPortfolio

	^ (treeRoots isEmpty) ifTrue:[
		self assertDoesNotIncludesChildPortfolioFrom: aPortfolio.
	] ifFalse: [
		treeRoots do: [:eachParent|
			eachParent assertDoesNotIncludesChildPortfolioFrom: aPortfolio.
		].
	]! !

!Portfolio methodsFor: 'modifying' stamp: 'MN 5/31/2025 12:35:28'!
setAsParent: aPortfolio

	parent := aPortfolio.! !



!Portfolio methodsFor: 'assertions' stamp: 'MN 5/31/2025 12:28:47'!
assertCantAddAccountAlreadyPresentInTree: anAccount

	^ (accounts includes: anAccount) ifTrue: [
		self error: 'Portfolios cannot be added accounts that they already have'.
	]! !

!Portfolio methodsFor: 'assertions' stamp: 'MN 6/3/2025 15:22:31'!
assertCantAddPortfolioAlreadyPresentInTree: aPortfolio 
	treeRoots assertDoesNotIncludesChildPortfolioFrom: aPortfolio.! !

!Portfolio methodsFor: 'assertions' stamp: 'MN 6/3/2025 15:24:08'!
assertDoesNotIncludesChildPortfolioFrom: aPortfolio
	
	self == aPortfolio ifTrue:[
		self errorPortfoliosCannotContainThemselvesInTheTree.
	].

	((aPortfolio getChildrenPortfolios) includes: self) ifTrue:[
		self errorPortfoliosCannotContainThemselvesInTheTree.
	].
	
	portfolios do:[:eachPortfolioChild |
		eachPortfolioChild == aPortfolio ifTrue:[
			self errorPortfoliosCannotContainThemselvesInTheTree.
		]
		ifFalse:[
			eachPortfolioChild assertDoesNotIncludesChildPortfolioFrom: aPortfolio.
		].
	].! !

!Portfolio methodsFor: 'assertions' stamp: 'MN 6/1/2025 20:10:20'!
errorPortfoliosCannotContainThemselvesInTheTree

	^ self error: 'Portfolios cannot contain themselves in the tree'! !


!Portfolio methodsFor: 'private' stamp: 'MN 6/3/2025 15:26:06'!
getChildrenPortfolios

	| children |
	
	children := Set new.
	
	portfolios do: [:eachPortfolio |
		children add: eachPortfolio.
		children addAll: (eachPortfolio getChildrenPortfolios).
	].

	^ children.! !

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

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:01:23'!
test01PortofolioWithoutAccountsHas0Balance
	| portfolio emptyCollection |
	
	emptyCollection := OrderedCollection new.
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:05:49'!
test02PortofolioWithOneAccountHasItsOnlyAccountBalanceAsBalance
	| portfolio account |

	account := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 25 on: account.
	
	self assert: portfolio balance equals: 75.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:05:36'!
test03PortofolioWithManyAccountHasItsAccountsBalanceSumAsBalance
	| portfolio accountOne accountTwo accountThree |

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio
		addAccount: accountOne;
		addAccount: accountTwo;
		addAccount: accountThree.
	
	Deposit register: 100 on: accountOne.
	Withdraw register: 25 on: accountOne.
	
	Withdraw register: 25 on: accountTwo.
	
	Deposit register: 67 on: accountThree.
	
	self
		assert: portfolio balance
		equals: (accountOne balance + accountTwo balance + accountThree balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:07:22'!
test04PortfoliosCantBeAddedDuplicateAccounts
	| portfolio account |

	account := ReceptiveAccount new.

	portfolio := Portfolio new.
		
	self
		should: [ portfolio addAccount: account; addAccount: account. ]
		raise: Error
		withMessageText: 'Portfolios cannot be added accounts that they already have'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:20:14'!
test05PortfolioWithOnePortfolioHasItsOnlyPortfolioBalanceAsBalance
	| portfolioContained portfolioContainer account |

	account := ReceptiveAccount new.
	
	portfolioContained := Portfolio new.
	portfolioContainer := Portfolio new.
	
	portfolioContained addAccount: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 25 on: account.
	
	portfolioContainer addPortfolio: portfolioContained.
	
	self
		assert: portfolioContainer balance
		equals: portfolioContained balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:38:24'!
test06PortfolioWithManyPortfoliosAndManyAccountsHasItsBalanceSumAsBalance
	| portfolioOne portfolioTwo portfolioThree accountOne accountTwo accountThree accountFour |
	
	"
		__P1__
	  /   |  \
	 P2  a3  P3
	 |       / \ 
	a1      a2 a4
	"

	accountOne := ReceptiveAccount new.
	accountTwo := ReceptiveAccount new.
	accountThree := ReceptiveAccount new.
	accountFour := ReceptiveAccount new.
	
	portfolioTwo := Portfolio new.
	portfolioOne := Portfolio new.
	portfolioThree := Portfolio new.
	
	portfolioTwo addAccount: accountOne.
	portfolioThree addAccount: accountTwo; addAccount: accountFour.
	portfolioOne addAccount: accountThree.
	
	Deposit register: 100 on: accountOne.
	Withdraw register: 25 on: accountOne.
	
	Deposit register: 80 on: accountTwo.
	
	Withdraw register: 15 on: accountThree.
	
	Deposit register: 50 on: accountFour.
	Withdraw register: 10 on: accountFour.
		
	portfolioOne
		addPortfolio: portfolioTwo;
		addPortfolio: portfolioThree.
	
	self
		assert: portfolioOne balance
		equals: (portfolioTwo balance + portfolioThree balance + accountThree balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 10:40:45'!
test07PortfolioCantBeAddedHimself
	| portfolio |

	portfolio := Portfolio new.
		
	self
		should: [ portfolio addPortfolio: portfolio. ]
		raise: Error
		withMessageText: 'Portfolios cannot contain themselves in the tree'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 5/31/2025 15:50:21'!
test08PortfolioCantBeAddedHimselfDeeperInTheTree
	| portfolio anotherPortfolio |
	"
	P1 --> P2 --> P1
	"

	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio.
		
	self
		should: [ anotherPortfolio addPortfolio: portfolio. ]
		raise: Error
		withMessageText: 'Portfolios cannot contain themselves in the tree'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'MN 6/1/2025 20:21:48'!
test09PortfolioCantMakeANewTreeWithDuplicatePortfolios
	| p1 p2 p3 p4 p5 |
	"
	P3------> P5
	   \--> P2
	
	P1 --> P2 --> P4
	
	
        P3----> P5
	   /   \--> P2
	P5	     
      \
		P1 --> P2 --> P4
	"

	p1 := Portfolio new.
	p2 := Portfolio new.
	p3 := Portfolio new.
	p4 := Portfolio new.
	p5 := Portfolio new.
	
	p1 addPortfolio: p2.
	p2 addPortfolio: p4.
	p3 addPortfolio: p2.
	p3 addPortfolio: p5.
	
	self
		should: [ p5 addPortfolio: p1. ]
		raise: Error
		withMessageText: 'Portfolios cannot contain themselves in the tree'.! !


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

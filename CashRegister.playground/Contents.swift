import XCTest

class CashRegister {
    var availableFunds: Decimal
    var transactionTotal: Decimal = 0
    
    init(availableFunds: Decimal) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ cost: Decimal) {
        transactionTotal += cost
    }
    
    func acceptCashPayment(_ cash: Decimal) {
        transactionTotal -= cash
        availableFunds += cash
    }
}

class CashRegisterTests: XCTestCase {
    var availableFunds: Decimal!
    var itemCost: Decimal!
    var payment: Decimal!
    
    var sut: CashRegister!
    
    override func setUp() {
        super.setUp()
        availableFunds = 100
        itemCost = 42
        payment = 40
        sut = CashRegister(availableFunds: availableFunds)
    }
    
    override func tearDown() {
        availableFunds = nil
        itemCost = nil
        payment = nil
        sut = nil
        super.tearDown()
    }
    
    func testInitAvailableFunds_setAvailableFunds() {
        XCTAssertEqual(sut.availableFunds, availableFunds)
    }
    
    func testAddItem_oneItem_addsCostToTransactionTotal() {
        sut.addItem(itemCost)
        XCTAssertEqual(sut.transactionTotal, itemCost)
    }
    
    func testAddItem_twoItems_addsCostsToTransactionTotal() {
        let itemCost2 = Decimal(20)
        let expectedTotal = itemCost + itemCost2
        sut.addItem(itemCost)
        sut.addItem(itemCost2)
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptCashPayment_subtractsPaymentFromTransactionTotal() {
        givenTransactionInProgress()
        let expected = sut.transactionTotal - payment
        sut.acceptCashPayment(payment)
        XCTAssertEqual(sut.transactionTotal, expected)
    }
    
    func testAcceptCashPayment_addsPaymentToAvailableFunds() {
        givenTransactionInProgress()
        let expected = sut.availableFunds + payment
        sut.acceptCashPayment(payment)
        XCTAssertEqual(sut.availableFunds, expected)
    }
    
    private func givenTransactionInProgress() {
        sut.addItem(50)
        sut.addItem(100)
    }
}

CashRegisterTests.defaultTestSuite.run()

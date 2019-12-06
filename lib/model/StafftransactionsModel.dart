class StaffTransactionModel{
  String product;
  String network;
  String phoneno;
  String amount;
  String discount;
  String timed;
  String category;
  String status_code;
  String status;
  String txref;

  StaffTransactionModel({this.product, this.network, this.phoneno, this.amount,
    this.discount, this.timed, this.category, this.status_code, this.status, this.txref});

}

List<StaffTransactionModel> getTransact() {
  List<StaffTransactionModel> getTrans = [
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
    discount: '2000', network: 'MTN', phoneno: 'GTBank', status_code: '1',
    timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'GLO', phoneno: 'GTBank', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'AIRTEL', phoneno: 'WEMA', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'AIRTEL', phoneno: 'FIRSTBANK', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'MTN', phoneno: 'FIRSTBANK', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'GLO', phoneno: 'GTBANK', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'AIRTEL', phoneno: 'ACCESS BANK', status_code: '1',
        timed: '2324344', txref: '2233232'),
    StaffTransactionModel(status: 'true', product: 'product', amount: '2000', category: 'Category',
        discount: '2000', network: 'AIRTEL', phoneno: 'WEMA BANK', status_code: '1',
        timed: '2324344', txref: '2233232'),
  ];
  return getTrans;
}
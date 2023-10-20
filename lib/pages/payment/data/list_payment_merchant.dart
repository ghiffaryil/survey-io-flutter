import 'package:survey_io/pages/payment/models/payment_merchant_model.dart';

class ListPaymentMerchant {
  static List<PaymentMerchantModel> getPaymentMerchantList() {
    return [
      PaymentMerchantModel(
          id: 1,
          merchantName: 'BCA Virtual Account',
          merchantType: 'bank',
          merchantLogo: 'assets/icons/icon_bank_bca.png'),
      PaymentMerchantModel(
          id: 2,
          merchantName: 'BNI Virtual Account',
          merchantType: 'bank',
          merchantLogo: 'assets/icons/icon_bank_bri.png'),
      PaymentMerchantModel(
          id: 3,
          merchantName: 'Mandiri Virtual Account',
          merchantType: 'bank',
          merchantLogo: 'assets/icons/icon_bank_mandiri.png'),
      PaymentMerchantModel(
          id: 4,
          merchantName: 'CIMB Virtual Account',
          merchantType: 'bank',
          merchantLogo: 'assets/icons/icon_bank_cimb.png'),
      PaymentMerchantModel(
          id: 5,
          merchantName: 'BRI Virtual Account',
          merchantType: 'bank',
          merchantLogo: 'assets/icons/icon_bank_bri.png'),
      PaymentMerchantModel(
          id: 6,
          merchantName: 'GoPay',
          merchantType: 'ewallet',
          merchantLogo: 'assets/icons/icon_ewallet_gopay.png'),
      PaymentMerchantModel(
          id: 7,
          merchantName: 'OVO',
          merchantType: 'ewallet',
          merchantLogo: 'assets/icons/icon_ewallet_ovo.png'),
      PaymentMerchantModel(
          id: 8,
          merchantName: 'DANA',
          merchantType: 'ewallet',
          merchantLogo: 'assets/icons/icon_ewallet_dana.png'),
      PaymentMerchantModel(
          id: 9,
          merchantName: 'ShopeePay',
          merchantType: 'ewallet',
          merchantLogo: 'assets/icons/icon_ewallet_shopeepay.png'),
    ];
  }
}

class SubAccountModel {
    String account_bank;
    String account_number;
    String business_name;
    String business_contact_mobile;

    SubAccountModel({this.account_bank, this.account_number, this.business_name, this.business_contact_mobile});

    SubAccountModel.fromJson(Map<String, dynamic> json) {
        account_bank = json['account_bank'];
        account_number = json['account_number'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bankName'] = this.account_bank;
        data['account_number'] = this.account_number;
        return data;
    }

}
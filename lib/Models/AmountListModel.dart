class amountlistmodel {
  int id;
  int userId;
  int amount;
  String message;
  int status;
  int viewed;
  String createdAt;
  String updatedAt;

  amountlistmodel(
      {this.id,
        this.userId,
        this.amount,
        this.message,
        this.status,
        this.viewed,
        this.createdAt,
        this.updatedAt});

  amountlistmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    message = json['message'];
    status = json['status'];
    viewed = json['viewed'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['message'] = this.message;
    data['status'] = this.status;
    data['viewed'] = this.viewed;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
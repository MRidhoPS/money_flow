class TotalAmount{
  final String amount;

  TotalAmount({required this.amount});

  factory TotalAmount.fromJson(Map<String, dynamic> json){
    return TotalAmount(amount: json['total_amount']);
  }
}


class Users {
  int? userId;
  final String username;
  final String email;
  final String password;

  Users({
    this.userId,
    required this.username,
    required this.email,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

class Incomes {
  int? incomesId;
  int? userId;
  final int amount;
  final String description;
  String? date;

  Incomes({
    this.incomesId,
    this.userId,
    required this.amount,
    required this.description,
    this.date,
  });

  factory Incomes.fromJson(Map<String, dynamic> json) {
    return Incomes(
        userId: json['user_id'],
        incomesId: json['income_id'],
        amount: json['amount'],
        description: json['description'],
        date: json['date']);

    /** Return jsonnya seperti ini
    * {
    "message": "Get Data Success",
    "user_id": "1",
    "totalIncomes": {
        "total_amount": "435000"
    },
    "data": [
        {
            "user_id": 1,
            "expense_id": 13,
            "amount": 400000,
            "description": "Beli Bensin",
            "date": "2024-07-29"
        },
        {
            "user_id": 1,
            "expense_id": 14,
            "amount": 35000,
            "description": "Beli Kuota",
            "date": "2024-07-29"
        }
    ]
}
    cara parsing jsonnya harus sperti yang diatas
    */
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'amount': amount,
      'description': description,
      'date': date
    };

    /** Data yang di store harus seperti ini
     * {
            "user_id":"1",
            "amount":20000,
            "description":"Beli kuota",
            "date": "2015-07-24"
        }
     */
  }

  Map<String, dynamic> editJson() {
    return {
      'income_id': incomesId,
      'user_id': userId,
      'amount': amount,
      'description': description,
      'date': date,
    };


    /** Data yang harus di store ketika update harus sperti ini
     * {
            "amount":200000,
            "description":"Bayar Listrik"
        }

        ditambah dengan url {{baseUrl}}updateDataUsers/$userId/$expenseId
     */
  }
}

class Expenses{
  int? expenseId;
  int? userId;
  final int amount;
  final String description;
  String? date;

  Expenses({
    this.expenseId,
    this.userId,
    required this.amount,
    required this.description,
    this.date,
  });

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
        userId: json['user_id'],
        expenseId: json['expense_id'],
        amount: json['amount'],
        description: json['description'],
        date: json['date']);

    /** Return jsonnya seperti ini
    * {
    "message": "Get Data Success",
    "user_id": "1",
    "totalIncomes": {
        "total_amount": "435000"
    },
    "data": [
        {
            "user_id": 1,
            "expense_id": 13,
            "amount": 400000,
            "description": "Beli Bensin",
            "date": "2024-07-29"
        },
        {
            "user_id": 1,
            "expense_id": 14,
            "amount": 35000,
            "description": "Beli Kuota",
            "date": "2024-07-29"
        }
    ]
}
    cara parsing jsonnya harus sperti yang diatas
    */
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'amount': amount,
      'description': description,
      'date': date
    };

    /** Data yang di store harus seperti ini
     * {
            "user_id":"1",
            "amount":20000,
            "description":"Beli kuota",
            "date": "2015-07-24"
        }
     */
  }

  Map<String, dynamic> editJson() {
    return {
      // 'expense_id': expenseId,
      // 'user_id': userId,
      // 'amount': amount,
      // 'description': description,
      // 'date': date,

      'amount': amount,
      'description': description,
    };

    /** Data yang harus di store ketika update harus sperti ini
     * {
            "amount":200000,
            "description":"Bayar Listrik"
        }

        ditambah dengan url {{baseUrl}}updateDataUsers/$userId/$expenseId
     */
  }
}

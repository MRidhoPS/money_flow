// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:money_flow/api/url_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_models.dart';
import 'package:http/http.dart' as http;

class ApiUser {
  UrlAddress urlAddress = UrlAddress();

  parsingUrl(String url) {
    final Uri uri = Uri.parse(url);
    return uri;
  }

  Future<void> createAccount(Users users) async {
    final url = parsingUrl(urlAddress.createAccount);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(users.toJson()),
      );

      if (response.statusCode == 201) {
        print('Berhasil Buat akun');
      } else {
        print('Gagal Register akun: ${response.statusCode}');
        throw Exception('Gagal Register akun');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Terjadi kesalahan saat mencoba mendaftarkan akun');
    }
  }

  Future<Map<String, dynamic>> loginAccount(
    String email,
    String password,
  ) async {
    final url = parsingUrl(urlAddress.login);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseLogin = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('user_id', responseLogin['user']['user_id']);
        return responseLogin;
      } else {
        print('Gagal Login akun: ${response.statusCode}');
        throw Exception('Gagal Login akun');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Terjadi kesalahan saat mencoba login akun');
    }
  }

  // get incomes and expenses
  Future<List<Expenses>> getUserExpenses(int userId) async {
    final url = parsingUrl('${urlAddress.getUserExpenses}/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRes = jsonDecode(response.body);
      List<dynamic> data = jsonRes['data'];
      List<Expenses> result = data.map((e) => Expenses.fromJson(e)).toList();
      return result;
    } else {
      throw Exception('Failed to load expenses');
    }
  }

  Future<List<Incomes>> getUserIncomes(int userId) async {
    final url = parsingUrl('${urlAddress.getUserIncomes}/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRes = jsonDecode(response.body);
      List<dynamic> data = jsonRes['data'];
      List<Incomes> result = data.map((e) => Incomes.fromJson(e)).toList();
      return result;
    } else {
      throw Exception('Failed to load Incomes');
    }
  }

  Future<dynamic> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // create incomes and expenses
  Future<void> createExpense(Expenses expenses) async {
    final url = parsingUrl('${urlAddress.createUserExpenses}/${expenses.userId}');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(expenses.toJson()),
      );

      if (response.statusCode == 201) {
        print('Data berhasil disisipkan');
      } else {
        print('Gagal menyisipkan data: ${response.statusCode}');
        throw Exception('Gagal menyisipkan data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Terjadi kesalahan saat mencoba menyisipkan data');
    }
  }

  Future<void> createIncome(Incomes incomes) async {
    final url =
        parsingUrl('${urlAddress.createUserIncomes}/${incomes.userId}');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(incomes.toJson()),
      );

      if (response.statusCode == 201) {
        print('Data berhasil disisipkan');
      } else {
        print('Gagal menyisipkan data: ${response.statusCode}');
        throw Exception('Gagal menyisipkan data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Terjadi kesalahan saat mencoba menyisipkan data');
    }
  }

  // delete incomes and expenses
  Future<void> deleteExpense(int? userId, int? expenseId) async {
    final uri = parsingUrl('${urlAddress.deleteUserExpenses}/$userId/$expenseId');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  Future<void> deleteIncome(int? userId, int? incomeId) async {
    final uri =
        parsingUrl('${urlAddress.deleteUserIncomes}/$userId/$incomeId');
    final response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data: ${response.body}');
    }
  }

  // edit income and expenses
  Future<void> editExpense(Expenses expenses) async {
    final uri = parsingUrl(
      '${urlAddress.editUserExpenses}/${expenses.userId}/${expenses.expenseId}',
    );
    final response = await http.patch(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(expenses.editJson()));
    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    } else {
      print(response.body);
    }
  }

  Future<void> editIncome(Incomes incomes) async {
    final uri = parsingUrl(
      '${urlAddress.editUserIncomes}/${incomes.userId}/${incomes.incomesId}',
    );
    final response = await http.patch(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(incomes.editJson()));
    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    } else {
      print(response.body);
    }
  }
}

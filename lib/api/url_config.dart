class UrlAddress {
  // for web http://192.168.18.17
  final String baseAddress = 'http://192.168.18.17:4000/api';

  // regist dan login
  final String createAccount = 'http://192.168.18.17:4000/api/createUser';
  final String login = 'http://192.168.18.17:4000/api/login';

  // get expenses dan incomes
  final String getUserExpenses = 'http://192.168.18.17:4000/api/getDataExpense';
  final String getUserIncomes = 'http://192.168.18.17:4000/api/getDataIncome';

  // create data incomes dan expenses
  final String createUserExpenses = 'http://192.168.18.17:4000/api/createExpense';
  final String createUserIncomes = 'http://192.168.18.17:4000/api/createIncome';

  // edit data expense dan incomes
  final String editUserExpenses =
      'http://192.168.18.17:4000/api/updateUsersExpenses';
  final String editUserIncomes = 'http://192.168.18.17:4000/api/updateUsersIncomes';

  // delete data expenses dan incomes
  final String deleteUserExpenses =
      'http://192.168.18.17:4000/api/deleteUsersExpenses';
  final String deleteUserIncomes =
      'http://192.168.18.17:4000/api/deleteUsersIncomes';

  // for mobile http://10.0.2.2:5000
  // final String baseAddress = 'http://10.0.2.2:4000/api';

  // // regist dan login
  // final String createAccount = 'http://10.0.2.2:4000/api/createUser';
  // final String login = 'http://10.0.2.2:4000/api/login';

  // // get expenses dan incomes
  // final String getUserExpenses = 'http://10.0.2.2:4000/api/getDataExpense';
  // final String getUserIncomes = 'http://10.0.2.2:4000/api/getDataIncome';

  // // create data incomes dan expenses
  // final String createUserExpenses = 'http://10.0.2.2:4000/api/createExpense';
  // final String createUserIncomes = 'http://10.0.2.2:4000/api/createIncome';

  // // edit data expense dan incomes
  // final String editUserExpenses = 'http://10.0.2.2:4000/api/updateUsersExpenses';
  // final String editUserIncomes = 'http://10.0.2.2:4000/api/updateUsersIncomes';


  // // delete data expenses dan incomes
  // final String deleteUserExpenses = 'http://10.0.2.2:4000/api/deleteUsersExpenses';
  // final String deleteUserIncomes = 'http://10.0.2.2:4000/api/deleteUsersIncomes';

}

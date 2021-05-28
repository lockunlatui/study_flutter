import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[200],
          accentColor: Colors.orangeAccent[400],
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];

  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  bool _isShowChart = false;

  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chooseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chooseDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final appBar = AppBar(
    title: Text(
      'Expense App',
      style: TextStyle(fontFamily: 'Open Sans'),
    ),
    actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
  );

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final txWidgetList = Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    final chartWidget = Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            0.3,
        child: Chart(_recentTransactions));
    final chartWidgetLandscape = Container(
        height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height) *
            0.6,
        child: Chart(_recentTransactions));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            isLandscape
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show Chart'),
                      Switch(
                          value: _isShowChart,
                          onChanged: (value) {
                            setState(() {
                              _isShowChart = value;
                            });
                          })
                    ],
                  )
                : SizedBox(),
            !isLandscape ? chartWidget : SizedBox(),
            !isLandscape ? txWidgetList : SizedBox(),
            isLandscape
                ? _isShowChart
                    ? chartWidgetLandscape
                    : txWidgetList
                : SizedBox()
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

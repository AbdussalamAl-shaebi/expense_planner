import 'package:intl/intl.dart';

import 'widgets/transation_list.dart';
import 'widgets/new_transactions.dart';
import 'package:flutter/material.dart';
import 'models/transation_model.dart';
import 'widgets/Chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                //headline1: TextStyle(color: Colors.red),
                //headline2: TextStyle(color: Colors.red),
                //headline3: TextStyle(color: Colors.red),
                //headline4: TextStyle(color: Colors.red),
                //headline5: TextStyle(color: Colors.red),
                //subtitle1: TextStyle(color: Colors.red),
                //subtitle2: TextStyle(color: Colors.red),
                //bodyText1: TextStyle(color: Colors.red),
                //bodyText2: TextStyle(color: Colors.red),
                //caption: TextStyle(color: Colors.red),
                //button: TextStyle(color: Colors.red),
                //overline: TextStyle(color: Colors.red),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(title: 'Expense Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();

  final amoutController = TextEditingController();

  void _startAddnewTransction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(
              addTrasationMethod: _addTransation,
            ),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  final List<TransactionModel> _userTransations = [
    // TransactionModel(
    //   id: "1",
    //   title: "New Shose",
    //   amount: 15.23,
    //   date: DateTime.now(),
    // ),
    // TransactionModel(
    //   id: "3",
    //   title: "Choseer",
    //   amount: 50.06,
    //   date: DateTime.now(),
    // )
  ];

  List<TransactionModel> get _recentTransactions {
    return _userTransations
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(Duration(days: 7)),
          ),
        )
        .toList();
  }

  void _addTransation(String inTitle, double inAmout, DateTime date) {
    final tran = TransactionModel(
        title: inTitle,
        amount: inAmout,
        date: date,
        id: DateTime.now().toString());
    setState(() {
      _userTransations.add(tran);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransations.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddnewTransction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Container(
                  child: Chart(_recentTransactions),
                ),
              ),
              _userTransations.isEmpty
                  ? Container(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "No teansaction loaded yet",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 120,
                            child: Image.asset(
                              'assets/images/waiting.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    )
                  : TransctionList(
                      userTransations: _userTransations,
                      deleteTransaction: _deleteTransaction,
                    ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddnewTransction(context),
      ),
    );
  }
}

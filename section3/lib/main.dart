import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:section3/widgets/chart.dart';
import 'package:section3/widgets/new_transaction.dart';
import 'package:section3/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  // LandScapeを許可しない設定
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // fontFamily: 'yuzupop',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
            (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime picked) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: picked,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Widget> _buildLandWidgets(bool _showChart) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ShowChart'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) => setState(() {
                    _showChart = val;
                  })),
        ],
      ),
      _showChart
          ? Container(
              color: Colors.blue,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Chart(_userTransactions),
            )
          : Expanded(
              child: TransactionList(_recentTransactions, _deleteTransaction),
            )
    ];
  }

  List<Widget> _buildHoriWidgets(MediaQueryData mediaquery) {
    return [
      Container(
        color: Colors.blue,
        child: Chart(_userTransactions),
        width: double.infinity,
        height: mediaquery.size.height * 0.2,
      ),
      Expanded(
        child: TransactionList(_recentTransactions, _deleteTransaction),
      ),
    ];
  }

  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  didChangeAppLifeCycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaquery = MediaQuery.of(context);
    final isLand = mediaquery.orientation == Orientation.landscape;

    var pageBody = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (isLand) ..._buildLandWidgets(_showChart),
        if (!isLand) ..._buildHoriWidgets(mediaquery),
      ],
    );
    bool ios = false;

    var appbar = ios
        ? CupertinoNavigationBar(
            middle: Text('ios app bar'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddTransaction(context),
                )
              ],
            ))
        : AppBar(
            title: Text('家計簿'),
            actions: [
              IconButton(
                onPressed: () => _startAddTransaction(context),
                icon: Icon(Icons.add),
              )
            ],
          );
    return ios
        ? CupertinoPageScaffold(child: pageBody)
        : Scaffold(
            appBar: appbar as PreferredSizeWidget,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddTransaction(context),
                  ),
          );
  }
}

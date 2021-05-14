
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily:'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          
           ),
           button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title:TextStyle(
              fontFamily: 'Quicksand',
              fontSize:20,
              fontWeight:FontWeight.bold
            )
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1',
    //     title: 'New shoes',
    //     amount: 16.69, 
    //     date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly groceries',
    //     amount: 19.69,
    //     date: DateTime.now())
  ];

List<Transaction> get _recentTransaction{
  return _userTransaction.where((tx){
    return tx.date.isAfter(
      DateTime.now().subtract(
        Duration(days:7),
      )
    );
  }).toList();
}

void _addNewTransaction(String txTitle,double txAmount,DateTime chosenDate){
  final newTx=Transaction(
    title: txTitle,
    amount: txAmount,
    date:chosenDate,
    id:DateTime.now().toString(),
  );

  setState(() {
    _userTransaction.add(newTx);
  });
}

void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_){
      return NewTransaction(_addNewTransaction);
    },);
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id ==id);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Padding(
          padding: EdgeInsetsDirectional.only(start:10),
          child: Text('Personal Expense',style: TextStyle(fontFamily: 'Open Sans'),)),
        actions: [
          IconButton(icon: Icon(Icons.add,color: Colors.white,), onPressed:()=> _startAddNewTransaction(context),)
        ],
      ),
      body:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
           children:[
             Chart(_recentTransaction),
         TransactionList(_userTransaction,_deleteTransaction)
           ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:()=> _startAddNewTransaction(context),
      ),
      );
  }
}

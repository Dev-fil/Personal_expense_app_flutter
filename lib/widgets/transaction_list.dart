import 'package:Expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction,this.deleteTx);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
          child:transaction.isEmpty?
          Center(
            child: Column(children: [
              SizedBox(height: 20,),
              Text('No Transactions added yet!',style:Theme.of(context).textTheme.title,),
                SizedBox(height: 30,),
              Image.asset('assets/images/empty.png',height: 200,),
            ],),
          ): ListView.builder(
            itemBuilder: (ctx,index){
           return Card(
             elevation: 5,
             margin: EdgeInsets.symmetric(
               vertical:8,
               horizontal:5,
             ),
                        child: ListTile(leading:CircleAvatar(radius:30,
             child:Padding(
               padding: EdgeInsets.all(10),
                          child: FittedBox(
                 child: Text('\$${transaction[index].amount}')),
             ),
             ),
             title:Text(transaction[index].title,
             style:Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transaction[index].date)
              ),
              trailing: IconButton(icon: Icon(Icons.delete),color:Theme.of(context).errorColor,
              onPressed: ()=>deleteTx(transaction[index].id),
              ),
             ),
           );
            },
            itemCount:transaction.length,
              ),
    );
    
  }
}

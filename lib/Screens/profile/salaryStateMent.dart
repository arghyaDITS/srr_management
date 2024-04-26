
import 'package:flutter/material.dart';
import 'package:srr_management/components/dataBase.dart';
import 'package:srr_management/theme/style.dart';

class SalaryStatement extends StatefulWidget {
  const SalaryStatement({Key? key}) : super(key: key);

  @override
  State<SalaryStatement> createState() => _SalaryStatementState();
}

class _SalaryStatementState extends State<SalaryStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salary Statement'),
      ),
      body: ListView.builder(
        itemCount: salaryStatements.length,
        itemBuilder: (context, index){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: roundedContainerDesign(context),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Salary Pay'),
                      Text(salaryStatements[index].date),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Basic'),
                            Divider(thickness: 1),
                            Text('₹${salaryStatements[index].basic}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Overtime'),
                            Divider(thickness: 1),
                            Text('₹${salaryStatements[index].overtime}'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Loan'),
                            Divider(thickness: 1),
                            Text('₹${salaryStatements[index].loan}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      Text('₹${salaryStatements[index].total}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

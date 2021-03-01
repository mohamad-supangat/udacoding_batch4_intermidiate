import 'package:flutter/material.dart';

import 'form_action.dart';
import '../../models/employee.dart';

class DetailEmployee extends StatelessWidget {
  final Employee employee;
  DetailEmployee(this.employee);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  employee.name,
                  style: TextStyle(fontSize: 26),
                ),
                SizedBox(height: 8),
                Text(
                  employee.position,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 10),
                    Text(
                      employee.phoneNumber,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 10),
                    Text(
                      employee.email,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.place,
                      color: Colors.teal,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        employee.address,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeFormAction(
                employee: employee,
              ),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}

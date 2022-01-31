import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/radio_btns.dart';


class PaymentMethod extends StatefulWidget {
  PaymentMethod() : super();

  final String title = "Payment Method";

  @override
  RadioWidgetDemoState createState() => RadioWidgetDemoState();
}

class RadioWidgetDemoState extends State<PaymentMethod> {
  //
  List<User> users;
  User selectedUser;
  int selectedRadio;
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    users = User.getUsers();
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setSelectedUser(User user) {
    setState(() {
      selectedUser = user;
    });
  }

  List<Widget> createRadioListUsers() {
    List<Widget> widgets = [];
    for (User user in users) {
      widgets.add(
        RadioListTile(
          value: user,
          groupValue: selectedUser,
          title: Text(user.firstName),
          onChanged: (currentUser) {
            print("Current User ${currentUser.firstName}");
            setSelectedUser(currentUser);
          },
          selected: selectedUser == user,
          activeColor: Colors.redAccent,
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment", style: TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
        elevation: 0.5,
        // ignore: prefer_const_constructors
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(Icons.arrow_back),
          onPressed: null,
        ),

        actions: const [
          IconButton(onPressed: null,
              icon: Icon(Icons.search)),
          IconButton(onPressed: null,
              icon: Icon(Icons.shopping_cart_outlined)),

        ],

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))

        ),


      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("Select Method",style: TextStyle(fontSize: 21,color: Colors.black38,fontWeight:  FontWeight.bold)),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.all(20.0),

            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),)
                ]
            ),
            child: Column(

              children: createRadioListUsers(),
            ),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Color(0xFFE7E8EA),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),)
                ]
            ),

            child: Body(),


          )

        ],
      ),


    );


  }
}
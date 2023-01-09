import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Filter_View extends StatefulWidget {
  const Filter_View({super.key});

  @override
  State<Filter_View> createState() => _Filter_ViewState();
}

class _Filter_ViewState extends State<Filter_View> {
  @override
  Widget build(BuildContext context) {
    return 
  
     Scaffold(
        resizeToAvoidBottomInset: false,
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  <Widget>[
            const SizedBox(
                width: 300,
                height: 80,
               child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Min Price',
                  ),
               ),
             ),
            const  SizedBox(
                  width: 300,
                  height: 80,
                child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Max Price',
                    ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200,  left: 250),
                child: SizedBox(
                    width: 100,
                    height: 40,
                  child: ElevatedButton (
                    onPressed: () {
                      Navigator.pop(context);
                    },
                   child: const Text('Apply'),
                    )
                ),
              ),

            ],
          ),
          
        ),
      );

  }
}
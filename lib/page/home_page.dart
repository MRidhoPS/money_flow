import 'package:flutter/material.dart';
import 'package:money_flow/widgets/widgets_pages/list_data_container.dart';
import '../widgets/widgets_pages/heading_home.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.usersId});

  final dynamic usersId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 2, 2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget total expenses
                HeadingHome(userId: widget.usersId,),
                const SizedBox(
                  height: 20,
                ),
                // widget list expenses
                DataContainer(usersId: widget.usersId)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.15),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddPage(
                userId: widget.usersId,
              ),
            ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}

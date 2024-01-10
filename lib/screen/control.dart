import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        padding: EdgeInsets.all(50),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                colors: [AppColor.darkPrimary, AppColor.darkSecondary])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 50,
                color: AppColor.textDark1,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().closeAllValve();
                    },
                    child: Text('Close')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().openAllValve();
                    },
                    child: Text('Open')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().initAllValve();
                    },
                    child: Text('Init')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().allValveHome();
                    },
                    child: Text('Home')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().startSelfTest();
                    },
                    child: Text('SelfTest')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().startDrain();
                    },
                    child: Text('DrainTest')),
                ElevatedButton(
                    onPressed: () {
                      context.read<APDSystemProvider>().startPrimming();
                    },
                    child: Text('PrimmingTest')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:apd_app/provider/apd_system.dart';
import 'package:apd_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class program_info extends StatelessWidget {
  const program_info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<APDSystemProvider>(context, listen: false);
    double times = provider.profile?['time'] / 3600;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          width: 780,
          height: 210,
          // decoration: BoxDecoration(
          //     border: Border.all(
          //       width: 1,
          //       color: Colors.white10,
          //     ),
          //     borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Program Details',
                    style: TextStyle(fontSize: 24, color: AppColor.textDark1),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.list,
                        size: 30,
                        color: AppColor.textDark1,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 240,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Total Solution',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child: Text(
                                  '${provider.profile?['totalVol']}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'I-Drain Volume',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text(
                                  '${provider.profile?['idrainVol']}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Lastfill Volume',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text( provider.profile?['lastFillVol'] == 0 ? '-' :
                                  '${provider.profile?['lastFillVol']}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Drain Volume',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text(
                                  '${provider.profile?['fillVol']}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Fill Volume',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text(
                                  '${provider.profile?['fillVol']}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Total Time',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text(
                                  '$times',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'hr.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 240,
                    height: 130,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Total Cycle',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 50,
                                height: 25,
                                child:  Text(
                                  '${provider.totalCycle}',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 25,
                                child: const Text(
                                  'ml.',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: 250,
                          height: 35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 120,
                                height: 25,
                                child: const Text(
                                  'Ico Solution',
                                  style: TextStyle(
                                      color: AppColor.textDark1, fontSize: 16),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: 90,
                                height: 25,
                                child:  Text( provider.profile?['ico'] == 1 ?
                                  'Difference' : 'Same',
                                  style: TextStyle(
                                      color: AppColor.darkWidget, fontSize: 16),
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 260),
          child: VerticalDivider(
            color: Colors.white24,
            indent: 65,
            endIndent: 20,
            width: 10,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 515),
          child: VerticalDivider(
            color: Colors.white24,
            indent: 65,
            endIndent: 20,
            width: 10,
          ),
        )
      ],
    );
  }
}

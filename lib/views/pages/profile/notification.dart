import 'package:flutter/material.dart';

import '../../../misc/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackground,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: AppColors.buttonBackground,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'New',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainTextColor),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 101,
                  width: 388,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Colors.grey.shade200),
                  child: Row(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, bottom: 20),
                      height: 28,
                      width: 28,
                      decoration: const BoxDecoration(
                          color: AppColors.mainTextColor, shape: BoxShape.circle),
                      child: const Icon(
                        Icons.done_sharp,
                        size: 25,
                        weight: 10,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, left: 20),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Popular',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainTextColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 260,
                            child: Text(
                              'Lorem pisum dolor sit arnet, consectur odipiscing olit',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textgrey),
                            ),
                          ),
                        ],
                      ),
                    ),
                   const  Icon(Icons.notifications_none_outlined,color: AppColors.mainTextColor,)
                  ]),
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'Yesterday',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainTextColor),
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.58,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 101,
                    width: 388,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        color: Colors.grey.shade200),
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 30, bottom: 20),
                        height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                            color: AppColors.mainTextColor, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.done_sharp,
                          size: 25,
                          weight: 10,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Popular',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainTextColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                            width: 260,
                            child: Text(
                              'Lorem pisum dolor sit arnet, consectur odipiscing olit',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textgrey),
                            ),
                          ),
                          ],
                        ),
                      ),
                       const  Icon(Icons.notifications_none_outlined,color: AppColors.mainTextColor,)
                    ]),
                  );
                }),
              ),
            ),
           const  SizedBox(height: 20,)
        
        
        
        
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';

class BookingReviewCard extends StatefulWidget {
  const BookingReviewCard({super.key});

  @override
  State<BookingReviewCard> createState() => _BookingReviewCardState();
}

class _BookingReviewCardState extends State<BookingReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const  EdgeInsets.only(bottom: 30),
      child: Column(
        children: [
            Container(
              margin:  const EdgeInsets.only(bottom: 30),
              height: 174,
              width: 286,
              decoration: const  BoxDecoration(
                color: AppColors.mainTextColor,
                borderRadius:  BorderRadius.all(Radius.circular(25)),
                image: DecorationImage(image: NetworkImage('https://www.decorilla.com/online-decorating/wp-content/uploads/2022/12/Luxurious-bedrooms-luxury-bedroom-design.jpg'),fit: BoxFit.cover)
              ),
            ),  
        Container(
          margin:  const EdgeInsets.only(top: 20),
          height: 101,
          width: 388,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.grey.shade200
          ),
          child: Row(children:[
            Container(
              margin: const EdgeInsets.only(left: 30 , bottom: 20),
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                color: AppColors.mainTextColor,
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.done_sharp,size: 25,weight: 10,color: Colors.white,),
            ),
            Container(
              margin: const  EdgeInsets.only(top: 20 ,left: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Popular',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold ,color: AppColors.mainTextColor),),
                   SizedBox(height: 10,),
                   Text('Lorem pisum dolor sit arnet, consectur odipiscing olit',style: TextStyle(fontSize: 11 ,fontWeight: FontWeight.bold ,color: AppColors.textgrey),),
                 ],
              ),
            )
          ]),
        )
      ]),
    );
  }
}
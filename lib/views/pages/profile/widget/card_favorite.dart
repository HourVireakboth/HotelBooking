import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/model/response/favorite_roomresponse.dart';
import 'package:hotel_booking_app/views/pages/home/select_date.dart';
import 'package:provider/provider.dart';

import '../../../../misc/colors.dart';
import '../../../../viewmodels/favorite_viewModel.dart';
import '../../../../widgets/resoponsive_button.dart';

class FavoriteCard extends StatefulWidget {
  const FavoriteCard({super.key, this.favoriteData, this.token});
  final FavoriteData? favoriteData;
  final String? token;
  @override
  State<FavoriteCard> createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  var isfavorite = true;
  var favoriteid;
  var ischeck;
  var isRestart;
  var favoriteViewModel = FavoriteViewModel();
  @override
  void initState() {
    favoriteViewModel = FavoriteViewModel();
    favoriteViewModel.getfavoriteRoom(widget.token);
    super.initState();
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: 162,
                  decoration: BoxDecoration(
                      color: AppColors.mainTextColor,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                          image: NetworkImage(
                              'http://127.0.0.1:8000/rooms/${widget.favoriteData?.roomImage?.image}'),
                          fit: BoxFit.cover)),
                ),
                Text(
                  '${widget.favoriteData!.roomId![0].name}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainTextColor),
                ),
                const Text(
                  'Room',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textgrey),
                ),
                Text(
                  '\$ ${widget.favoriteData!.roomId![0].price} Per Night',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textgrey),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        updateOnDrag: true,
                        initialRating: 3,
                        itemSize: 12,
                        minRating: 1,
                        maxRating: 5,
                        onRatingUpdate: (rating) {
                          setState(() {
                            this.rating = rating;
                          });
                        }),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('(490 Reviews)',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textgrey)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SelectDateScreen(
                                  roomID: widget.favoriteData?.roomId?[0].id,
                                  roomPrice:
                                      widget.favoriteData?.roomId?[0].price,
                                  userID: widget.favoriteData?.userId?[0].id,
                                )));
                  },
                  child: ResponsiveButton(
                    width: 141,
                    heigh: 25,
                    text: 'Booking',
                    radius: 25,
                  ),
                ),
              ]),
          Positioned(
              top: 10,
              right: 25,
              child: ChangeNotifierProvider<FavoriteViewModel>(
                create: (context) => favoriteViewModel,
                child: Consumer<FavoriteViewModel>(
                  builder: (context, viewModel, _) {
                    var status = viewModel.apiResponse.status;
                    var roomid = widget.favoriteData?.roomId?[0].id;
                    print("room id :$roomid");
                    viewModel.apiResponse.data?.data?.forEach((element) {
                      print("element.roomId = ${element.roomId![0].id}");
                      if (element.roomId![0].id == roomid) {
                        favoriteid = element.id;
                        isfavorite = true;
                      }
                    });
                    print('favorite = $favoriteid');
                    if(isfavorite == false){
                      if( status ==  Status.COMPLETED){
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                        content:  Text('Please Scroll down to Refresh the Favorite.')));
                      });
                      }
                    }
                    return GestureDetector(
                      onTap: () async {
                        await viewModel.deletefavoriteRoom(favoriteid);
                        viewModel.apiResponse.data?.data?.clear();
                        await viewModel.getfavoriteRoom(widget.token);
                        isfavorite = false;
                      },
                      child: isfavorite ==  true ?const Icon(
                        Icons.favorite,
                        size: 30,
                        color: AppColors.mainTextColor,
                      ): const Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

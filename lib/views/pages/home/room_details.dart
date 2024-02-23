import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/model/response/searchrespornse.dart';
import 'package:hotel_booking_app/views/pages/home/select_date.dart';

import '../../../model/room.dart';
import '../../../model/room_under100.dart';
import '../../../widgets/resoponsive_button.dart' show ResponsiveButton;
import 'widgets/swiper_card_room.dart';

// ignore: must_be_immutable
class RoomDetails extends StatefulWidget {
  RoomDetails(
      {super.key,
      this.room,
      this.roomunder100,
      this.isCheckunder100,
      this.searchData,
      this.isSearch,
      this.userId});
  RoomData? room;
  RoomUnder100Data? roomunder100;
  SearchResponseData? searchData;
  var userId;
  var isCheckunder100;
  var isSearch;
  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    var listurl = [
      'http://127.0.0.1:8000/rooms/${widget.room?.roomImage?[0].image}',
      'http://127.0.0.1:8000/rooms/${widget.room?.roomImage?[1].image}',
      'http://127.0.0.1:8000/rooms/${widget.room?.roomImage?[2].image}',
    ];
    var listurl1 = [
      'http://127.0.0.1:8000/rooms/${widget.roomunder100?.roomImage?[0].image}',
      'http://127.0.0.1:8000/rooms/${widget.roomunder100?.roomImage?[1].image}',
      'http://127.0.0.1:8000/rooms/${widget.roomunder100?.roomImage?[2].image}',
    ];
    var listurl2 = [
      'http://127.0.0.1:8000/rooms/${widget.searchData?.roomImage?[0].image}',
      'http://127.0.0.1:8000/rooms/${widget.searchData?.roomImage?[1].image}',
      'http://127.0.0.1:8000/rooms/${widget.searchData?.roomImage?[2].image}',
    ];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: size.height * 0.50,
          child: Swiper(
            autoplay: true,
            //autoplayDelay: 1,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return SwiperCardRoom(
                listurl: widget.isCheckunder100 == true
                    ? listurl1[index]
                    : widget.isSearch == true
                        ? listurl2[index]
                        : listurl[index],
              );
            },
            pagination: const SwiperPagination(
                margin: EdgeInsets.only(bottom: 100),
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    activeColor: AppColors.mainTextColor)),
          ),
        ),
        CustomScrollView(
          //physics: const  BouncingScrollPhysics(),
          physics: const NeverScrollableScrollPhysics(),
          anchor: 0.40,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 0.60,
                width: double.maxFinite,
                child: Container(
                  margin: const EdgeInsets.only(left: 35, top: 35, right: 35),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isCheckunder100 == true
                            ? Text(
                                '${widget.roomunder100!.name}',
                                style: const TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mainTextColor),
                              )
                            : widget.isSearch == true
                                ? Text(
                                    '${widget.searchData!.name}',
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainTextColor),
                                  )
                                : Text(
                                    '${widget.room!.name}',
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.mainTextColor),
                                  ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.isCheckunder100 == true
                            ? Text(
                                '\$ ${widget.roomunder100?.price} per Night',
                                style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textgrey),
                              )
                            : widget.isSearch == true
                                ? Text(
                                    '\$ ${widget.searchData?.price} per Night',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textgrey),
                                  )
                                : Text(
                                    '\$ ${widget.room?.price} per Night',
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.textgrey),
                                  ),
                        const SizedBox(
                          height: 10,
                        ),
                        RatingBar.builder(
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            updateOnDrag: true,
                            initialRating: 5,
                            itemSize: 25,
                            minRating: 1,
                            maxRating: 5,
                            onRatingUpdate: (rating) {
                              setState(() {
                                this.rating = rating;
                              });
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Features',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainTextColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            widget.room?.roomFeature?.length == 1 ||
                                    widget.roomunder100?.roomFeature?.length ==
                                        1 ||
                                    widget.searchData?.roomFeature?.length == 1
                                ? Container(
                                    height: 19,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Center(
                                        child: widget.isCheckunder100 == true
                                            ? Text(
                                                '${widget.roomunder100?.roomFeature?[0].name}',
                                                style: const TextStyle(
                                                    color: AppColors.textgrey),
                                              )
                                            : widget.isSearch == true
                                                ? Text(
                                                    '${widget.searchData?.roomFeature?[0].name}',
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.textgrey),
                                                  )
                                                : Text(
                                                    '${widget.room?.roomFeature?[0].name}',
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.textgrey),
                                                  )),
                                  )
                                : widget.room?.roomFeature?.length == 2 ||
                                        widget.roomunder100?.roomFeature
                                                ?.length ==
                                            2 ||
                                        widget.searchData?.roomFeature
                                                ?.length ==
                                            2
                                    ? Row(
                                        children: [
                                          Container(
                                            height: 19,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Center(
                                                child: widget.isCheckunder100 ==
                                                        true
                                                    ? Text(
                                                        '${widget.roomunder100?.roomFeature?[0].name}',
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .textgrey),
                                                      )
                                                    : widget.isSearch == true
                                                        ? Text(
                                                            '${widget.searchData?.roomFeature?[0].name}',
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textgrey),
                                                          )
                                                        : Text(
                                                            '${widget.room?.roomFeature?[0].name}',
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textgrey),
                                                          )),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 19,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Center(
                                                child: widget.isCheckunder100 ==
                                                        true
                                                    ? Text(
                                                        '${widget.roomunder100?.roomFeature?[1].name}',
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .textgrey),
                                                      )
                                                    : widget.isSearch == true
                                                        ? Text(
                                                            '${widget.searchData?.roomFeature?[1].name}',
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textgrey),
                                                          )
                                                        : Text(
                                                            '${widget.room?.roomFeature?[1].name}',
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textgrey),
                                                          )),
                                          )
                                        ],
                                      )
                                    : widget.room?.roomFeature?.length == 3 ||
                                            widget.roomunder100?.roomFeature
                                                    ?.length ==
                                                3 ||
                                            widget.searchData?.roomFeature
                                                    ?.length ==
                                                3
                                        ? Row(
                                            children: [
                                              Container(
                                                height: 19,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Center(
                                                    child:
                                                        widget.isCheckunder100 ==
                                                                true
                                                            ? Text(
                                                                '${widget.roomunder100?.roomFeature?[0].name}',
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .textgrey),
                                                              )
                                                            : widget.isSearch ==
                                                                    true
                                                                ? Text(
                                                                    '${widget.searchData?.roomFeature?[0].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )
                                                                : Text(
                                                                    '${widget.room?.roomFeature?[0].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 19,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Center(
                                                    child:
                                                        widget.isCheckunder100 ==
                                                                true
                                                            ? Text(
                                                                '${widget.roomunder100?.roomFeature?[1].name}',
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .textgrey),
                                                              )
                                                            : widget.isSearch ==
                                                                    true
                                                                ? Text(
                                                                    '${widget.searchData?.roomFeature?[1].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )
                                                                : Text(
                                                                    '${widget.room?.roomFeature?[1].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 19,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Center(
                                                    child:
                                                        widget.isCheckunder100 ==
                                                                true
                                                            ? Text(
                                                                '${widget.roomunder100?.roomFeature?[2].name}',
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .textgrey),
                                                              )
                                                            : widget.isSearch ==
                                                                    true
                                                                ? Text(
                                                                    '${widget.searchData?.roomFeature?[2].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )
                                                                : Text(
                                                                    '${widget.room?.roomFeature?[2].name}',
                                                                    style: const TextStyle(
                                                                        color: AppColors
                                                                            .textgrey),
                                                                  )),
                                              ),
                                            ],
                                          )
                                        : const Text(" not have")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Guests',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainTextColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 19,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: widget.isCheckunder100 == true
                                  ? Text(
                                      ' ${widget.roomunder100?.adult} Adults',
                                      style: const TextStyle(
                                          color: AppColors.textgrey),
                                    )
                                  : widget.isSearch == true
                                      ? Text(
                                          ' ${widget.searchData?.adult} Adults',
                                          style: const TextStyle(
                                              color: AppColors.textgrey),
                                        )
                                      : Text(
                                          ' ${widget.room?.adult} Adults',
                                          style: const TextStyle(
                                              color: AppColors.textgrey),
                                        )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Facilities',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mainTextColor),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, right: 15, bottom: 30),
                          child: Row(
                            children: [
                              widget.room?.roomFacility?.length == 1 ||
                                      widget.roomunder100?.roomFacility
                                              ?.length ==
                                          1 ||
                                      widget.searchData?.roomFacility?.length ==
                                          1
                                  ? Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: widget.isCheckunder100 ==
                                                      true
                                                  ? SvgPicture.network(
                                                      'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[0].icon}',
                                                      colorFilter:
                                                          const ColorFilter
                                                                  .mode(
                                                              AppColors
                                                                  .mainTextColor,
                                                              BlendMode.dstIn),
                                                      width: 40,
                                                      height: 40,
                                                    )
                                                  : widget.isSearch == true
                                                      ? SvgPicture.network(
                                                          'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[0].icon}',
                                                          colorFilter:
                                                              const ColorFilter
                                                                      .mode(
                                                                  AppColors
                                                                      .mainTextColor,
                                                                  BlendMode
                                                                      .dstIn),
                                                          width: 40,
                                                          height: 40,
                                                        )
                                                      : SvgPicture.network(
                                                          'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[0].icon}',
                                                          colorFilter:
                                                              const ColorFilter
                                                                      .mode(
                                                                  AppColors
                                                                      .mainTextColor,
                                                                  BlendMode
                                                                      .dstIn),
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                            ),
                                            const Text(
                                              'Wifi',
                                              style: TextStyle(
                                                  color:
                                                      AppColors.mainTextColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 45,
                                        ),
                                      ],
                                    )
                                  : widget
                                                  .room?.roomFacility?.length ==
                                              2 ||
                                          widget.roomunder100?.roomFacility
                                                  ?.length ==
                                              2 ||
                                          widget.searchData?.roomFacility
                                                  ?.length ==
                                              2
                                      ? Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  child:
                                                      widget.isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[0].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                ),
                                                const Text(
                                                  'Wifi',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .mainTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 45,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  child:
                                                      widget.isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[1].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                ),
                                                const Text(
                                                  'Smart TV',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .mainTextColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 45,
                                            ),
                                          ],
                                        )
                                      : widget.room?.roomFacility
                                                      ?.length ==
                                                  3 ||
                                              widget.roomunder100?.roomFacility
                                                      ?.length ==
                                                  3 ||
                                              widget.searchData?.roomFacility
                                                      ?.length ==
                                                  3
                                          ? Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[0].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'Wifi',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[1].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'Smart TV',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[2].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[2].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[2].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'AC',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[0].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[0].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'Wifi',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[1].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[1].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'Smart TV',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[2].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[2].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[2].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'AC',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 45,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      child: widget
                                                                  .isCheckunder100 ==
                                                              true
                                                          ? SvgPicture.network(
                                                              'http://127.0.0.1:8000/facilities/${widget.roomunder100?.roomFacility?[3].icon}',
                                                              colorFilter:
                                                                  const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                              width: 40,
                                                              height: 40,
                                                            )
                                                          : widget.isSearch ==
                                                                  true
                                                              ? SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.searchData?.roomFacility?[3].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                )
                                                              : SvgPicture
                                                                  .network(
                                                                  'http://127.0.0.1:8000/facilities/${widget.room?.roomFacility?[3].icon}',
                                                                  colorFilter: const ColorFilter
                                                                          .mode(
                                                                      AppColors
                                                                          .mainTextColor,
                                                                      BlendMode
                                                                          .dstIn),
                                                                  width: 40,
                                                                  height: 40,
                                                                ),
                                                    ),
                                                    const Text(
                                                      'SPA',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .mainTextColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        widget.isCheckunder100 == true
                                            ? SelectDateScreen(
                                                userID: widget.userId,
                                                roomID: widget.roomunder100!.id,
                                                roomPrice:
                                                    widget.roomunder100!.price,
                                              )
                                            : widget.isSearch == true ? SelectDateScreen(
                                                userID: widget.userId,
                                                roomID: widget.searchData?.id,
                                                roomPrice: widget.searchData?.price,
                                              ):SelectDateScreen(
                                                userID: widget.userId,
                                                roomID: widget.room?.id,
                                                roomPrice: widget.room?.price,
                                              )
                                              )
                                              );
                          },
                          child: ResponsiveButton(
                            heigh: 63,
                            width: 352,
                            text: 'Book Now',
                            radius: 50,
                            textsize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 50,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
            color: AppColors.mainTextColor,
          ),
        ),
      ],
    ));
  }
}

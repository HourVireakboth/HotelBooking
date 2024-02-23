import 'package:flutter/material.dart';
import 'package:hotel_booking_app/misc/colors.dart';
import 'package:hotel_booking_app/model/response/favorite_roomresponse.dart';
import 'package:hotel_booking_app/views/pages/widgets/room_card_search.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../viewmodels/search_viewmodel.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, this.userID});
  int? userID;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var search = TextEditingController();
  var searchviewModel = SearchViewModel();
  @override
  void initState() {
    print("userID:${widget.userID} ");
    searchviewModel = SearchViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackground,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: AppColors.buttonBackground,
          title: const Text('Search Rooms'),
          titleTextStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor)),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onSubmitted: (value) {
              search.text = value;
              // searchBookViewModel.searchRoom(search.text);
              searchviewModel.searchRooms(search.text);
              print('search value :${search.text}');
            },
            autofocus: true,
            controller: search,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.buttonBackground,
              prefixIcon: IconButton(
                onPressed: () {
                  var searchs = search.text;
                  //searchBookViewModel.searchRoom(searchs.toString());
                  searchviewModel.searchRooms(search.text);
                  print('search value :$searchs');
                },
                icon: const Icon(
                  Icons.search,
                  color: AppColors.mainTextColor,
                ),
              ),
              helperText: '',
              hintText: 'Search',
              contentPadding: const EdgeInsets.all(15),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.mainTextColor),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.mainTextColor),
                borderRadius: BorderRadius.circular(25),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  search.clear();
                },
                icon: const Icon(
                  Icons.delete,
                  color: AppColors.mainTextColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            child: ChangeNotifierProvider<SearchViewModel>(
          create: (context) => searchviewModel,
          child: Consumer<SearchViewModel>(
            builder: (context, roomsearch, _) {
              switch (roomsearch.apiResponse.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.COMPLETED:
                  var rooms = roomsearch.apiResponse.data!;
                  var roomcount = roomsearch.apiResponse.data!.data.length;
                  return roomcount > 0
                      ? ListView.builder(
                          itemCount: rooms.data.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return RoomSearchCard(
                              rooms: rooms.data[index],
                              userID: widget.userID,
                            );
                          })
                      : Center(
                          child: Lottie.network(
                            'https://assets5.lottiefiles.com/private_files/lf30_rpwqbj8q.json',
                            fit: BoxFit.cover,
                          ),
                        );
                case Status.ERROR:
                  return const Center(
                    child: Text('Error'),
                  );
                default:
                  return const Center(
                    child: Text('Please search your Room by name here'),
                  );
              }
            },
          ),
        ))
      ]),
    );
  }
}

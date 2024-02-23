import 'package:flutter/material.dart';
import 'package:hotel_booking_app/data/response/status.dart';
import 'package:hotel_booking_app/viewmodels/favorite_viewModel.dart';
import 'package:hotel_booking_app/views/pages/profile/widget/card_favorite.dart';
import 'package:provider/provider.dart';

import '../../../misc/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key, this.token});
  final String? token;
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  var favoriteviewModel = FavoriteViewModel();
  @override
  void initState() {
    favoriteviewModel = FavoriteViewModel();
    favoriteviewModel.getfavoriteRoom(widget.token);
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
        centerTitle: true,
        title: const Text(
          'Favorite',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor),
        ),
      ),
      body: ChangeNotifierProvider<FavoriteViewModel>(
        create: (context) => favoriteviewModel,
        child: Consumer<FavoriteViewModel>(
          builder: (context, viewModel, _) {
            var favorite = viewModel.apiResponse.data?.data;
            var status = viewModel.apiResponse.status;
            switch (status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.COMPLETED:
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  height: MediaQuery.of(context).size.height * 1,
                  child: favorite!.isEmpty
                      ? const Center(
                          child: Text(
                            'No Favorite Record',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textgrey),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            viewModel.apiResponse.data!.data!.clear();
                           await viewModel.getfavoriteRoom(widget.token);
                          },
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: favorite.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              return FavoriteCard(
                                favoriteData: favorite[index],
                                token: widget.token,
                              );
                            },
                          ),
                        ),
                );
              case Status.ERROR:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return const Center(
                  child: Text('Default'),
                );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/owners_cubit.dart';
import '../../constants/strings.dart';

import '../../data/model/owners.dart';

import '../widgets/owner_item.dart';

class OwnersScreen extends StatefulWidget {
  const OwnersScreen({Key? key}) : super(key: key);

  @override
  State<OwnersScreen> createState() => _OwnersScreenState();
}

class _OwnersScreenState extends State<OwnersScreen> {
  late List<Owners> allOwners;
  late List<Owners> favouriteOwners;

  bool showFavouriteList = false;
  String? numberOfOwnersInCart = '0';

  @override
  void initState() {
    BlocProvider.of<OwnersCubit>(context).getAllOwners();
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<OwnersCubit, OwnersState>(
      builder: (context, state) {
        if (state is OwnersLoaded) {
          allOwners = state.owners;
        }
        return buildLoadedWidget();
      },
    );
  }

  Widget buildLoadedWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            buildOwnersList(),
          ],
        ),
      ),
    );
  }

  Widget buildOwnersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: showFavouriteList ? favouriteOwners.length : allOwners.length,
      itemBuilder: (ctx, index) {
        return OwnerItem(
          key: ValueKey(allOwners[index].id),
          owner: showFavouriteList ? favouriteOwners[index] : allOwners[index],
          index: index,
          inFavouriteList: showFavouriteList,
        );
      },
    );
  }

  Widget buildPopMenu() {
    return PopupMenuButton(
        onSelected: (FilterOption selectedValue) {
          if (selectedValue == FilterOption.FavouriteOwners) {
            setState(() {
              showFavouriteList = true;
            });
            favouriteOwners =
                BlocProvider.of<OwnersCubit>(context).getFavouriteOwnersList();
          } else {
            setState(() {
              showFavouriteList = false;
            });
          }
        },
        icon: const Icon(Icons.more_vert),
        itemBuilder: (_) {
          return [
            const PopupMenuItem(
              child: Text('Favourites Owners'),
              value: FilterOption.FavouriteOwners,
            ),
            const PopupMenuItem(
              child: Text('All Owners'),
              value: FilterOption.AllOwners,
            ),
          ];
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF08313A),
        title: const Text(
          'Owners',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          buildPopMenu(),
        ],
      ),
      body: buildBlocWidget(),
    );
  }
}

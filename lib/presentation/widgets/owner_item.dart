// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/business_logic/cubit/owners_cubit.dart';

import 'package:shop_app/constants/strings.dart';
import 'package:shop_app/data/model/owners.dart';

class OwnerItem extends StatelessWidget {
  final Owners owner;
  final int index;
  final bool inFavouriteList;

  const OwnerItem({
    Key? key,
    required this.owner,
    required this.index,
    required this.inFavouriteList,
  }) : super(key: key);

  Widget buildFavouriteIconButtonWidget(BuildContext context) {
    return IconButton(
      color: Colors.deepOrange,
      icon: owner.isFav
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_border),
      onPressed: () {
        owner.isFav = BlocProvider.of<OwnersCubit>(context)
            .toggleFavourite(owner.isFav, owner.id);

        print(owner.isFav);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, ownerDetailsScreen, arguments: owner),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: Container(
              child: owner.owner.avatarUrl.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: owner.owner.avatarUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(
                owner.fullName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              leading: BlocBuilder<OwnersCubit, OwnersState>(
                  buildWhen: (previous, current) {
                return current is OwnerIsFavourite;
              }, builder: (context, state) {
                return buildFavouriteIconButtonWidget(context);
              }),
              trailing: inFavouriteList
                  ? Container()
                  : IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.deepOrange,
                      ),
                      onPressed: () {
                        BlocProvider.of<OwnersCubit>(context)
                            .removeOwner(owner, index);
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

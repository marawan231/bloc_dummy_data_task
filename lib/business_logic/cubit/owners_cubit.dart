import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/owners.dart';
import '../../data/repoistry/owners_repoistry.dart';

part 'ownerss_state.dart';

class OwnersCubit extends Cubit<OwnersState> {
  final OwnersRepoistry ownersRepoistry;

  late List<Owners> owners = [];
  List<Owners> favouriteOwners = [];

  OwnersCubit(
    this.ownersRepoistry,
  ) : super(OwnersInitial());

  List<Owners> getAllOwners() {
    emit(OwnersLoading());
    ownersRepoistry.getAllOwners().then((owners) {
      this.owners = owners;
      emit(OwnersLoaded(owners));
    });
    return owners;
  }

  bool toggleFavourite(bool isFav, int id) {
    isFav = !isFav;
    if (isFav == false) {
      favouriteOwners.removeWhere((owner) => owner.id == id);
    }
    emit(OwnerIsFavourite());
    return isFav;
  }

  List<Owners> getFavouriteOwnersList() {
    favouriteOwners = owners.where((owner) => owner.isFav).toList();
    emit(FavouriteOwnersLoaded(favouriteOwners));
    return favouriteOwners;
  }

  void removeOwner(Owners owner, int index) {
    owners.removeAt(index);
    emit(RemoveOwner());
  }
}

part of 'owners_cubit.dart';

@immutable
abstract class OwnersState {}

class OwnersInitial extends OwnersState {}

class OwnersLoaded extends OwnersState {
  final List<Owners> owners;

  OwnersLoaded(this.owners);
}

class RemoveOwner extends OwnersState {}

class OwnerIsFavourite extends OwnersState {}

class FavouriteOwnersLoaded extends OwnersState {
  final List<Owners> favouriteOwners;

  FavouriteOwnersLoaded(this.favouriteOwners);
}

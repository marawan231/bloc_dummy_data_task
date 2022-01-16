import '../model/owners.dart';
import '../web_services/owners_web_services.dart';

class OwnersRepoistry {
  final OwnersWebServices ownersWebServices;

  OwnersRepoistry(this.ownersWebServices);
  Future<List<Owners>> getAllOwners() async {
    final owners = await ownersWebServices.getAllOwners();
    return owners.map((owner) => Owners.fromJson(owner)).toList();
  }
}

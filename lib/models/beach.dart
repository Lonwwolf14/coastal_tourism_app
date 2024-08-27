// lib/models/beach.dart

class Beach {
  final String name;
  final String location;

  Beach({required this.name, required this.location});
}

class BeachSuitability {
  final bool isSuitable;
  final String alert;

  BeachSuitability({required this.isSuitable, required this.alert});
}

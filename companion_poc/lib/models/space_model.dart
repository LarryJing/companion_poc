class SpaceModel {
  final List<String> data;
  SpaceModel(this.data);

  factory SpaceModel.fromJson(Map<String, dynamic> parsedJson) {
    var dataFromJson = parsedJson['data'];
    List<String> dataList = dataFromJson.cast<String>();
    return SpaceModel(dataList);
  }
}

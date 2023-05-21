class RecipeModel
{
  late String applabel;
  late String appimgURL;
  late double appcalories;
  late String appurl;

  RecipeModel({this.applabel = "label", this.appcalories= 0.000, this.appimgURL = "Image", this.appurl = "URL"});
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimgURL: recipe["image"],
      appurl: recipe["url"]
    );
  }
}

class CategoryModel {
  final String categoryType;
  final String categoryTypeImage;
  final List<SubCategoryModel> subCategoryList;

  CategoryModel({
    this.categoryType,
    this.categoryTypeImage,
    this.subCategoryList
  });
}
class SubCategoryModel{
  final String categoryName;
  final String categoryImage;
  SubCategoryModel({this.categoryImage,this.categoryName});
}

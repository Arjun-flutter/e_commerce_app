class Category {
 final String image;
 final String apiCategory;
 final String name;

  Category({required this.image, required this.name, required this.apiCategory});
}

final List<Category> categoryList = [
  Category(
    name: "Men", 
    apiCategory: "mens-shirts",
    image: "assets/images/men.png"
    ),
  Category(
    name: "Women", 
    apiCategory: "womens-dresses",
    image: "assets/images/women.png"
    ),
  Category(
    name: "Shoes",
    apiCategory: "mens-shoes",
    image: "assets/images/shoes.png"
     ),
  Category(
    name: "Baby",
    apiCategory: "baby-shirts",
    image: "assets/images/baby.png"
     ),
  Category(
    name: "Teens", 
    apiCategory: "teens-shirts",
    image: "assets/images/teens.png"
    ),
  Category(
    name: "Kids",
    apiCategory: "mens-shirts",
    image: "assets/images/kids.png"
     ),
];

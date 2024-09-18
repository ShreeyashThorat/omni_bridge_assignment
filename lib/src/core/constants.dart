import '../models/pets_model.dart';

class Constants {
  // images
  static String loginImg = "assets/images/login.jpg";
  static String personImg = "assets/images/person.jpg";
  static String petsImg = "assets/images/pets.jpg";
  static String signupImg = "assets/images/signup.jpg";

  static List<String> petsCategories = ["Dog", "Cat", "Fish", "Bird", "Others"];

  static PetsModel pet = PetsModel(
      category: "Dog",
      name: "Ramie",
      description: "Ramie is a very frindly and cute dog",
      color: "Black and White",
      age: "8",
      ownerName: "test",
      ownerContact: "9012345678",
      ownerId: "ksjcsncksnclksccs",
      image:
          "https://img.freepik.com/premium-photo/australian-shepherd-dog_1015384-160342.jpg?ga=GA1.1.128891338.1717828086&semt=ais_hybrid");
}

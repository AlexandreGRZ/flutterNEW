library dto;

enum Activity {
  cooking,
  garden,
  hobby,
  house,
}

class Article {
  final String? name;
  final String? description;
  final String? image;
  final Activity? activity;
  final String Uid;

  Article(
      {required this.name,
      required this.image,
      required this.description,
      required this.activity,
      required this.Uid});

  static Article fromFirestore(Map<String, dynamic> data) {
    return Article(
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      description: data['description'] ?? '',
      activity: _parseActivity(
        data['activity'],
      ),
      Uid: data['uid'],
    );
  }

  static Activity? _parseActivity(String? activityString) {
    switch (activityString) {
      case 'cooking':
        return Activity.cooking;
      case 'garden':
        return Activity.garden;
      case 'hobby':
        return Activity.hobby;
      case 'house':
        return Activity.house;
      default:
        return null;
    }
  }

  String? parseToString(Activity? activity) {
    switch (activity) {
      case Activity.cooking:
        return 'cooking';
      case Activity.garden:
        return 'garden';
      case Activity.hobby:
        return 'hobby';
      case Activity.house:
        return 'house';
      default:
        return null;
    }
  }

  @override
  String toString() {
    return 'articles{name: $name, description: $description, image: $image}';
  }
}

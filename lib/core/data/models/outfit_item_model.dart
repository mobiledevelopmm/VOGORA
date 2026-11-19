
class OutfitItem {
  final String id;
  final String title;
  final String description;
  final String category;
  final String gender;
  final String type;
  final String imageURL;
  final bool isActive;

  const OutfitItem({
    this.id = '',
    required this.title,
    this.description = '',
    this.category = '',
    this.gender = '',
    this.type = 'styled_for_you',
    required this.imageURL,
    this.isActive = true,
  });

  factory OutfitItem.fromFirestore(
      String id,
      Map<String, dynamic> data,
      ) {
    return OutfitItem(
      id: id,
      title: data['name']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      gender: data['gender']?.toString() ?? '',
      type: data['type']?.toString() ?? 'styled_for_you',
      imageURL: data['imageURL']?.toString() ??
          data['imageUrl']?.toString() ??
          '',
      isActive: data['isActive'] != false,
    );
  }
}
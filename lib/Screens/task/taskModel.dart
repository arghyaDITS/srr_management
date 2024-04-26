class Task {
  final String name;
   String? description;
  final String? imagePath;
  final bool? isDone;
   final double? progress;
  bool isFlagged=false;
  String? issueDescription;

  Task({required this.name,  this.description,  this.imagePath, this.isDone,this.progress,this.isFlagged=false,this.issueDescription});
}

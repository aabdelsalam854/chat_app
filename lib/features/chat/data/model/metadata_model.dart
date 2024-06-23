class MetadataModel {
  final String? fileName;
   final String? details;
  final String? fileSize;
  final dynamic fileType;
  final int? width;
  final int? height;


  MetadataModel(
    
    
    {
    required this.fileName,
    required this.fileSize,
    required this.width,
    required this.height,
    required this.fileType,
    required this.details,
  });
  factory MetadataModel.fromJson(Map<String, dynamic> jsonData) {
    return MetadataModel(

      fileName: jsonData['fileName'],
      fileSize: jsonData['fileSize'],
      width: jsonData['width'],
      height: jsonData['height'],
      fileType: jsonData['fileType'],
      details: jsonData['details'],

    );
  }
  Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "fileSize": fileSize,
        "width": width,
        "height": height,
        "fileType": fileType,
        "details": details,
      };
}

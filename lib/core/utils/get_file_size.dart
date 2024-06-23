class GetFileSize {
  static String getFileSize(int bytes) {
    const int kB = 1024;
    const int mB = 1024 * kB;

    if (bytes >= mB) {
      return '${(bytes / mB).toStringAsFixed(2)} MB';
    } else if (bytes >= kB) {
      return '${(bytes / kB).toStringAsFixed(2)} KB';
    } else {
      return '${bytes.toStringAsFixed(2)} bytes';
    }
  }
}

class UrlValidator {
  const UrlValidator();

  String? validate(String? input) {
    final value = input?.trim() ?? '';

    if (value.isEmpty) {
      return 'Enter the API URL';
    }

    final uri = Uri.tryParse(value);
    if (uri == null ||
        !uri.hasScheme ||
        !uri.hasAuthority ||
        uri.host.isEmpty) {
      return 'Invalid URL';
    }

    if (uri.scheme != 'http' && uri.scheme != 'https') {
      return 'URL must start with http:// or https://';
    }

    return null;
  }

  bool isValid(String? input) => validate(input) == null;
}

// lib/config/config.dart

class Config {
  // Base URL for the INCOIS API
  static const String baseUrl = 'https://api.incois.gov.in/';

  // Endpoints
  static const String beachesEndpoint = '${baseUrl}beaches';
  static const String suitabilityEndpoint = '${baseUrl}suitability';
}



class Environment{

  static const String endpointBase = "http://192.168.1.10:8000";
  static const String endpointApi = "http://192.168.1.10:8000/api";

  static const String mapboxApiKey = "pk.eyJ1IjoicGljaG5hcmluIiwiYSI6ImNtOHRxNm9teTBkZ3kybHNlcHN1bGRtMWwifQ.ehVeRVwFr3IRdknFt3x9Fg";

  //pizza sprint company location
  static const double latitude = 11.538892;
  static const double longitude = 104.833429;
}

final Environment environment = Environment();


void main(){
  print('${Environment.endpointApi}/google-login');
}
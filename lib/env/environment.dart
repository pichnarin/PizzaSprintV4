

class Environment{

  static const String endpointBase = "http://172.16.0.155:8000";
  static const String endpointApi = "http://172.16.0.155:8000/api";

  static const String mapboxApiKey = "pk.eyJ1IjoicGljaG5hcmluIiwiYSI6ImNtOHRxNm9teTBkZ3kybHNlcHN1bGRtMWwifQ.ehVeRVwFr3IRdknFt3x9Fg";

  //pizza sprint company location
  static const double latitude = 11.5389821;
  static const double longitude = 104.8332458;
}

final Environment environment = Environment();


void main(){
  print('${Environment.endpointApi}/google-login');
}
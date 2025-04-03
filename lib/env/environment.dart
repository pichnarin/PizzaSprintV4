

class Environment{

  static const String endpointBase = "http://172.16.0.27:8000";
  static const String endpointApi = "http://172.16.0.27:8000/api";

  static const String mapboxApiKey = "pk.eyJ1IjoicGljaG5hcmluIiwiYSI6ImNtOHRxNm9teTBkZ3kybHNlcHN1bGRtMWwifQ.ehVeRVwFr3IRdknFt3x9Fg";

  // static const String imageUrl = "http://192.168.1.10:8000/storage";

}

final Environment environment = Environment();


void main(){
  print('${Environment.endpointApi}/google-login');
}
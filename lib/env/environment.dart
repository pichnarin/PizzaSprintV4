

class Environment{

  static const String endpointBase = "http://172.23.4.101:8000";
  static const String endpointApi = "http://172.23.4.101:8000/api";

  static const String mapboxApiKey = "sk.eyJ1IjoicGljaG5hcmluIiwiYSI6ImNtOHZyZ3BkcDBrN20ybHNkNXNvMmJ5YWMifQ.WZg7eQrBYd86sPZV0BJNUw";

}


void main(){
  print('${Environment.endpointApi}/google-login');
}
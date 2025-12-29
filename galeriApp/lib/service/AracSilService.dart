import 'package:http/http.dart' as http;

class AracSilService{
  
    Future<bool> aracSil(int aracId) async {
      
      final url = Uri.parse("http://10.0.2.2:8086/arac-sil/$aracId");

      final response = await http.delete(

        url,
        headers:
        {
          'Content-Type': 'application/json',
        },

      );

      if(response.statusCode == 200){
        return true;
      } else {
        return false;
      }
    }

}
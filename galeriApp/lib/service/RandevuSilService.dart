import 'package:http/http.dart' as http;

class RandevuSilService{
  
    Future<bool> randevuSil(int randevuId) async {
      
        final url = Uri.parse("http://10.0.2.2:8086/randevu/randevuSil/$randevuId");

        final response = await http.delete(

          url,
          headers:
          {
            "Content-Type": "application/json",
          },

        );

        if(response.statusCode == 200){
          return true;
        } else {
          return false;
        }

    }
}
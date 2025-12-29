import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:galeri_app/service/RandevuAlService.dart';
import 'package:lottie/lottie.dart';

class Randevualpage extends StatefulWidget {
  String username;

  Randevualpage({super.key, required this.username});

  @override
  State<Randevualpage> createState() => _RandevualpageState();
}

class _RandevualpageState extends State<Randevualpage> {

  String galericiId = "580";

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  RandevuAllService service = RandevuAllService();

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  Future<void> randevuAl() async {

    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lütfen tarih ve saat seçin"),
        action: SnackBarAction(label: "Tamam", onPressed: (){}),
        ),
      );
      return;
    }

    final String formattedDate =
    DateFormat("yyyy-MM-dd").format(selectedDate!);

    final String formattedTime = selectedTime!.format(context);

    final String hhmm =
        selectedTime!.hour.toString().padLeft(2, '0') +
            ":" +
            selectedTime!.minute.toString().padLeft(2, '0');

    final ok = await service.randevuAl(
      widget.username,
      formattedDate,
      hhmm,
      galericiId,
    );

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Randevu başarıyla oluşturuldu")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Randevu tarih ve saati daha önceden alınmış ! Lütfen başka bir tarih ve saat seçiniz."),
        action: SnackBarAction(label: "Tamam", onPressed: (){}),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.orange),
        ),
        centerTitle: true,
        title: Text("Randevu Al", style: TextStyle(color: Colors.orange)),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 250,
              child: Lottie.asset("assets/takvim.json" , width: 250, height: 250),
            ),
            Container(
              width: 150,
              height: 50,
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              ),
                onPressed: pickDate,
                child: Text("Tarih Seç",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              selectedDate == null
                  ? "Tarih seçilmedi"
                  : "Tarih : " + DateFormat("yyyy-MM-dd").format(selectedDate!),
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold , fontSize: 18),
            ),
            SizedBox(height: 35),
            Container(
              width: 150,
              height: 50,
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ))
              ),
                onPressed: pickTime,
                child: Text("Saat Seç",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedTime == null
                  ? "Saat seçilmedi"
                  : "Saat : " + "${selectedTime!.hour.toString().padLeft(2,'0')}:${selectedTime!.minute.toString().padLeft(2,'0')}",
              style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 18),
            ),
            SizedBox(height: 80),
            Container(
              width: 200,
              height: 50,
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.orange
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                )
              ),
                onPressed: randevuAl,
                child: Text("Randevu Oluştur",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

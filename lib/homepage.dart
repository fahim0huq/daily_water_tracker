import 'package:flutter/material.dart';
import 'package:water_tracker/widgets/addwaterBtn.dart';
import 'package:water_tracker/widgets/gradient_circular_progress_indicator.dart';
class Homepage extends StatefulWidget {
      Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController waterController = TextEditingController();

  int currentWater=0;

  final int goal = 2000;

  void addWater(int amount){
    setState((){
      currentWater=(currentWater+amount).clamp(0, 2000);
    });
  }
  void resetWater(){
    setState(() {
      currentWater=0;
    });
  }
  @override
  Widget build(BuildContext context) {
    double progress= (currentWater/(goal)).clamp(0, 1.0);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'Water Intake Tracker',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height:15),
              const Text(
                "Today's Intake",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(12),
                height: 60,
                width: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: currentWater < 500
                        ? [Color(0xFFFF6B6B), Color(0xFFB00020)] // Red gradient
                        : [Color(0xFF00C6FF), Color(0xFF0072FF)], // Blue gradient
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child:Center(
                  child: Text(
                    '$currentWater ml',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      //letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: GradientCircularProgress(progress: progress,),
                  ),
                   Text(
                    "${(progress*100).toInt()}%",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  WaterBtn(amount: 200, onClick: ()=>addWater(200),),
                  WaterBtn(amount: 250, onClick: ()=>addWater(250),),
                  WaterBtn(amount: 500, onClick: ()=>addWater(500),),

                ],
              ),
              SizedBox(height: 15,),
              Container(
                height: 60,
                width: 320,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33FF6B6B), // Soft glow
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: TextField(
                    controller:waterController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Custom Water Input',
                      labelStyle: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                      icon: const Icon(Icons.water_drop, color: Colors.white),
                      suffixIcon: IconButton(
                        alignment: Alignment.centerRight,
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          final input = int.tryParse(waterController.text);
                          addWater(input!);
                        },
                      ),

                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 15,),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    resetWater();
                  },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 60,
                  width: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF6B6B), Color(0xFFB00020)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.transparent,
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        //letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}

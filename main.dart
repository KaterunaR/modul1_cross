import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Туристичні агенції",
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const TourismPage(),
    );
  }
}

class Tour {
  final String name;
  final String description;
  final String imagePath;

  Tour({required this.name, required this.description, required this.imagePath});
}

class TourismPage extends StatefulWidget {
  const TourismPage({super.key});

  @override
  State<TourismPage> createState() => _TourismPageState();
}

class _TourismPageState extends State<TourismPage> {
  final List<Tour> tours = [
    Tour(name: "Тур в Єгипет", 
         description: "Єгипет має унікальний туристичний потенціал. Країна є спадкоємицею всесвітньо відомої стародавньої єгипетської цивілізації, від якої до наших днів дійшли храми, гробниці і мумії, ієрогліфи і звичайно ж піраміди. Країна є туристично привабливою також завдяки відносній дешевизні, популярності і доступності.", 
         imagePath: "assets/images/egypt.jpg"),
    Tour(name: "Тур в Лондон", 
         description: "Лондон — місто контрастів, де історія зустрічається з сучасністю. Прогуляйтеся берегами Темзи, побачте Букінгемський палац, Тауерський міст та легендарний Тауер, підніміться на London Eye для неймовірних панорам, відвідайте Британський музей та насолодіться театральними шоу Вест-Енду. Скуштуйте традиційний англійський сніданок, Fish & Chips або класичний Afternoon Tea, відчуйте неповторну атмосферу вулиць, парків і культурних пам’яток столиці Великої Британії. Лондон чекає на вас, щоб подарувати незабутні спогади!.", 
         imagePath: "assets/images/london.jpg"),
    Tour(name: "Тур в Париж", 
         description: "Париж — місто світла, романтики та мистецтва. Прогуляйтеся вздовж Сени, помилуйтеся Ейфелевою вежею, відвідайте Лувр та Собор Паризької Богоматері, прогуляйтеся кварталом Монмартр і насолодіться атмосферою кафе на вузьких вуличках. Скуштуйте круасани, французькі десерти та вишукану кухню, відкрийте для себе чарівність паризьких бульварів, парків і культурних скарбів. Париж чекає, щоб подарувати незабутні емоції та спогади..", 
         imagePath: "assets/images/paris.webp"),
    Tour(name: "Тур в Токіо", 
         description: "Токіо — місто контрастів, де сучасні хмарочоси сусідять із традиційними храмами. Прогуляйтеся районами Шибуя та Сібуя, відвідайте імператорський палац, храм Сенсодзі та сучасні музеї, зануртесь у яскраву атмосферу аніме, технологій і вуличної моди. Скуштуйте суші, рамени та японські десерти, відкрийте для себе парки, ринки та нічне життя мегаполіса. Токіо чекає, щоб подарувати унікальні враження та незабутні спогади..", 
         imagePath: "assets/images/tokio.jpg"),
    Tour(name: "Тур в Прагу", 
         description: "Прага — місто казкових вулиць, готичних замків і романтичних мостів. Прогуляйтеся Старим містом, побачте Карлів міст, Празький град та Собор святого Віта, відвідайте старовинні площі та затишні кафе. Скуштуйте традиційні чеські страви та пиво світового рівня, насолодіться атмосферою історії, культури та мистецтва. Прага чекає, щоб подарувати незабутні враження та казкові спогади.", 
         imagePath: "assets/images/praha.jpg"),
  ];

  int selectedIndex = -1;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  void addNewTour() {
    final name = nameController.text.trim();
    final desc = descriptionController.text.trim();
    final img = imageController.text.trim();

    if (name.isEmpty || desc.isEmpty || img.isEmpty) return;

    final fullPath = "assets/images/$img";

    setState(() {
      tours.add(Tour(
        name: name,
        description: desc,
        imagePath: fullPath,
      ));

      nameController.clear();
      descriptionController.clear();
      imageController.clear();
    });
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
                 title: Padding(
                   padding: const EdgeInsets.only(top: 40), 
                   child: const Text("Туристичні агенції"),
                 ),
               ),
       body: Column(
         children: [

          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(),
          ),

          // listView
          Container(
            height: 80,
            padding: const EdgeInsets.all(8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tours.length,
              separatorBuilder: (context, index) => VerticalDivider(width: 30, color: Color.fromARGB(165, 10, 137, 206), thickness: 3, indent: 5, endIndent: 5,),
              itemBuilder: (context, index) {
                final tour = tours[index];
                final isSelected = index == selectedIndex;

                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color.fromARGB(255, 197, 213, 231) : const Color.fromARGB(255, 109, 176, 223),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      leading: Container(
                        width: 60,
                        height: 60,
                        child: Image.asset(
                          tour.imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        tour.name,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      trailing: isSelected
                          ? null
                          : const Text("-->", style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ),
                );
              },
            ),
          ),



          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(),
          ),


          Expanded(
            child: selectedIndex == -1
                ? const Center(
                    child: Text("Тур не вибрано", style: TextStyle(fontSize: 22)),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 400,
                          height: 300,
                          child: Image.asset(
                            tours[selectedIndex].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            width: 600,
                            child: Text(
                              tours[selectedIndex].description,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Divider(
              color: Color.fromARGB(255, 33, 166, 243),
              thickness: 2,
              height: 24,
            ),
          ),

          // add new
          Align(
            alignment: Alignment.centerLeft, 
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: 400, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Назва"),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(labelText: "Опис"),
                    ),
                    TextField(
                      controller: imageController,
                      decoration: const InputDecoration(
                        labelText: "Зображення (напр. praha.jpg)",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 100),
                      child: ElevatedButton(
                        onPressed: addNewTour,
                        child: const Text("Додати тур"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}

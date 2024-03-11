import 'package:flutter/material.dart';
import 'package:toolify_ai/controllers/Image_generator_controllers.dart';

class ImageAi extends StatefulWidget {
  const ImageAi({ Key? key }) : super(key: key);

  @override
  _ImageAiState createState() => _ImageAiState();
}

class _ImageAiState extends State<ImageAi> {
  TextEditingController controller = TextEditingController();
  List<List<String>> ImageList = [];
  List<Map<String, String>> conversationList = [];
  late ImageGenerator generator;

  @override
  void initState() {
    super.initState();
    generator = ImageGenerator();
  }

  void sendMessage() async {
    String userInput = controller.text;
    List<String> response = await generator.GenerateImageResponse(userInput);
    print(response);
    setState(() {
      ImageList.add(response);
      conversationList.add({'user':userInput,'assistant':response.toString()});
      controller.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
                colors: [
                  Color.fromARGB(255, 0, 84, 152),
                  Color.fromARGB(255, 26, 134, 222)
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Convert Text To Image',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: ImageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: SizedBox(
                            height: 200, // Adjust the height of the image container
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ImageList[index].length,
                              itemBuilder: (context, imageIndex) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Image.network(
                                    ImageList[index][imageIndex],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.3),
                        borderRadius: BorderRadius.circular(18.0),
                        color: Color.fromARGB(57, 154, 154, 154),
                      ),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        controller: controller,
                        cursorColor: Colors.white, // Set cursor color
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          hintText: 'Enter your prompt',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(83, 154, 154, 154),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromARGB(255, 0, 84, 152),
                          Color.fromARGB(255, 26, 134, 222)
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 22,
                      ),
                      onPressed: sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

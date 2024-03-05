import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toolify_ai/controllers/text_generator_controllers.dart';

class TextAi extends StatefulWidget {
  const TextAi({Key? key}) : super(key: key);

  @override
  _TextAiState createState() => _TextAiState();
}

class _TextAiState extends State<TextAi> {
  TextEditingController controller = TextEditingController();
  List<Map<String, String>> conversationList = [];
  late TextGenerator generator;

  @override
  void initState() {
    super.initState();
    generator = TextGenerator();
  }

  void sendMessage() async {
    String userInput = controller.text;
    String response = await generator.GenerateResponse(userInput);

    setState(() {
      conversationList.add({'user': userInput, 'assistant': response});
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
          'Chat with Assistant',
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
                  itemCount: conversationList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          conversationList[index]['user'] != null
                              ? Container(
                                  width: 230.0,
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(83, 154, 154, 154),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12.0),
                                      bottomRight: Radius.circular(12.0),
                                      bottomLeft: Radius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    conversationList[index]['user']!,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: conversationList[index]['assistant'] != null
                                ? Container(
                                    width: 230.0,
                                    padding: EdgeInsets.all(8.0),
                                    decoration:  BoxDecoration(
                                      gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 15.0],
          colors: [
           Color.fromARGB(255, 0, 84, 152),
          Color.fromARGB(255, 26, 134, 222),
         
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
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12.0),
                                        bottomRight: Radius.circular(12.0),
                                        bottomLeft: Radius.circular(12.0),
                                      ),
                                    ),
                                    child: Text(
                                      conversationList[index]['assistant']!,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
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
                          color: Color.fromARGB(57, 154, 154, 154)),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(color: Colors.white),
                        controller: controller,
                        cursorColor: Colors.white, // Set cursor color
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
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
                      // border: Border.all(color: Colors.white, width: 0.8),
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

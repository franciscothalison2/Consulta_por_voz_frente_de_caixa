import 'package:app_pao_de_acuca/models/flv.dart';
import 'package:app_pao_de_acuca/repositories/tabelaFlv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cod = "O código da fruta"; // vai receber o código
  Map<String, Flv> lista = TabelaFlv().tabelaDeCodigos; // aqui vem as informações do banco de dados

  SpeechToText speechToText = SpeechToText(); // aqui é a variavel que vai receber todas as funções da leitura de voz
  bool speechEnabled = false; // variavel de controle para saber se a classe iniciou corretamente
  String lastWords = ''; //  vai receber o texto lido

  @override
  // Aqui vamos iniciar a classe que vai dar inicio a leitura do microfone
  void initState() {
    super.initState();
    initSpeech(); // função que inicia a classe
  }

  // aqui a classe vai esperar a classe iniciar e mudar o estado
  // da variavel _speechEnabled, se der certo ela vai ser verdadeiro
  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  // aqui fica a função onde ele começa a escutar
  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  // aqui é uma função que paralisa a leitura da voz,
  //
  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  // depois que chama a função, é preciso que o speech retorne as
  // informações lidas pelo microfone e dai vai jogar na lastwords
  void onSpeechResult(SpeechRecognitionResult result){
    setState(() {
      lastWords = result.recognizedWords.toUpperCase();
      print(lastWords);
    });
  }

 String textoDaTela(){
    if(lista[lastWords] == null){
      return "O código da fruta";
    }
    else{
      return "${lista[lastWords]!.nome} \n"
          "${lista[lastWords]!.plu}";
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.app_registration_sharp),
        title: Text("Tabela do FLV"),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  lastWords = "";

                });
              },
              icon: Icon(Icons.home)
          ),
        ],
      ),
      body: Center(
        child: Text(textoDaTela(), style: TextStyle(
            color: Colors.green,
            fontSize: 30,
            fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Listen',
        child: Icon(
          // isNotListening é uma coisa da própria classe, no caso um atributo
          // isListening
            speechToText.isNotListening ? Icons.mic_off : Icons.mic
        ),
        onPressed: (){
          (speechToText.isNotListening)? startListening() : stopListening();

        },
      ),
    );
  }
}

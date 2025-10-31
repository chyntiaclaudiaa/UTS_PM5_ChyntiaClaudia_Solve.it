import '../models/question_model.dart';

const List<QuestionModel> quizQuestions = [
  QuestionModel(
    text: "What is the capital city of France?",
    options: [
      "Berlin",
      "London",
      "Paris",
      "Rome",
    ],
    correctAnswerIndex: 2,
  ),
  QuestionModel(
    text: "What is the largest ocean on Earth?",
    options: [
      "Pacific Ocean",
      "Arctic Ocean",
      "Indian Ocean",
      "Atlantic Ocean",
    ],
    correctAnswerIndex: 0,
  ),
  QuestionModel(
    text: "What is the main ingredient in Guacamole?",
    options: [
      "Tomato",
      "Avocado",
      "Onion",
      "Lime",
    ],
    correctAnswerIndex: 1,
  ),
  QuestionModel(
    text: "How many planets are in our solar system?",
    options: [
      "7",
      "8",
      "9",
      "10",
    ],
    correctAnswerIndex: 1,
  ),
  QuestionModel(
    text: "What is the currency of Japan?",
    options: [
      "Won",
      "Yuan",
      "Dollar",
      "Yen",
    ],
    correctAnswerIndex: 3,
  ),

  // --- 5 PERTANYAAN TAMBAHAN ---

  QuestionModel(
    text: "Who painted the Mona Lisa?",
    options: [
      "Vincent van Gogh",
      "Pablo Picasso",
      "Leonardo da Vinci",
      "Michelangelo",
    ],
    correctAnswerIndex: 2,
  ),
  QuestionModel(
    text: "What is the tallest mountain in the world?",
    options: [
      "K2",
      "Kangchenjunga",
      "Makalu",
      "Mount Everest",
    ],
    correctAnswerIndex: 3,
  ),
  QuestionModel(
    text: "What element does 'O' represent on the periodic table?",
    options: [
      "Oxygen",
      "Osmium",
      "Gold",
      "Oganesson",
    ],
    correctAnswerIndex: 0,
  ),
  QuestionModel(
    text: "In which country are the Pyramids of Giza located?",
    options: [
      "Sudan",
      "Mexico",
      "Egypt",
      "Peru",
    ],
    correctAnswerIndex: 2,
  ),
  QuestionModel(
    text: "What is the boiling point of water in Celsius?",
    options: [
      "90°C",
      "100°C",
      "110°C",
      "212°C",
    ],
    correctAnswerIndex: 1,
  ),
];
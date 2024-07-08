class RasiNadchathiram {
  static List<String> rasiListOrder = [
    "Mesham","Rishabam","Mithunam","Kadagam","Simmam","Kanni",
    "Thulam","Viruchigam","Thanusu","Magaram","Kumbam","Meenam",
  ];
  static List<int> rasiMatchNumberList = [2, 4, 6, 8];

  static List<String> nadchathiraMatchList = [
    "Ashwini","Bharani","Kiruthigai","Rohini","Mirugasheeridam","Thiruvathirai","Punarpusham",
    "Pusham","Aayilyam","Magham","pooram","Uththaram","Ashththam","Chitrai","Swathi","Vishakham",
    "Anusham","Keddai","Moolam","pooradam","Uththaradam","Thiruvonam","Aviddam","Sathayam",
    "pooraddaathi","Uththaraddathi","Revathi",
  ];

  static List<Map<String,String>> YoniList =[

{'Nadchathra': "Ashwini",         'Animal': "Horse"},   {'Nadchathra': "Bharani",        'Animal': "Elephant"},
{'Nadchathra': "Kiruthigai",      'Animal': "goat"},    {'Nadchathra': "Rohini",         'Animal': "cobra"},
{'Nadchathra': "Mirugasheeridam", 'Animal': "snake"},   {'Nadchathra': "Thiruvathirai",  'Animal': "Dog"},
{'Nadchathra': "Punarpusham",     'Animal': "Cat"},     {'Nadchathra': "Pusham",         'Animal': "Goat"},
{'Nadchathra': "Aayilyam",        'Animal': "Cat"},     {'Nadchathra': "Magham",         'Animal': "Rat"},
{'Nadchathra': "pooram",          'Animal': "Rat"},     {'Nadchathra': "Uththaram",      'Animal': "ox"},
{'Nadchathra': "Ashththam",       'Animal': "Buffalo"}, {'Nadchathra': "Chitrai",        'Animal': "Tiger"},
{'Nadchathra': "Swathi",          'Animal': "Dear"},    {'Nadchathra': "Vishakham",      'Animal': "Dear"},
{'Nadchathra': "Anusham",         'Animal': "Dog"},     {'Nadchathra': "Keddai",         'Animal': "Dear"},
{'Nadchathra': "Moolam",          'Animal': "Dog"},     {'Nadchathra': "pooradam",       'Animal': "Monkey"},
{'Nadchathra': "Uththaradam",     'Animal': "Cow"},     {'Nadchathra': "Thiruvonam",     'Animal': "Monkey"},
{'Nadchathra': "Aviddam",         'Animal': "Lion"},    {'Nadchathra': "Sathayam",       'Animal': "Horse"},
{'Nadchathra': "pooraddaathi",    'Animal': "Lion"},    {'Nadchathra': "Uththaraddathi", 'Animal': "Cow"},
{'Nadchathra': "Revathi",         'Animal': "Elephant"},

  ];

  static List<List<String>> yoniMismatchingList =[
    ["Monkey", "Goat"],["Lion","Elephant"],
    ["Cat","Rat"],["Snake","Rat"],["Dear","Dog"],["Goat","Monkey"],["Elephant","Lion"],
    ["Horse","Buffalo"],["Cow","Tiger"], ["Cat","Rat"],["Snake","Rat"],["Dear","Dog"]
  ];

  static List<String> Theva = [
    'Aswini',
    'Mrigashrisha',
    'Punarvasu',
    'Pushyami',
    'Hastha',
    'Swaathi',
    'Anuraadha',
    'Shraavan',
    'Revathi'
  ];
  static List<List<String>> vethaiMismatchList = [
    ["Ashwini", "Keddai"],
    ["Bharani", "Anusham"],
    ["Kiruthigai", "Vishakham"],
    ["Rohini", "Swathi"],
    ["Thiruvathirai", "Thiruvonam"],
    ["Punarpusham", "Uththaradam"],
    ["Pusham", "pooradam"],
    ["Aayilyam", "Moolam"],
    ["Magham", "Revathi"],
    ["pooram", "Uththaraddathi"],
    ["Uththaram", "pooraddaathi"],
    ["Ashththam", "Sathayam"],
    ["Mirugasheeridam", "Chitrai", "Aviddam"]
  ];

  static List<String> Manusa = [
    'Bharani',
    'Rohini',
    'Thiruvathirai',
    'pooram',
    'Uththaram',
    'pooradam',
    'Uththaradam',
    'pooraddaathi',
    'Uththaraddaathi'
  ];
  static List<String> Ratchasa = [
    'Kiruthigai',
    'Aayilyam',
    'Magham',
    'Chitrai',
    'Vishakham',
    'Keddai',
    'Moolam',
    'Aviddam',
    'Sathayam'
  ];

  static List<String> Group1 = [
    'Mirugasheeridam',
    'Chitrai',
    'Aviddam',
  ];
  static List<String> Group2 = [
    'Rohini',
    'Thiruvathirai',
    'Ashththam',
    'Swathi',
    'Thiruvonam',
    'Sathayam',
  ];
  static List<String> Group3 = [
    'Kiruthigai',
    'Punarpusham',
    'Uththaram',
    'Vishakham',
    'pooraddaathi'
  ];
  static List<String> Group4 = [
    'Bharani',
    'Pusham',
    'pooram',
    'Anusham',
    'pooradam',
    'Uththaraddathi'
  ];

  static List<String> Group5 = [
    'Ashwini',
    'Aayilyam',
    'Magham',
    'Keddai',
    'Moolam',
    'Revathi'
  ];

  static List<String> Milk = [
    'Mirugasheeridam',
    'Chitrai',
    'Aviddam',
    'Thiruvathirai',
    'Swathi',
    'Sathayam',
    'Punarpusham',
    'Vishakham',
    'Bharani',
    'Uththaraddathi',
    'Anusham',
    'Ashwini',
  ];
  static List<String> NonMilk = [
    'Rohini',
    'Ashththam',
    'Thiruvonam',
    'Kiruthigai',
    'Uththaram',
    'pooraddaathi',
    'Pusham',
    'pooram',
    'pooradam',
    'Aayilyam',
    'Magham',
    'Keddai',
    'Moolam',
    'Revathi'
  ];
}

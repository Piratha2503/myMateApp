class RasiNadchathiram{

  static List<String> rasiListOrder = [
    "Mesham","Rishabam","Mithunam","Kadagam","Simmam","Kanni",
    "Thulam","Viruchigam","Thanusu","Magaram","Kumbam","Meenam",
  ];
  static List<int> rasiMatchNumberList = [ 2,4,6,8 ];

  static List<String> nadchathiraList = [
    "Ashwini" "Bharani" "Kiruthigai" "Rohini" "Mirugasheeridam" "Thiruvathirai" "Punarpusham"
    "Pusham" "Aayilyam" "Magham" "pooram" "Uththaram" "Ashththam" "Chitrai" "Swathi" "Vishakham"
    "Anusham" "Keddai" "Moolam" "pooradam" "Uththaradam" "Thiruvonam" "Aviddam" "Sathayam"
    "pooraddaathi" "Uththaraddathi" "Revathi"
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

  static List<List<String>> yoniMismatchList =[
    ["Monkey" "Goat"],["Lion" "Elephant"],["Horse","Buffalo"],["Cow","Tiger"],
    ["Cat" "Rat"],["Snake" "Rat"],["Dear" "Dog"],["Goat" "Monkey"],["Elephant" "Lion"],
    ["Horse","Buffalo"],["Cow","Tiger"], ["Cat" "Rat"],["Snake" "Rat"],["Dear" "Dog"]
  ];

}
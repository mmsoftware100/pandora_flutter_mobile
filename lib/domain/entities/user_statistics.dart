class UserStatistics{

  String rank; // လက်ရှိရာထူး
  String nextRank; // နောက်ထပ် တိုးမယ့် ရာထူးနာမည်
  int rankProgress; // တိုးဖို့အတွက် ဘယ်လောက်ရာခိုင်နှုန်း လိုသေးတယ်ဆိုတာ ပြမယ်

  String level; // လက်ရှိ အဆင့်
  String nextLevel; // နောက်ထပ် တိုးမယ့် အဆင့်နာမည်
  int levelProgress; // တိုးဖို့အတွက် ဘယ်လောက်ရာခိုင်နှုန်း လိုသေးတယ်ဆိုတာ ပြမယ်

  int questionTotal; // စုစုပေါင်း ဖြေခဲ့သမျှ မေးခွန်း အရေအတွက်
  int questionPassed; // အဖြေမှန် အရေအတွက်
  int questionFailed; // အဖြေမှား အရေအတွက်

  int coinTotal; // စုစုပေါင်း ပွိုင့်
  int coinExchanged; // လဲလှယ်ထားခဲ့သမျှ ပွိုင့်
  int coinCurrent; // လက်ကျန် ပွိုင့်

  String createdAt;
  String updatedAt;

  UserStatistics({
    required this.rank,
    required this.nextRank,
    required this.rankProgress,

    required this.level,
    required this.nextLevel,
    required this.levelProgress,

    required this.questionTotal,
    required this.questionPassed,
    required this.questionFailed,

    required this.coinTotal,
    required this.coinExchanged,
    required this.coinCurrent,

    required this.createdAt,
    required this.updatedAt,
  });



  static UserStatistics get sample{
    return UserStatistics(
      rank: "rank",
      nextRank: "nextRank",
      rankProgress: 0,

      level: "level",
      nextLevel: "nextLevel",
      levelProgress: 0,

      questionTotal: 0,
      questionPassed: 0,
      questionFailed: 0,

      coinTotal: 0,
      coinExchanged: 0,
      coinCurrent: 0,

      createdAt: "createdAt",
      updatedAt: "updatedAt",
    );
  }
}
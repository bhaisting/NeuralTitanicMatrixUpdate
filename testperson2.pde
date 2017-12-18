class testperson {
  int id, survived;
  float age, fare, embarked, sex, name, pclass, sibsp, parch;
  float[] person;
  public testperson(int id, int survived, int pclass, String name, String sex, int age, int sibsp, int parch, double fare, String embarked) {
    //higher number= likely higher survival rate

    this.id=id;//sets id
    this.survived=survived;//sets survived

    //SETS CLASS NUMBER
    if (pclass==1) {//first class
      this.pclass=0.62963;
    } else if (pclass==2) {//second class
      this.pclass=0.47283;
    } else {//third class
      this.pclass=0.24236;
    }
    //SETS NAME NUMBER
    if (name.indexOf("Mr")>-1) {//anyone with mr
      this.name=0.28439;
    } else if (name.indexOf("Mrs")>-1 || name.indexOf("Miss")>-1 || name.indexOf("Ms")>-1) {//any woman
      this.name=0.70166;
    } else {//every other special name
      this.name=0.49206;
    }
    //SETS GENDER NUMBER
    if (sex.equals("male")) {//male
      this.sex=0.1889;
    } else {
      this.sex=0.742;//female
    }
    //SETS AGE NUMBER
    if (age<18) {
      this.age=0.38966;
    } else if (age<40) {
      this.age=0.38356;
    } else {
      this.age=0.37423;
    }

    //SETS SIBSP
    if (sibsp==0) {
      this.sibsp=0.34539;
    } else if (sibsp<=2) {
      this.sibsp=0.52743;
    } else {
      this.sibsp=0.15217;
    }

    //SETS PARCH
    if (parch==0) {
      this.parch=0.34366;
    } else if (parch==1) {
      this.parch=0.55085;
    } else {
      this.parch=0.46316;
    }
    //SETS FARE
    if (fare<20) {
      this.fare=0.27767;
    } else if (fare<50) {
      this.fare=0.41860;
    } else {
      this.fare=0.67702;
    }
    //SETS EMBARK
    if (embarked.equals("C")) {//people at Cherbou
      this.embarked=0.55357;
    } else if (embarked.equals("Q")) {//Queenstown
      this.embarked=0.38961;
    } else {//Southampton
      this.embarked=0.33700;
    }
    //MAKES ARRAY
    person=new float[]{this.pclass, this.name, this.sex, this.age, this.sibsp, this.parch, this.fare, this.embarked, 1};
  }
  public testperson(int pclass, int name, int sex, int age, int sibsp, int parch, int fare, int embarked) {
    //higher number= likely higher survival rate

    //SETS CLASS NUMBER
    if (pclass==0) {//first class
      this.pclass=0.62963;
    } else if (pclass==1) {//second class
      this.pclass=0.47283;
    } else {//third class
      this.pclass=0.24236;
    }
    //SETS NAME NUMBER
    if (name==0) {//anyone with mr
      this.name=0.28439;
    } else if (name==1) {//any woman
      this.name=0.70166;
    } else {//every other special name
      this.name=0.49206;
    }
    //SETS GENDER NUMBER
    if (sex==0) {//male
      this.sex=0.1889;
    } else {
      this.sex=0.742;//female
    }
    //SETS AGE NUMBER
    if (age==0) {
      this.age=0.38966;
    } else if (age==1) {
      this.age=0.38356;
    } else {
      this.age=0.37423;
    }

    //SETS SIBSP
    if (sibsp==0) {
      this.sibsp=0.34539;
    } else if (sibsp==1) {
      this.sibsp=0.52743;
    } else {
      this.sibsp=0.15217;
    }

    //SETS PARCH
    if (parch==0) {
      this.parch=0.34366;
    } else if (parch==1) {
      this.parch=0.55085;
    } else {
      this.parch=0.46316;
    }
    //SETS FARE
    if (fare==0) {
      this.fare=0.27767;
    } else if (fare==1) {
      this.fare=0.41860;
    } else {
      this.fare=0.67702;
    }
    //SETS EMBARK
    if (embarked==0) {//people at Cherbou
      this.embarked=0.55357;
    } else if (embarked==1) {//Queenstown
      this.embarked=0.38961;
    } else {//Southampton
      this.embarked=0.33700;
    }
    //MAKES ARRAY
    person=new float[]{this.pclass, this.name, this.sex, this.age, this.sibsp, this.parch, this.fare, this.embarked, 1};
  }
  public void setsurv(int x) {
    survived=x;
  }
  public float[] eyyray() {
    return person;
  }
  public String toString() {
    return id+" "+survived;
  }
}
Table train;
ArrayList<testperson> trainpeople, testpeople;
float[][] frontweight, backweight;
float eint =2.71828182845904523536028747135266249775724709369995;
float learningnum = 0.01;
function func;
float totalerror;
int testnum=0;
int count;
boolean realsample=false;
boolean click=false;
String[] realstrings;
boolean[] realpeople;
float realsurvive;
boolean calculate=false;
boolean finalpage=false;
boolean matrixpage=false;
PImage multi,onet;
void setup() {
  size(800, 800);
  realpeople=new boolean[24];
  String[] realstringmaker={"Pclass", "First class", "Second class", "Third class", "Name", "Mr.", "Mrs, Miss, or Ms.", "Other", "Sex", "Male", "Female", "", "Age", "Less than 18", "Less than 40", "Greater than 40", "Siblings and \nspouses", "\t0", "2 or Less", "Greater than 2", "Parents and \nchildren", "\t0", "\t1", "Greater than 1", "Fare", "Less than 20", "Less than 50", "Greater than 50", "Port", "Cherbou", "Queenstown", "Southampton"};
  realstrings=realstringmaker;
  func=new function();
  multi=loadImage("multi.png");
  multi.resize(150,300);
  onet=loadImage("onet.png");
  onet.resize(300,300);
  trainpeople = new ArrayList<testperson>();
  testpeople= new ArrayList<testperson>();
  train = loadTable("train.csv", "header");
  for (TableRow row : train.rows()) {//makes the test people into testperson objects
    int id=row.getInt("PassengerId");
    int survived=row.getInt("Survived");
    int pclass=row.getInt("Pclass");
    String name=row.getString("Name");
    String sex=row.getString("Sex");
    int age=row.getInt("Age");
    int sibsp=row.getInt("SibSp");
    int parch=row.getInt("Parch");
    double fare=row.getDouble("Fare");
    String embarked=row.getString("Embarked");
    trainpeople.add(new testperson(id, survived, pclass, name, sex, age, sibsp, parch, fare, embarked));
  }
  train = loadTable("test.csv", "header");
  for (TableRow row : train.rows()) {//makes the test people into testperson objects
    int id=row.getInt("PassengerId");
    int survived=0;
    int pclass=row.getInt("Pclass");
    String name=row.getString("Name");
    String sex=row.getString("Sex");
    int age=row.getInt("Age");
    int sibsp=row.getInt("SibSp");
    int parch=row.getInt("Parch");
    double fare=row.getDouble("Fare");
    String embarked=row.getString("Embarked");
    testpeople.add(new testperson(id, survived, pclass, name, sex, age, sibsp, parch, fare, embarked));
  }
  train = loadTable("gender_submission.csv", "header");
  for (TableRow row : train.rows()) {
    int survived=row.getInt("Survived");
    testpeople.get(row.getInt("PassengerId")-892).setsurv(survived);
  }
  frontweight = new float[4][9];
  backweight = new float[1][4];
  func.resetweights();
  System.out.println("go!");
  System.out.println(func.runtest());
}
void mouseClicked() {
  click=true;
}
void draw() {
  textAlign(LEFT);
  if (realsample==false && calculate==false) {
    if (mouseX>200 && mouseX<350 && mouseY>725 && mouseY<775 && click && !matrixpage) {
      func.runcycle();
    }
    if (mouseX>400 && mouseX<550 && mouseY>725 && mouseY<775 && click) {
      int count=0;
      while (!func.runtest().equals("418 out of 418")) {
        func.runcycle();
        func.drawit();
        count++;
        if (count>1000) {
          func.resetweights();
          count=0;
          testnum=0;
        }
      }
    }
    if (mouseX>600 && mouseX<750 && mouseY>725 && mouseY<775 && click) {
      func.resetweights();
      testnum=0;
    }
    func.drawit();
    if (func.runtest().equals("418 out of 418")) {

      if (mouseX>600 && mouseX<750 && mouseY>650 && mouseY<700) {
        fill(#08AD00);
      } else {
        fill(255);
      }
      rect(600, 650, 150, 50);
      fill(0);
      textSize(12);
      text("Run person", 640, 680);
      if (mouseX>600 && mouseX<750 && mouseY>650 && mouseY<700 && click) {
        realsample=true;
      }
    }
    if (mouseX>600 && mouseX<750 && mouseY>575 && mouseY<625 && click) {
      matrixpage=true;
    }
  }
  if (realsample) {
    func.testshow();
    int count=0;
    for (int i=0; i<24; i+=3) {
      int truecount=0;
      if (realpeople[i]) {
        truecount++;
      }
      if (realpeople[i+1]) {
        truecount++;
      }
      if (realpeople[i+2]) {
        truecount++;
      }
      if (truecount==1) {
        count++;
      } else {
        count+=9;
      }
    }
    if (count==8) {
      calculate=true;
      realsample=false;
    }
  }
  if (calculate && finalpage==false) {
    System.out.println("calc");
    int[] sample=new int[8];
    for (int i=0; i<24; i++) {
      if (realpeople[i]) {
        sample[i/3]=i%3;
      }
    }
    testperson me = new testperson(sample[0], sample[1], sample[2], sample[3], sample[4], sample[5], sample[6], sample[7]);
    realsurvive=func.runperson(me);
    finalpage=true;
  }
  if (finalpage) {
    if (realsurvive>0.5) {
      func.survived();
    } else {
      func.died();
    }
    fill(150);
    rect(100, 100, 200, 100);
    fill(0);
    text("BACK", 200, 150);
    if (mouseX>100 && mouseX<300 && mouseY>100 && mouseY<200 && click) {
      finalpage=false;
      calculate=false;
      realsample=false;
      for (int i=0; i<realpeople.length; i++) {
        realpeople[i]=false;
      }
    }
  }
    if(matrixpage){
      background(255);
      fill(0);
      textSize(12);
    for(int i=0;i<frontweight.length;i++){
      for(int j=0;j<frontweight[i].length;j++){
        text(nf(frontweight[i][j],1,3),j*60,100+i*40);
      }
    }
    image(multi,540,15);
    for(int i=0;i<backweight[0].length;i++){
      text(nf(backweight[0][i],1,3),200+i*60,550);
    }
    image(onet,440,395);
    fill(150);
    rect(100, 680, 200, 100);
    fill(0);
    text("BACK", 187, 735);
    if (mouseX>100 && mouseX<300 && mouseY>680 && mouseY<780 && click) {
     matrixpage=false;
    }
  }
  click=false;
}
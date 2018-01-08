class function {
  public float sigmoid(float x) {
    return (1/(1+(pow(eint, -x))));
  }
  public float errorcalc(float surv, float oout) {
    return 0.5*pow(oout-surv, 2);
  }
  public float backderiv(int surv, float oout, float onet, float hout) {//closer to output
    float etonum=pow(eint, -onet);
    float val=(oout-surv)*(etonum/pow(1+etonum, 2))*hout;
    if (Float.isNaN(val)) {
      val=0;
    }
    return val;
  }
  public float frontderiv(int surv, float oout, float onet, float backw, float hnet, float characteristicnum) {//closer to input     
    float etonum=pow(eint, -hnet);
    float val=backderiv(surv, oout, onet, backw)*(etonum/pow(1+etonum, 2))*characteristicnum;
    if (Float.isNaN(val)) {
      val=0;
    }
    return val;
  }
  public String runtest() {
    int total=0;
    int amount=0;
    for (int people=0; people<testpeople.size(); people++) {
      float[] person=testpeople.get(people).eyyray();
      float[] hout=new float[5];
      float onet, oout;
      int surv=testpeople.get(people).survived;
      float[] hnet=matmult(frontweight, person);
      for (int i=0; i<hnet.length; i++) {
        hout[i]=func.sigmoid(hnet[i]);
      }
      hout[hout.length-1]=1;
      onet=matmult(backweight, hout)[0];
      oout=func.sigmoid(onet);
      total++;
      if (round(oout)==surv) {
        amount++;
      }
    }
    return amount+" out of "+total;
  }
  public void runcycle() {
    for (int people=0; people<trainpeople.size(); people++) {
      float[] person=trainpeople.get(people).eyyray();
      float[] hout=new float[5];
      float onet, oout;
      int surv=trainpeople.get(people).survived;
      float[] hnet=matmult(frontweight, person);
      for (int i=0; i<hnet.length; i++) {
        hout[i]=func.sigmoid(hnet[i]);
      }

      hout[hout.length-1]=1;
      onet=matmult(backweight, hout)[0];
      oout=func.sigmoid(onet);
      //BACKPROPOGATION BEGINS HERE
      for (int i = 0; i<frontweight.length; i++) {//front weights
        for (int j= 0; j<frontweight[i].length; j++) {
          frontweight[i][j]-=learningnum*func.frontderiv(surv, oout, onet, backweight[0][i], hnet[i], person[j]);
        }
      }
      for (int i=0; i<backweight.length; i++) {
        backweight[0][i]-=learningnum*func.backderiv(surv, oout, onet, hout[i]);
      }
      click=false;
    }
    func.drawit();
    testnum++;
    System.out.println("Times through: "+testnum+" Success: "+func.runtest());
    click=false;
  }
  public float runperson(testperson peep) {
    testperson personpoints = peep;
    float[] person = personpoints.eyyray();
    float[] hout=new float[5];
    float onet, oout;
    float[] hnet=matmult(frontweight, person);
    for (int i=0; i<hnet.length; i++) {
      hout[i]=func.sigmoid(hnet[i]);
    }
    hout[hout.length-1]=1;
    onet=matmult(backweight, hout)[0];
    oout=func.sigmoid(onet);
    System.out.println(oout);
    click=false;
    return oout;
  }
  public void testshow() {
    background(150);
    for (int i=0; i<8; i++) {
      fill(0);
      rect(40, 40+i*95, 150, 55);
    }
    for (int i=0; i<24; i++) {
      if (mouseX>190*(i%3)+230 && mouseX<190*(i%3)+380 && mouseY>40+(i/3)*95 && mouseY<95+(i/3)*95 && click && !realpeople[i]) {
        realpeople[i]=true;
        fill(#3BCB15);
      } else if (mouseX>190*(i%3)+230 && mouseX<190*(i%3)+380 && mouseY>40+(i/3)*95 && mouseY<95+(i/3)*95 && click) {
        realpeople[i]=false;
        fill(255);
      } else if (realpeople[i]) {
        fill(#3BCB15);
      } else if (mouseX>190*(i%3)+230 && mouseX<190*(i%3)+380 && mouseY>40+(i/3)*95 && mouseY<95+(i/3)*95) {
        fill(#3BCB15);
      } else {
        fill(255);
      }
      rect(190*(i%3)+230, 40+(i/3)*95, 150, 55);
    }
    for (int i=0; i<32; i++) {
      if (i%4==0) {
        fill(255);
      } else {
        fill(0);
      }
      textSize(16);
      text(realstrings[i], 45+(i%4)*190, 60+(i/4)*95);
    }
  }
  public void survived() {
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("YOU SURVIVED\nOUTPUT: "+realsurvive, 400, 400);
  }
  public void died() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("YOU DIED\nOUTPUT: "+realsurvive, 400, 400);
  }

  public float[] matmult(float[][] weight, float[] mult) {
    float[] answer = new float[weight.length];
    for (int i=0; i<weight.length; i++) {
      float sum=0;
      for (int j=0; j<weight[i].length; j++) {
        sum+=weight[i][j]*mult[j];
      }
      answer[i]=sum;
    }
    return answer;
  }
  public void resetweights() {
    for (int i=0; i<frontweight.length; i++) {
      for (int j=0; j<frontweight[i].length; j++) {
        frontweight[i][j]=random(-1, 1);
      }
    }
    for (int i = 0; i<backweight[0].length; i++) {
      backweight[0][i]=random(-1, 1);
    }
  }
 public void drawit() {
    background(150);
    fill(255);
    strokeWeight(2);
    stroke(0);
    if (mouseX>200 && mouseX<350 && mouseY>725 && mouseY<775) {
      fill(#08AD00);
    } else {
      fill(255);
    }
    rect(200, 725, 150, 50);
    if (mouseX>400 && mouseX<550 && mouseY>725 && mouseY<775) {
      fill(#08AD00);
    } else {
      fill(255);
    }
    rect(400, 725, 150, 50);
    if (mouseX>600 && mouseX<750 && mouseY>725 && mouseY<775) {
      fill(#08AD00);
    } else {
      fill(255);
    }
    rect(600, 725, 150, 50);
        if (mouseX>600 && mouseX<750 && mouseY>575 && mouseY<625) {
      fill(#08AD00);
    } else {
      fill(255);
    }
    rect(600, 575, 150, 50);
    fill(0);
    textSize(12);
    text("Run one cycle", 235, 750);
    text("Run to 100%", 435, 750);
    text("Reset weights", 635, 750);
    text("Matrix multiplication", 615, 600);
    fill(255);
    strokeWeight(2);
    for (int i=1; i<=9; i++) {
      ellipse(100, 80*i, 60, 60);
    }
    for (int i=1; i<=5; i++) {
      ellipse(400, 130*i, 80, 80);
    }
    ellipse(700, 400, 100, 100);
    for (int i = 0; i<frontweight.length; i++) {
      for (int j = 0; j<frontweight[i].length; j++) {
        if (frontweight[i][j]<0) {
          stroke(0);
        } else {
          stroke(255);
        }
        strokeWeight(abs(frontweight[i][j]*10));
        line(100, (j+1)*80, 400, (i+1)*130);
      }
    }
    for (int i = 0; i<backweight[0].length; i++) {
      if (backweight[0][i]<0) {
        stroke(0);
      } else {
        stroke(255);
      }
      strokeWeight(abs(backweight[0][i]*10));
      line(400, (i+1)*130, 700, 400);
    }
    fill(0);
    textSize(32);
    text("pclass", 5, 130);
    text("name", 5, 210);
    text("sex", 5, 290);
    text("age", 5, 370);
    text("sibsp", 5, 450);
    text("parch", 5, 530);
    text("fare", 5, 610);
    text("port", 5, 690);
    text("bias", 5, 770);
    text("hidden1", 380, 80);
    text("hidden2", 380, 210);
    text("hidden3", 380, 340);
    text("hidden4", 380, 470);
    text("bias", 380, 600);
    text("output", 650, 340);
    fill(255);
    stroke(0);
    strokeWeight(2);
    rect(340, 0, 460, 40);
    fill(0);
    text("Cycles: "+testnum, 350, 30);
    text(func.runtest(), 550, 30);
  }
}
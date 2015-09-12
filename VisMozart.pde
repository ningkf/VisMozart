Table myTable;
String filename = "mozart.csv";
PImage img;
PFont chancery;
PFont gothic;
String[] allData;
String[] rowData;
int []  years = new int[16];
String []  mozart = new String[16];
String [] event= new String[16];
float[] positionY= new float[16];
float [] positionX= new float[16];
PVector circle;
PVector[] position = new PVector[16];
ArrayList<PVector> trail;
int trailSize = 30;
float[] textX;
int a =3;
int b = 6;
int x;
int y;
int r1;
int margin = 100;
int c=0;
int [] p;
int pi;
int yearnum;
int speed;
float[]eve =new float[16];
float yPos;
float xPos;

void setup() {
  size(800, 800);
  background(0);
  smooth();
  chancery = loadFont("Apple-Chancery-20.vlw");
  gothic = loadFont("AppleGothic-16.vlw");
  img = loadImage("info-02-02.png");
  textFont(chancery);
  speed=1;
  myTable = new Table("mozart.csv");
  circle = new PVector(x, y);
  trail = new ArrayList<PVector>();
  for (int i =0; i< myTable.rowsLength;i++) {
    years[i]=myTable.getInt(i, 0);
    mozart[i]=myTable.getString(i, 1);
    event[i]= myTable.getString(i, 2);
  }
  pi = 8;
  x=0;
  y=0;
  r1 = 10;
}

void draw() {
  noStroke();
  circle();
  cacul(); 
  path();
  playtext();
  displayYears();
}

void cacul() {
  int yearsMin = 1756;
  int yearsMax = 1791;
  yearnum = years.length;
  float positionY[] = new float[years.length];
  int p[] = new int [years.length];
  a=0;
  for (int i=0; i<years.length; i++) {
    pi+=6;
    p[i] = pi;
    float mapYear = map(years[i], yearsMin, yearsMax, 0, height-margin-margin);
    float yPos = margin + mapYear;
    float xPos = mapYear+margin;
    position[i] = new PVector(xPos, yPos);
    positionY[i] = yPos; 
    positionX[i] = xPos;
    float distance = dist(position[i].x, position[i].y, width, height);
    eve[i] = distance;
  }
}
//years text
void displayYears() {
  textFont(gothic);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(13);
  float theta = 7*PI/4;
  color a = color(255);
  for (int i=0; i<yearnum; i++) {
    pushMatrix();
    translate(position[i].x, position[i].y);
    rotate(theta);
    fill(255);
    text(years[i], 0, 0);
    popMatrix();
    if (y>position[i].y-5 && y<position[i].y+5) {
      noFill();  
      stroke(255);
      strokeWeight(8);
      ellipse(width, height, eve[i]*2, eve[i]*2);
      a = color(0);
      pushMatrix();
      translate(position[i].x, position[i].y);
      rotate(theta);
      fill(0);
      text(years[i], 0, 0);
      popMatrix();
    }
  }
}

//year range
void circle() {
  background(0);
  circle = new PVector(x, y);
  for (int i=0; i< yearnum; i++) {
    if (event[i].length()>0) {
      fill(29, 84, 178, 30);
      stroke(#F5FACF, 50);
      strokeWeight(3);
      ellipse(width, height, eve[i]*2, eve[i]*2);
      println("0");
    }
  }
  for (int a =0; a<yearnum-1; a++) {
    if (y<position[a].x && y<position[a+1].y && event[a].length()>0) {
      noStroke();
      fill(255, 0, 0, 50);
      ellipse(width, height, eve[a]*2, eve[a]*2);
    }
  }
  noFill();
  noStroke();
}


void path() {
  x++;
  y++;
  x+=speed;
  y+=speed;
  speed+=0.1;
  fill(255, 80);
  int trailLength;
  trail.add(circle);
  trailLength = trail.size() - 2;
  PVector previousTrail;
  int previousl = 10;
  //create trail when move
  for (int a = 0; a< trailLength; a ++) {
    PVector currentTrail = trail.get(a);
    previousTrail = trail.get(a+1);
    stroke(#F5FACF, 255*a/trailLength);
    strokeWeight(8*a/trailLength);
    line(currentTrail.x, currentTrail.y, 
    previousTrail.x, previousTrail.y);
  }
  if (trailLength >= trailSize ) {
    trail.remove(0);
  }
  //moving circle
  for (int i = 0; i < yearnum; i++) {
    if (circle.y >= position[i].y-3 && circle.y <= position[i].y +3) {
      r1 = 10;
    }
    else {
      r1=5;
    }
    fill(#EAF0BF);
    ellipse(circle.x, circle.y, r1, r1);
  }

  noStroke();
  noFill();
}

void playtext() {
  textFont(chancery);
  stroke(255);
  strokeWeight(3);
  rect(640, 50, 100, 100);
  fill(255);
  textSize(22);
  textLeading(27);
  textAlign(LEFT, CENTER);
  text("Mozart   and his   Life", 650, 50, 100, 100);
  imageMode(CORNER);
  image(img, 639, 150, 103, 200);
  for (int i=0; i<yearnum-1; i++) {
    textLeading(20);
    if (y>height && dist(mouseX, mouseY, width, height)<eve[i]&& dist(mouseX, mouseY, width, height)>eve[i+1]&& event[i].length()>0) {
      println("over");
      textAlign(LEFT, CORNER);
      fill(255);
      text(years[i]+" "+event[i], 50, height-200, 300, 300);
      noFill();
      stroke(255);
      strokeWeight(5);
      ellipse(width, height, eve[i]*2, eve[i]*2);
      ellipse(width, height, eve[i+1]*2, eve[i+1]*2);
    }
    if ( event[i].length() ==0) {
      noFill();  
      stroke(255, 50);
      strokeWeight(3);
      ellipse(width, height, eve[i]*2, eve[i]*2);
      println("hi");
    }
    if (y > position[i].y && y < position[i+1].y ) {
      if (event[i].length()>0) {
        textAlign(LEFT, CORNER);
        fill(255);
        text(years[i]+" "+event[i], 50, height-200, 300, 300);
      }
      if (mozart[i].length() >0 && i<11) {
        fill(255);
        textAlign(LEFT);
        text("Mozart"+" "+mozart[i], circle.x+30, circle.y+10, 200, 200);
      }
    }
    if (y > position[i].y && y < position[i+1].y && i>=11 && mozart[i].length()>0 ) {
      textAlign(RIGHT);
      fill(255);
      text("Mozart"+" "+mozart[i], circle.x-250, y+10, 200, 400);
    }
    else if (y> position[15].y) {
      fill(255);
      text("Mozart"+" "+mozart[15], circle.x-250, y+10, 200, 400);
      println("last");
    }
  }
  noStroke();
}


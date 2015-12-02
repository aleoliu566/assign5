final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_WIN=2;
final int GAME_OVER=3;
final int ENEMY_0=0;
final int ENEMY_1=1;
final int ENEMY_2=2;
int gameState;
int enemyType=0;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

PImage fighter,hp,treasure;
PImage start1,start2,end1,end2;
PImage enemy,bg1,bg2;
int enemyCount = 8;
int c=0;
int[] enemyX = new int[enemyCount];
int[] enemyY = new int[enemyCount];
int hpy=200;
float tx,ty;
int shipx,shipy;
int speed=6;
int score=0;

//bullet
PImage[] shoot = new PImage[6];
int [] bullet_x={0,1,2,3,4};
int [] bullet_y={0,1,2,3,4};
int bullet=1;
int space;

void setup () {
  size(640, 480) ;
  enemy=loadImage("img/enemy.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");

   tx = random(600);
   ty = random(440);
   shipx = width-50;
   shipy = height/2;

  for(int i =0; i<shoot.length;i++){
      shoot[i]=loadImage("img/shoot.png"); 
    }
  for(int i=0;i<=4;i++){
    bullet_x[i]=-300;
    bullet_y[i]=-300;
  }
}

void draw(){
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseX > 205 && mouseX <455){
        if(mouseY >380 && mouseY <415){
          image(start1,0,0);
            if(mousePressed)
              gameState = GAME_RUN;
              enemyType=0;
              addEnemy(0);
              //bullet=1;
        }
      }
      break;
    case GAME_RUN:
      //bacgground
      image(bg2,c,0);
      image(bg1,c-640,0);
      image(bg2,c-1280,0);
      c++;
      c=c%1280;
      //fighter&treasure
      image(fighter,shipx,shipy);
      image(treasure,tx,ty);
      //blood
      fill(255,0,0);
      rect(18, 13, hpy, 20);
      image(hp,10,10);   
      //score
      fill(255);
      textSize(32);
      text("score:"+score, 20, 450); 
      //bullet
      bulletnumber();
      
      //treasure
      if (isHit(shipx, shipy ,fighter.width, fighter.height
      ,tx, ty, treasure.width, treasure.height) == true){
          //hpy=hpy+20;
          if(hpy<200)
            hpy=hpy+20;
          tx = random(600);
          ty = random(440);
      }
        switch(enemyType){
            //the first enemy
            case ENEMY_0:
                drawEnemy();
                if(enemyX[1]>1000){
                  addEnemy(1);
                  enemyType=1;
                }
                for(int i =0;i<enemyX.length;i++){
                  if (isHit(shipx, shipy ,fighter.width, fighter.height
                  ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                      enemyY[i] = -1000;
                      hpy=hpy-20;
                  }
                  for(int j=0;j<bullet_x.length;j++){
                      if (isHit(bullet_x[j], bullet_y[j] ,shoot[j].width, shoot[j].height
                      ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                          enemyY[i] = -1000;
                          bullet_y[j]=-300;
                          bullet_x[j]=-300;
                          scoreChange(20);
                      }
                   }
                }
                if(hpy<=0){
                   gameState=3;
                }
            break;
            //the second enemy
            case ENEMY_1:
                drawEnemy();
                if(enemyX[2]>1000){
                  addEnemy(2);
                  enemyType=2;
                }
                for(int i =0;i<enemyX.length;i++){
                  if (isHit(shipx, shipy ,fighter.width, fighter.height
                  ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                      enemyY[i] = -1000;
                      hpy=hpy-20;
                  }
                  for(int j=0;j<bullet_x.length;j++){
                      if (isHit(bullet_x[j], bullet_y[j] ,shoot[j].width, shoot[j].height
                      ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                          enemyY[i] = -1000;
                          bullet_y[j]=-300;
                          bullet_x[j]=-300;
                          scoreChange(20);
                      }
                   }
                }
                if(hpy<=0){
                   gameState=3;
                }
            break;
            //the thid enemy  
            case ENEMY_2:
                drawEnemy();
                if(enemyX[3]>1000){
                  addEnemy(0);
                  enemyType=0;
                }
                for(int i =0;i<enemyX.length;i++){
                  if (isHit(shipx, shipy ,fighter.width, fighter.height
                  ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                      enemyY[i] = -1000;
                      hpy=hpy-20;
                  }
                  for(int j=0;j<bullet_x.length;j++){
                      if (isHit(bullet_x[j], bullet_y[j] ,shoot[j].width, shoot[j].height
                      ,enemyX[i], enemyY[i], enemy.width, enemy.height) == true){
                          enemyY[i] = -1000;
                          bullet_y[j]=-300;
                          bullet_x[j]=-300;
                          scoreChange(20);
                      }
                   }
                }
                if(hpy<=0){
                   gameState=3;
                }
              break;
            }

      if(upPressed){
        shipy -= speed;
      }
      if(downPressed){
        shipy += speed;
      }
      if(leftPressed){
        shipx -= speed;
      }
      if(rightPressed){
        shipx += speed;
      }
      if(shipx>=width-50){
        shipx = width-50;
      }
      if(shipx<=0){
        shipx = 0;
      }
      if(shipy>=height-50){
        shipy = height-50;
      }
      if(shipy<=0){
        shipy = 0;
      }
      
      break;
    case GAME_OVER:
      image(end2,0,0);
        //flameX=1000;
        //flameY=1000;
        if(mouseX > 205 && mouseX <440){
          if(mouseY >305 && mouseY <350){
            image(end1,0,0);
              if(mousePressed){
                gameState = GAME_RUN;
                hpy=40;
                score=0;
                shipx = width-50;
                shipy = height/2;
                addEnemy(0);
              }
           }
        }
      break;
    }
}
/*
void enemyChange(int state){
  if (enemyX[5] == -1 && enemyX[4] > width + 200){        
    enemyType = state;
    addEnemy(state);
  }else if(enemyX[7] > width + 400){
    enemyType = state;
    addEnemy(state);
  }
}  */

void drawEnemy(){
  for (int i = 0; i < enemyCount; ++i) {
    if (enemyX[i] != -1 || enemyY[i] != -1) {
      image(enemy, enemyX[i], enemyY[i]);
      enemyX[i]+=5;
    }
  }
}


// 0 - straight, 1-slope, 2-dimond
void addEnemy(int type)
{  
  for (int i = 0; i < enemyCount; ++i) {
    enemyX[i] = -1;
    enemyY[i] = -1;
  }
  switch (type) {
    case 0:
      addStraightEnemy();
      break;
    case 1:
      addSlopeEnemy();
      break;
    case 2:
      addDiamondEnemy();
      break;
  }
}

void addStraightEnemy()
{
  float t = random(height - enemy.height);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {

    enemyX[i] = (i+1)*-80;
    enemyY[i] = h;
  }
}
void addSlopeEnemy()
{
  float t = random(height - enemy.height * 5);
  int h = int(t);
  for (int i = 0; i < 5; ++i) {

    enemyX[i] = (i+1)*-80;
    enemyY[i] = h + i * 40;
  }
}
void addDiamondEnemy()
{
  float t = random( enemy.height * 3 ,height - enemy.height * 3);
  int h = int(t);
  int x_axis = 1;
  for (int i = 0; i < 8; ++i) {
    if (i == 0 || i == 7) {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h;
      x_axis++;
    }
    else if (i == 1 || i == 5){
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 1 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 1 * 40;
      i++;
      x_axis++;
      
    }
    else {
      enemyX[i] = x_axis*-80;
      enemyY[i] = h + 2 * 40;
      enemyX[i+1] = x_axis*-80;
      enemyY[i+1] = h - 2 * 40;
      i++;
      x_axis++;
    }
  }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
  if(key==' '){
    if(bullet==1){
      bullet_x[0]=shipx;
      bullet_y[0]=shipy;
      space = 1;
    }
    if(bullet==2){
      space = 2;
      bullet_x[1]=shipx;
      bullet_y[1]=shipy;
    }
    if(bullet==3){
      space = 3;
      bullet_x[2]=shipx;
      bullet_y[2]=shipy;
    }
    if(bullet==4){
      space = 4;
      bullet_x[3]=shipx;
      bullet_y[3]=shipy;
    }
    if(bullet==5){
      space = 5;
      bullet_x[4]=shipx;
      bullet_y[4]=shipy;
    }
    if(bullet==6){
      space=6;
    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }}}

void scoreChange(int value){
    score =score+value;
}
boolean isHit(float ax,float ay,float aw,float ah,float bx,float by,float bw,float bh){
  if (ax >= bx - aw && ax <= bx + bw && ay >= by - ah && ay <= by + bh){
  return true;
  }
  return false;  
}


void bulletnumber(){
  if(space==1){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=2;
         }else{
           bullet=7;
         }
       }
       image(shoot[1],bullet_x[0],bullet_y[0]);
       if(space==2){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=3;
         }else{
           bullet=8;
         }
         //bullet=3;
       }
       image(shoot[2],bullet_x[1],bullet_y[1]);
      if(space==3){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=4;
         }else{
           bullet=9;
         }
         //bullet=4;
       }
       image(shoot[3],bullet_x[2],bullet_y[2]);
       if(space==4){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
           bullet=5;
         }else{
           bullet=10;
         }
         //bullet=5;
       }
       image(shoot[4],bullet_x[3],bullet_y[3]);
       if(space==5){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0){
            bullet=1;
         }else{
            bullet=6;
      }  
       }
       image(shoot[5],bullet_x[4],bullet_y[4]);
       if(space==6){
         bullet_x[4]=bullet_x[4]-3;         
         bullet_x[3]=bullet_x[3]-3;
         bullet_x[2]=bullet_x[2]-3;
         bullet_x[1]=bullet_x[1]-3;
         bullet_x[0]=bullet_x[0]-3;
         if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
            bullet=1;
       }
       for(int i=7;i<10;i++){
         if(bullet==i){
             if(bullet_x[0]<0||bullet_x[1]<0||bullet_x[2]<0||bullet_x[3]<0||bullet_x[4]<0)
             bullet=i-5;
             println(bullet);
         }
       }
}


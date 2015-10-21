PImage fighter, background, backgroundTwo, hpImg, treasure, enemy;
PImage startOne, startTwo, endOne, endTwo; 
int treasureX, treasureY, enemyX, enemyY, x, fighterX, fighterY, gamestate, speed=5;
float hp;
final int GAME_START = 1, GAME_RUN = 2, GAME_END = 3;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;

void setup () {
  size(640,480) ; 
  
  fighter = loadImage("img/fighter.png");  //fighter
  
  hpImg = loadImage("img/hp.png"); 
  hp=196*0.2;  //hp
  
  treasure = loadImage("img/treasure.png");  
  treasureX=floor(random(20,520));  
  treasureY=floor(random(50,430));  //treasure random
  
  enemy = loadImage("img/enemy.png");
  enemyX=10;
  enemyY=floor(random(50,400));  //enemy random
  
  background=loadImage("img/bg1.png");
  backgroundTwo=loadImage("img/bg2.png");
  startOne = loadImage("img/start2.png");
  startTwo = loadImage("img/start1.png");
  endOne = loadImage("img/end2.png");
  endTwo = loadImage("img/end1.png");
  
  fighterX=570;
  fighterY=240;  //fighter position
  
  gamestate = GAME_START;
  x=0;
}


void draw() {
  background(0);
  
  switch(gamestate){
    case GAME_START:
      image(startOne,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>370 && mouseY<420){
      image(startTwo,0,0);
        if(mousePressed){
        gamestate=2;}
    }
      break;
      
    case GAME_RUN:
    
      //background moving
      image(backgroundTwo,x,0);
      image(background,x-640,0);
      image(backgroundTwo,x-1280,0);
      x++;
      x=x%1280;  
            
      // fighter moving
      image(fighter, fighterX, fighterY); 
      if(upPressed){
      fighterY -= speed;
      }
      if(downPressed){
      fighterY += speed;
      }
      if(leftPressed){
      fighterX -= speed;
      }
      if(rightPressed){
      fighterX += speed;
      }
      // fighter boundary ditection
      if(fighterX>width-fighter.width){
      fighterX=width-fighter.width;
      }
      if(fighterX<0){
      fighterX=0;
      }
      if(fighterY>height-fighter.height){
      fighterY=height-fighter.height;
      }
      if(fighterY<0){
      fighterY=0;
      }
      
      //eating treasure
      image(treasure,treasureX,treasureY);
      if(fighterY+fighter.height*4/5>treasureY && fighterY+fighter.height/5<treasureY+treasure.height && fighterX<treasureX+treasure.width && fighterX+fighter.width>treasureX){
      treasureX=floor(random(20,520));  
      treasureY=floor(random(50,430));
      hp += 196*0.1;
      if(hp>196){
      hp=196;
      }
      }
      
      //hp
      stroke(255,0,0,230);
      fill(255,0,0,230);
      rect(20,12,hp,18);  
      image(hpImg,10,10);
          
     
      //enemy moving
      image(enemy,enemyX,enemyY);
      enemyX+=3 ;
      enemyX=enemyX%640;
      if(enemyY<fighterY && enemyX<fighterX){
      enemyY+=2;
      }
      if(enemyY>fighterY && enemyX<fighterX){
      enemyY-=2;
      }
      
                   
      
      //bump into enemy 
      if(fighterY+fighter.height*4/5>enemyY && fighterY+fighter.height/5<enemyY+enemy.height && fighterX<enemyX+enemy.width && fighterX+fighter.width>enemyX){
      enemyX=0-enemy.width;
      enemyY=floor(random(50,400));
      hp -= 196*0.2;
      if(hp<=1){
      gamestate=3;
      }
      }
      
      break;
  
   
    case GAME_END:   
      image(endOne,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>300 && mouseY<350){
      image(endTwo,0,0);
        if(mousePressed){
        gamestate=2;
        fighterX=570;
        fighterY=240;
        treasureX=floor(random(20,520));  
        treasureY=floor(random(50,430));
        hp=196*0.2;
        
        }
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
    }
  }
  }

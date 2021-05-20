//HTML

<div id="canvas-wrapper">

  <canvas id="canvas" width="500" height="500"></canvas>

</div>

 
//CSS

html, body {

  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;

}

#canvas-wrapper {

  width: 500px;
  margin: auto;
  border: 2px solid black;

}

//DART

import 'dart:html';

import 'dart:math';

import 'dart:async';


CanvasElement canvas;

CanvasRenderingContext2D ctx;

class Ball {

  double x = 50.0;

  double y = 50.0;

  int r = 15;

  double vx = 0.0;

  double vy = 0.0;

  Ball(this.x,this.y);


  velocity(){

    x += vx;

    y += vy;

  }

  drag(){

    vx *= 0.99;

    vy *= 0.99;

  }

  gravity(){

    vy += 0.25;

    vx += 0.25;

  }

  collisionCheck(){

      if(y + r > canvas.height ) {

        y = (canvas.height - r).toDouble();

        vy *= (-1);

      }

    if(x + r > canvas.width ) {

      x = (canvas.width - r).toDouble();

      vx *= (-1);

    }

}

translate(){

    ctx.save();

    ctx.translate(x,y);

    ctx.fillStyle = "blue";

    ctx.startPath();

    ctx.arc(0,0,r,0, pi * 2, true);

    ctx.endPath();

    ctx.fill();

    ctx.restore();

  }

}

 

void clear() {

  ctx..fillStyle = "orange"

    ..fillRect(0,0,canvas.width, canvas.height);

}

 

clickEvent(MouseEvent event) {

  clear();

  var ball = Ball((event.client.x).toDouble(),(event.client.y).toDouble());

  Timer.periodic(Duration(milliseconds: 10), (timer){

  clear();

  ball.velocity();

  ball.drag();

  ball.gravity();

  ball.collisionCheck();

  ball.translate();

  });

}


 

void main() {

  canvas = querySelector('#canvas');

  ctx = canvas.getContext('2d');

  canvas.onClick.listen((MouseEvent e) => clickEvent(e));  

}
 


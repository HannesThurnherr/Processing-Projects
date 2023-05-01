class DiffEq {

  public float[] eq(float x, float y) {
    
    float distance_threshold = 1000; // Adjust this value to control the distance at which repulsion starts
    
    float dx = x - (mouseX-width/2);
    float dy = y + (mouseY-height/2);
    float distance = sqrt(dx * dx + dy * dy);
    //ATTRACTOR
    //float repulsion_strength = max(-30/sqrt(distance),-10);
    //REPULSOR
    float repulsion_strength = min(30/sqrt(distance),15);
    if (distance < distance_threshold) {
        float repulsion_factor = (distance_threshold - distance) / distance_threshold;
        x += repulsion_strength * repulsion_factor * dx / distance;
        y += repulsion_strength * repulsion_factor * dy / distance;
    }
    
    //float[] out = {x+y,y-x};
    
    //circle
    //float[] out = {x+(y*0.006*sin(frameCount/80.0)), y+(x*0.006*sin(frameCount/81.0))};
    
    //float[] out = {x+(y*0.01), y+(x*0.01)};
    //float[] out = {x/(0.999+(0.0001/exp(y/40))), y/(0.999+(0.0001/exp(x/60)))};
    //float[] out = {x*1.001+cos(frameCount/6)/10,y*1.001-(x*0.9)*0.01*(y*0.9)*0.003}; 
    //counterflowing streams
    float[] out = {x+0.5*(y*0.03), y+0.5*(10*cos(x/(20+abs(cos(frameCount/1000.0))*30))*cos(y/60))}; 
    
    
    
    
    
     // Adjust this value to control the strength of the repulsion effect

    
    //float[] out = {x + 0.5 * (y * 0.03), y + 0.5 * (2 * cos(x / (20 + abs(cos(frameCount / 300.0)) * 40)) * cos(y / 50))};
    

    
    
    
    
    
    //spirals in diamonds
    //float[] out = {x+sin(y/100)*4, y+cos(x/100)*4};
    //onion
    //float[] out = {x-0.00005*sq(y), y-0.00001*sq(x)};
    
    //Two colored perlin noise (reduce bg alpha)
    /**
    float angle = TWO_PI * noise(x / 50, y / 50); // Map the angle to a range of [0, 2*PI]
    float rawLength = noise(x / 50, y / 50, 1000);
    
    // Custom mapping function for length
    float length;
    if (rawLength < 0.5) {
      length = map(rawLength, 0, 0.5, 0.1, 1.5); // Short vectors (0.5 to 2)
    } else {
      length = map(rawLength, 0.5, 1, 6, 12); // Long vectors (4 to 8)
    }
    
    float[] out = {x + cos(angle) * length, y + sin(angle) * length};
    **/
    
    //Spiral pattern
    /**
    float r = sqrt(sq(x) + sq(y));
    float theta = atan2(y, x) + frameCount / 200;
    float[] out = {x + cos(theta) * r / 30, y + sin(theta) * r / 30};
    **/
    
    //Lissajous curve-like pattern:
    //float[] out = {x + sin(y / 30) * cos(frameCount / 300)*5, y + cos(x / 30) * sin(frameCount / 300)*5};

    //dynamic perlin noise field
    /**
    float angle = 2 * PI * noise(x / 50, y / 50, frameCount / 200);
    float length = map(noise(x / 50, y / 50, frameCount / 200 + 1000), 0, 1, 1, 5); // Adjust the range (1 to 5) for the desired vector length
    float[] out = {x + cos(angle) * length, y + sin(angle) * length};
    **/
    
    //Spiral
    //float[] out = {x + sin(sqrt(sq(x) + sq(y))/15), y - cos(sqrt(sq(x) + sq(y))/15)};
    
    
    
    //custom perlin noise
    
    float angle = map(noise(x / 50, y / 50), 0, 1, 0, TWO_PI);
    float rawLength = noise(x / 50, y / 50, 1000);
    
    // Custom sigmoid-like function for length
    float k = 10; // Adjust this value to control the sharpness of the transition between short and long vectors
    float sigmoidLength = 1 / (1 + exp(-k * (rawLength - 0.5)));
    
    // Map the sigmoid output to the desired length range
    float minLength = 0.5;
    float maxLength = 8;
    float length = map(sigmoidLength, 0, 1, minLength, maxLength);
    
    //perlin
    //float[] out = {x - sin(angle) * length+0.5 , y - cos(angle) * length-2};
    //perlin with added patterns
    //float[] out = {x - sin(angle) * length +(y*0.005), y - cos(angle) * length-(abs(x*0.005))};
    //perlin with added dynamic pattens
    //float[] out = {x - sin(angle) * length +(y*0.006*sin(frameCount/80.0)), y - cos(angle) * length-2-(x*0.006*sin(frameCount/70.0))};
    //perlin with added diamonds (dynamic)
    //float[] out = {x - sin(angle) * length * sin(frameCount/200.0) + sin(y/100.0)*4, y - (cos(angle) * length-2)* sin(frameCount/300.0) +cos(x/100.0)*4};
    

    return out;
  }
}

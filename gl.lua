--colors  

white = Color.new(255,255,255)
black = Color.new(0,0,0)
grey = Color.new(100,100,100)

red = Color.new(255,0,0)
green = Color.new(0,255,0)
blue = Color.new(0,0,255)
 
yellow = Color.new(255,255,0)
purple = Color.new(255,0,255)
bblue = Color.new(0,255,255)

lblue = Color.new(200,200,255)
dblue = Color.new(0,0,100)
orange = Color.new(255,100,100)

--functions

gl={}

function gl.createCursor(color)
cursori = Image.createEmpty(230,15)
cursori:drawLine(1,1,cursori:width(),1,color)
cursori:drawLine(1,cursori:height(),cursori:width(),cursori:height(),color)
cursori:drawLine(1,1,1,cursori:height(),color)
cursori:drawLine(cursori:width(),1,cursori:width(),cursori:height(),color)
return cursori
end






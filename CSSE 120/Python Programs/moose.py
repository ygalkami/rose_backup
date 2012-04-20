def mouseinput(window,board):
    ok=False
    while ok==False:
          point = window.getMouse()
          x1 = point.getX()
          y1 = point.getY()
          if x1<100 or x1>400 or y1<100 or y1>400:
              ok = True
    return point
